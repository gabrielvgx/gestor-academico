"""
DAG de ETL para consolidar entrega de planejamentos
"""

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.mysql_operator import MySqlOperator
from airflow.operators.postgres_operator import PostgresOperator
from airflow.operators.python_operator import PythonOperator
from airflow.hooks.mysql_hook import MySqlHook
from airflow.hooks.postgres_hook import PostgresHook
import pandas as pd
import pprint
import uuid

def extract_from_mysql_and_load_to_postgres():
    mysql_hook = MySqlHook(mysql_conn_id='mysql_conn')
    postgres_hook = PostgresHook(postgres_conn_id='postgres_conn')

    # Extract data from MySQL
    planejamentos = mysql_hook.get_pandas_df("SELECT ID AS IDPLANO, STATUS, DTINICIALPLANO, DTFINALPLANO, IDESCOLA AS IDESCOLAPLANO, IDTURMA AS IDTURMAPLANO, MONTH(DTINICIALPLANO) AS MES, YEAR(DTFINALPLANO) AS ANO FROM PLANEJAMENTOSEMANAL")
    turmas = mysql_hook.get_pandas_df("SELECT ID AS IDTURMA, NMTURMA, DTINCLUSAO, IDESCOLA AS IDTURMAESCOLA FROM TURMA")
    escolas = mysql_hook.get_pandas_df("SELECT ID AS IDESCOLA, NMESCOLA FROM ESCOLA")

    # ETL
    # Merge data from planejamentos, turmas, and escolas
    merged_data = planejamentos.merge(turmas, left_on='IDTURMAPLANO', right_on='IDTURMA')
    merged_data = merged_data.merge(escolas, left_on='IDESCOLAPLANO', right_on='IDESCOLA')
    pprint.pprint(merged_data.columns)

    # Calculate metrics
    prazo_atraso_dias = 5  # Defina o prazo para considerar um planejamento como atrasado

    merged_data['DTINCLUSAO'] = pd.to_datetime(merged_data['DTINCLUSAO'])
    merged_data['DTINICIALPLANO'] = pd.to_datetime(merged_data['DTINICIALPLANO'])

    merged_data['STATUS'] = 'No prazo'
    merged_data.loc[(merged_data['DTINCLUSAO'] - merged_data['DTINICIALPLANO']).dt.days < -prazo_atraso_dias, 'STATUS'] = 'Atrasado'

    historico_entrega_plan = merged_data.groupby(['IDESCOLA', 'NMESCOLA', 'IDTURMA', 'NMTURMA', 'MES', 'ANO']).agg({
        'IDPLANO': 'count', # Quantidade total de planejamentos entregues
        'STATUS': lambda x: (x == 'Atrasado').sum(), # Quantidade de planejamentos atrasados
    }).reset_index()

    historico_entrega_plan['QTPLANATRASADO'] = historico_entrega_plan['STATUS']
    historico_entrega_plan['QTPLANENTR'] = historico_entrega_plan['IDPLANO']
    historico_entrega_plan['QTPLANNAOENTR'] = 0  # Defina como necessário, dependendo da lógica
    # historico_entrega_plan = historico_entrega_plan.drop(columns=['IDPLANO'])
    historico_entrega_plan['ID'] = [uuid.uuid4() for _ in range(len(historico_entrega_plan))]

    history_columns = ['ID', 'IDESCOLA', 'NMESCOLA', 'IDTURMA', 'NMTURMA', 'MES', 'ANO', 'QTPLANENTR', 'QTPLANATRASADO', 'QTPLANNAOENTR']
    historico_entrega_plan = historico_entrega_plan[history_columns]
    pprint.pprint(historico_entrega_plan.iloc[0])
    # Consolidate data and load into PostgreSQL
    postgres_hook.insert_rows(table="historicoentrplan", rows=historico_entrega_plan.values.tolist(), columns=history_columns)

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2024, 5, 4),
    'retries': 0,
}

with DAG('etl_entrplaneja_dag', default_args=default_args, schedule_interval='@daily') as dag:
    extract_task = PythonOperator(
        task_id='extract_from_mysql_and_load_to_postgres',
        python_callable=extract_from_mysql_and_load_to_postgres
    )
