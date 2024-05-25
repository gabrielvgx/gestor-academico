<?php

namespace App\Util;

class Query {
  private static $data = [
    'mysql' => [
      'USER_EMAIL_PASSWORD' => "SELECT * FROM USUARIO WHERE EMAIL = ? AND PASSWORD = ?",
      'USER_EMAIL' => "SELECT * FROM USUARIO WHERE EMAIL = ?",
      'CREATE_USER' => "INSERT INTO USUARIO (ID, NMUSUARIO, CARGO, EMAIL, PASSWORD) VALUES (?, ?, ?, ?, ?)",
      'READ_USER' => "SELECT * FROM USUARIO",
      'USER_REDEFINE_PASSWORD' => "UPDATE USUARIO SET PASSWORD = ? WHERE ID = ?",
      'NUMBER_USER' => "SELECT COUNT(ID) QTUSER FROM USUARIO",
      'DSB_PLANNING' => <<<SQL
        WITH RECURSIVE dates AS (
          SELECT
            CAST('2024-04-01' AS DATE) AS data
          UNION ALL
          SELECT DATE_SUB(DATE_ADD(data, INTERVAL 7 DAY), INTERVAL WEEKDAY(DATE_ADD(data, INTERVAL 7 DAY)) DAY)
          FROM dates
          WHERE data <= '2024-05-31'
        )
        SELECT
          data AS DTINICIALPLANO,
          PS.DTFINALPLANO,
          U.ID AS IDUSUARIO,
          U.NMUSUARIO,
          PS.ID AS IDPLANO,
          E.ID AS IDESCOLA,
          E.NMESCOLA,
          T.ID AS IDTURMA,
          T.NMTURMA,
          CASE
            WHEN (PS.STATUS IS NOT NULL AND PS.STATUS = 'Concluído')
            THEN
              CASE
                WHEN DATEDIFF(PS.DTINICIALPLANO, PS.DTINCLUSAO) >= 3
                THEN 'ENTREGUE_NO_PRAZO'
                ELSE 'ENTREGUE_ATRASADO'
              END
            ELSE 'NAO_ENTREGUE'
          END STATUS
        FROM (
            SELECT data
            FROM dates
            WHERE DAYOFWEEK(data) = 2
            AND MONTH(data) >= MONTH('2024-04-01')
            AND MONTH(data) <= MONTH('2024-05-31')
        ) AS MONDAYS
        CROSS JOIN USUARIOINSTITUICAO UI
        INNER JOIN USUARIO U
          ON UI.IDUSUARIO = U.ID
        INNER JOIN ESCOLA E
          ON UI.IDESCOLA = E.ID
        INNER JOIN TURMA T
          ON UI.IDESCOLA = T.IDESCOLA
            AND UI.IDTURMA = T.ID
        LEFT JOIN PLANEJAMENTOSEMANAL PS
          ON PS.IDUSERINCLUSAO = U.ID
          AND PS.DTINICIALPLANO = data
          AND PS.IDESCOLA = UI.IDESCOLA
          AND PS.IDTURMA = UI.IDTURMA
SQL,
      'READ_MATERIAL' => "SELECT ID, NMMATERIAL, DSMATERIAL FROM MATERIAL",
      'READ_SCHOOL' => "SELECT ID, NMESCOLA FROM ESCOLA",
      'READ_SCHOOL_AND_CLASS' => <<<SQL
        SELECT
          E.ID,
          E.NMESCOLA,
          T.ID AS IDTURMA,
          T.NMTURMA,
          UI.IDUSUARIO
        FROM USUARIOINSTITUICAO UI
        INNER JOIN ESCOLA E
          ON UI.IDESCOLA = E.ID
        INNER JOIN TURMA T
          ON UI.IDESCOLA = T.IDESCOLA
          AND (UI.IDTURMA IS NULL) OR UI.IDTURMA = T.ID
        WHERE UI.IDUSUARIO = ?

SQL,
      'READ_CLASS' => "SELECT ID, NMTURMA FROM TURMA WHERE IDESCOLA = ?",
      'CREATE_USER_ORG' => "INSERT INTO USUARIOINSTITUICAO (IDUSUARIO, IDESCOLA, IDTURMA) VALUES (?, ?, ?)",
      'DELETE_USER' => "DELETE FROM USUARIO WHERE ID = ?",
      'GET_SCHOOL_COUNT' => <<<SQL
        SELECT
          COUNT(*) AS COUNT
        FROM (
          SELECT DISTINCT
            IDESCOLA
          FROM
            USUARIOINSTITUICAO
          WHERE IDUSUARIO = ?
        ) A
        GROUP BY IDESCOLA
SQL,
    ],
  ];

  private static function getQueriesByDriver() {
    $driver = $_ENV['DB_DRIVER'];
    if (!$driver || !isset(Query::$data[$driver])) {
      throw new \Exception("Invalid DBDRIVER: $driver");
    }
    return Query::$data[$driver];
  }

  static function get($name) {
    return Query::getQueriesByDriver()[$name];
  }
}