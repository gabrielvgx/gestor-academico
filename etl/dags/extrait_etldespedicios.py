from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime
from airflow.hooks.postgres_hook import PostgresHook

def extrair_etl_desperdicio():
    # Conectar ao Supabase usando a conexão Postgres definida no Airflow
    supabase_conn_id = "supabase_conn"  # Nome da conexão definida no Airflow
    postgres_hook = PostgresHook(postgres_conn_id=supabase_conn_id)

    try:
        connection = postgres_hook.get_conn()
        cursor = connection.cursor()
        
        # Etapa ETL: Extração
        cursor.execute("""
            SELECT 
                TO_CHAR(DATE_TRUNC('month', DTINCLUSAO), 'Month YYYY') AS mes,
                SUM(CAST(SOBRALIMPA AS NUMERIC)),
                SUM(CAST(SOBRASUJA AS NUMERIC)),
                SUM(CAST(RESTOINJESTA AS NUMERIC))
            FROM 
                alimentacao 
            GROUP BY 
                mes
        """)
        results = cursor.fetchall()  # Obter todos os resultados
        
        print("Conexão com o Supabase estabelecida com sucesso!")
        print("Resultados da soma dos campos agrupados por mês:")
        
        for row in results:
            mes = row[0].strip()  # Remover espaços extras do nome do mês
            soma_sobra_limpa = row[1]
            soma_sobra_suja = row[2]
            soma_resto_injesta = row[3]
            
            print(f"Mês: {mes} | Soma SOBRALIMPA: {soma_sobra_limpa} | Soma SOBRASUJA: {soma_sobra_suja} | Soma RESTOINJESTA: {soma_resto_injesta}")
            
            # Verificar se o mês já existe na tabela desperdicio_alimentacao
            cursor.execute("""
                SELECT sobra_limpa, sobra_suja, restoinjesta 
                FROM desperdicio_alimentacao 
                WHERE mes = %s
            """, (mes,))
            existing_record = cursor.fetchone()
            
            if existing_record:
                # Somar os valores existentes aos novos valores
                nova_sobra_limpa = existing_record[0] + soma_sobra_limpa
                nova_sobra_suja = existing_record[1] + soma_sobra_suja
                novo_resto_injesta = existing_record[2] + soma_resto_injesta
                
                # Atualizar o registro existente
                update_query = """
                    UPDATE desperdicio_alimentacao 
                    SET sobra_limpa = %s, sobra_suja = %s, restoinjesta = %s 
                    WHERE mes = %s
                """
                cursor.execute(update_query, (nova_sobra_limpa, nova_sobra_suja, novo_resto_injesta, mes))
            else:
                # Inserir novo registro
                insert_query = """
                    INSERT INTO desperdicio_alimentacao (mes, sobra_limpa, sobra_suja, restoinjesta) 
                    VALUES (%s, %s, %s, %s)
                """
                cursor.execute(insert_query, (mes, soma_sobra_limpa, soma_sobra_suja, soma_resto_injesta))
        
        connection.commit()  # Commit da transação
        cursor.close()
        connection.close()
        print("Resultados inseridos/atualizados na tabela desperdicio_alimentacao com sucesso!")
    except Exception as e:
        print("Erro ao conectar ao Supabase:", str(e))

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2024, 5, 4),
    'retries': 0,
}

# Agendamento de execução Diário @daily
with DAG('extrair_etl_desperdicio', default_args=default_args, schedule_interval='@daily') as dag:
    extrair_etl_desperdicio_task = PythonOperator(
        task_id='extrair_etl_desperdicio',
        python_callable=extrair_etl_desperdicio
    )
