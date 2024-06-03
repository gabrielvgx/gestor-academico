<?php

namespace App\Util;

class Query {
  private static $data = [
    'mysql' => [
      'USER_EMAIL_PASSWORD' => "SELECT * FROM USUARIO WHERE EMAIL = ? AND PASSWORD = ?",
      'USER_EMAIL' => "SELECT * FROM USUARIO WHERE EMAIL = ?",
      'CREATE_USER' => "INSERT INTO USUARIO (ID, NMUSUARIO, CARGO, EMAIL, PASSWORD) VALUES (?, ?, ?, ?, ?)",
      'READ_USER' => <<<SQL
        SELECT
          U.ID,
          U.NMUSUARIO,
          U.EMAIL,
          CASE U.CARGO
            WHEN 'TEACHER' THEN 'Professor'
            WHEN 'SUPERVISOR' THEN 'Supervisor'
            WHEN 'KITCHEN' THEN 'Cozinha'
          END AS CARGO
        FROM
          USUARIO U
SQL,
      'USER_REDEFINE_PASSWORD' => "UPDATE USUARIO SET PASSWORD = ? WHERE ID = ?",
      'NUMBER_USER' => "SELECT COUNT(ID) QTUSER FROM USUARIO",
      'DSB_PLANNING' => <<<SQL
        WITH RECURSIVE dates AS (
          SELECT
            CAST(? AS DATE) AS data
          UNION ALL
          SELECT DATE_SUB(DATE_ADD(data, INTERVAL 7 DAY), INTERVAL WEEKDAY(DATE_ADD(data, INTERVAL 7 DAY)) DAY)
          FROM dates
          WHERE data <= ?
        )
        SELECT
          DATE_FORMAT(data, '%d/%m/%Y') AS DTINICIAL,
          P.ID,
          E.ID AS IDESCOLA,
          E.NMESCOLA,
          T.ID AS IDTURMA,
          T.NMTURMA,
          U.NMUSUARIO,
          CASE
            WHEN (P.STATUS IS NOT NULL AND P.STATUS = 'APROVADO')
            THEN
              CASE
                WHEN DATEDIFF(data, P.DTINCLUSAO) >= 3
                THEN 'ENTREGUE_NO_PRAZO'
                ELSE 'ENTREGUE_ATRASADO'
              END
            ELSE 'NAO_ENTREGUE'
          END STATUS
          FROM (
            SELECT data
            FROM dates
            WHERE DAYOFWEEK(data) = 2
            AND MONTH(data) >= MONTH(?)
            AND MONTH(data) <= MONTH(?)
        ) AS MONDAYS
        CROSS JOIN TURMA T
        INNER JOIN ESCOLA E
          ON E.ID = T.IDESCOLA
        LEFT JOIN PLANEJAMENTO P
          ON P.DTPLANO = data
          AND P.IDESCOLA = E.ID
          AND P.IDTURMA = T.ID
        LEFT JOIN USUARIO U
          ON P.IDUSERINCLUSAO = U.ID
        WHERE E.ID = ?
SQL,
      'READ_MATERIAL' => "SELECT ID, NMMATERIAL, DSMATERIAL FROM MATERIAL",
      'READ_SCHOOL' => <<<SQL
        SELECT
          E.ID,
          E.NMESCOLA
        FROM ESCOLA E
        INNER JOIN USUARIOINSTITUICAO UI
            ON E.ID = UI.IDESCOLA
        WHERE UI.IDUSUARIO = ?
        GROUP BY E.ID, E.NMESCOLA
SQL,
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
        LEFT JOIN TURMA T
          ON UI.IDESCOLA = T.IDESCOLA
          AND (UI.IDTURMA IS NULL) OR UI.IDTURMA = T.ID
        WHERE UI.IDUSUARIO = ?

SQL,
      'READ_CLASS' => "SELECT ID, NMTURMA FROM TURMA WHERE IDESCOLA = ?",
      'CREATE_USER_ORG' => "INSERT INTO USUARIOINSTITUICAO (IDUSUARIO, IDESCOLA, IDTURMA) VALUES (?, ?, ?)",
      'DELETE_USER' => "DELETE FROM USUARIO WHERE ID = ?",
      'COUNT_PENDING_PLANNING' => <<<SQL
        SELECT
          SUM(NRPLANEJAMENTO) AS NUM_PLANEJAMENTO
        FROM (
          SELECT
            COUNT(*) AS NRPLANEJAMENTO
          FROM
          PLANEJAMENTO P
          INNER JOIN USUARIOINSTITUICAO UI
            ON P.IDESCOLA = UI.IDESCOLA
            AND (UI.IDTURMA IS NULL OR P.IDTURMA = UI.IDTURMA)
            AND UI.IDUSUARIO = ?
          WHERE P.STATUS IN ('PENDENTE', 'REJEITADO')
          GROUP BY WEEK(P.DTPLANO)
        ) A
SQL,
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
      'PENDING_PLANNING' => <<<SQL
        SELECT
          PL.DTPLANO,
          PL.STATUS,
          E.ID AS IDESCOLA,
          E.NMESCOLA,
          T.ID AS IDTURMA,
          T.NMTURMA
        FROM
          USUARIOINSTITUICAO UI
          INNER JOIN PLANEJAMENTO PL
            ON UI.IDESCOLA = PL.IDESCOLA
            AND (UI.IDTURMA IS NULL OR UI.IDTURMA = PL.IDTURMA)
          INNER JOIN ESCOLA E
            ON PL.IDESCOLA = E.ID
          INNER JOIN TURMA T
            ON PL.IDTURMA = T.ID
        WHERE
          PL.STATUS IN ('PENDENTE', 'REJEITADO')
        ORDER BY
          PL.DTPLANO
SQL,
      'DETAIL_PLANNING' => <<<SQL
        SELECT
          DATE_FORMAT(PL.DTPLANO, '%d/%m/%Y') AS DTPLANO,
          PL.STATUS,
          PL.DSATIVIDADE,
          PL.DSRETORNO,
          PL.NRREVISOES,
          E.ID AS IDESCOLA,
          E.NMESCOLA,
          T.ID AS IDTURMA,
          T.NMTURMA,
          U.NMUSUARIO,
          PL.IDBNCC,
          TURNO.ID AS IDTURNO,
          TURNO.NMTURNO,
          GROUP_CONCAT(BNCC.CODBNCC SEPARATOR ';') AS CODBNCC
        FROM
          PLANEJAMENTO PL
          INNER JOIN ESCOLA E
            ON PL.IDESCOLA = E.ID
          INNER JOIN TURMA T
            ON PL.IDTURMA = T.ID
          INNER JOIN USUARIO U
            ON PL.IDUSERINCLUSAO = U.ID
          INNER JOIN BNCC
            ON INSTR(PL.IDBNCC, CONCAT(';', BNCC.ID, ';')) <> 0
          INNER JOIN TURNO
            ON PL.IDTURNO = TURNO.ID
        WHERE
          PL.IDESCOLA = ?
          AND PL.IDTURMA = ?
          AND (PL.DTPLANO BETWEEN ? AND ?)
        GROUP BY
          PL.ID
        ORDER BY
          PL.DTPLANO
SQL,
      'GET_PLANNING' => <<<SQL
        SELECT DISTINCT * FROM (
          SELECT
            P.IDESCOLA,
            P.IDTURMA,
            T.NMTURMA,
            P.STATUS,
            DATE_FORMAT(DTPLANO, '%d/%m/%Y') AS DTINICIAL,
            DATE_FORMAT(DATE_ADD(DTPLANO, INTERVAL 4 DAY), '%d/%m/%Y') AS DTFINAL,
            CONCAT_WS(' - ', DATE_FORMAT(DTPLANO, '%d/%m/%Y'), DATE_FORMAT(DATE_ADD(DTPLANO, INTERVAL 4 DAY), '%d/%m/%Y')) AS PERIODO,
            U.NMUSUARIO
          FROM
            PLANEJAMENTO P
            INNER JOIN USUARIO U
              ON P.IDUSERINCLUSAO = U.ID
            INNER JOIN TURMA T
            ON P.IDTURMA = T.ID
          WHERE
            P.IDESCOLA = ?
            AND MONTH(P.DTPLANO) = ?
            AND YEAR(P.DTPLANO) = ?
            AND WEEKDAY(P.DTPLANO) = 0
          ORDER BY
            P.IDTURMA ASC,
            P.DTPLANO ASC
        ) A
SQL,
      'GET_PLANNING_BY_USER' => <<<SQL
        SELECT DISTINCT * FROM (
          SELECT
            P.STATUS,
            DATE_FORMAT(P.DTPLANO, '%d/%m/%Y') AS DTINICIAL,
            DATE_FORMAT(DATE_ADD(P.DTPLANO, INTERVAL 4 DAY), '%d/%m/%Y') AS DTFINAL,
            CONCAT_WS(' - ', DATE_FORMAT(P.DTPLANO, '%d/%m/%Y'), DATE_FORMAT(DATE_ADD(P.DTPLANO, INTERVAL 4 DAY), '%d/%m/%Y')) AS PERIODO,
            E.ID AS IDESCOLA,
            E.NMESCOLA,
            T.ID AS IDTURMA,
            T.NMTURMA,
            P.DSRETORNO,
            P.IDBNCC
          FROM
            PLANEJAMENTO P
            INNER JOIN ESCOLA E
              ON P.IDESCOLA = E.ID
            INNER JOIN TURMA T
              ON P.IDESCOLA = T.IDESCOLA
              AND P.IDTURMA = T.ID
            WHERE
              P.IDESCOLA = ?
              AND MONTH(P.DTPLANO) = ?
              AND YEAR(P.DTPLANO) = ?
              AND P.IDUSERINCLUSAO = ?
              AND WEEKDAY(P.DTPLANO) = 0
            ORDER BY
              P.IDTURMA ASC,
              P.DTPLANO ASC
        ) A
SQL,
      'DELETE_MATERIAL' => <<<SQL
        DELETE FROM MATERIAL
        WHERE ID = ?
SQL,
      'READ_MATERIAL_COUNT' => 'SELECT COUNT(*) AS NRMATERIAL FROM MATERIAL',
      'CREATE_MATERIAL' => 'INSERT INTO MATERIAL (NMMATERIAL, DSMATERIAL, IDUSERINCLUSAO) VALUES (?, ?, ?)',
      'READ_MATERIAL_REQUEST' => <<<SQL
        SELECT
          RM.ID,
          RM.IDREQUISICAO,
          RM.QTMATERIAL,
          RM.DSJUSTIFICATIVA,
          RM.STATUS,
          DATE_FORMAT(RM.DTUTILIZACAO, '%d/%m/%Y') AS DTUTILIZACAO,
          DATE_FORMAT(RM.DTINCLUSAO, '%d/%m/%Y') AS DTINCLUSAO,
          U.NMUSUARIO,
          M.NMMATERIAL
        FROM
          REQUISICAOMATERIAL RM
          INNER JOIN MATERIAL M
            ON RM.IDMATERIAL = M.ID
          INNER JOIN USUARIO U
            ON U.ID = RM.IDUSERINCLUSAO
        WHERE
          RM.IDESCOLA = ?
          AND RM.IDUSERINCLUSAO = COALESCE(?, RM.IDUSERINCLUSAO)
        ORDER BY 
          FIELD(STATUS, 'PENDENTE', 'REPROVADO', 'APROVADO'),
          RM.ID DESC
SQL,
      'READ_MATERIAL_REQUEST_BY_ID' => <<<SQL
        SELECT
          RM.ID,
          RM.IDREQUISICAO,
          RM.QTMATERIAL,
          RM.DSJUSTIFICATIVA,
          RM.STATUS,
          RM.DSRETORNO,
          DATE_FORMAT(RM.DTUTILIZACAO, '%d/%m/%Y') AS DTUTILIZACAO,
          DATE_FORMAT(RM.DTINCLUSAO, '%d/%m/%Y') AS DTINCLUSAO,
          U.NMUSUARIO,
          M.ID AS IDMATERIAL,
          M.NMMATERIAL,
          E.ID AS IDESCOLA,
          E.NMESCOLA
        FROM
          REQUISICAOMATERIAL RM
          INNER JOIN MATERIAL M
            ON RM.IDMATERIAL = M.ID
          INNER JOIN USUARIO U
            ON U.ID = RM.IDUSERINCLUSAO
          INNER JOIN ESCOLA E
            ON RM.IDESCOLA = E.ID
        WHERE
          RM.IDREQUISICAO = ?
SQL,
      'READ_MATERIAL_REQUEST_COUNT' => <<<SQL
        SELECT
          COUNT(*) AS NUM_MATERIAL_REQUEST
        FROM (
          SELECT DISTINCT
            RM.ID
          FROM
            REQUISICAOMATERIAL RM
            INNER JOIN USUARIOINSTITUICAO UI
              ON RM.IDESCOLA = UI.IDESCOLA
          WHERE
            RM.STATUS = 'PENDENTE'
            AND UI.IDUSUARIO = ?
        ) A
SQL,
      'READ_PERIOD' => "SELECT ID, NMTURNO FROM TURNO",
      'READ_EDUCATION_TARGET' => <<<SQL
        SELECT
          BNCC.ID,
          BNCC.CODBNCC,
          CE.NMCAMPOEXP,
          FE.DSFAIXAETARIA,
          BNCC.DSOBJETIVO
        FROM BNCC
        INNER JOIN CAMPOEXPBNCC CE
          ON BNCC.IDCAMPOEXPBNCC = CE.ID
        INNER JOIN FAIXAETARIABNCC FE
          ON BNCC.IDFAIXAETARIABNCC = FE.ID
SQL,
      'CREATE_PLANNING' => <<<SQL
        INSERT INTO PLANEJAMENTO
        (STATUS, DTPLANO, IDESCOLA, IDTURMA, IDTURNO, DSATIVIDADE, IDBNCC, IDUSERINCLUSAO)
        VALUES
        (?, ?, ?, ?, ?, ?, ?, ?)
SQL,
      'EXISTS_PLANNING' => <<<SQL
        SELECT
          ID
        FROM
          PLANEJAMENTO
        WHERE IDESCOLA = ?
        AND IDTURMA = ?
        AND DTPLANO = ?
SQL,
      'CREATE_MATERIAL_REQUEST' => <<<SQL
        INSERT INTO REQUISICAOMATERIAL
        (IDREQUISICAO, IDMATERIAL, IDESCOLA, IDUSERINCLUSAO, STATUS, QTMATERIAL, DSJUSTIFICATIVA, DTUTILIZACAO)
        VALUES
        (?, ?, ?, ?, ?, ?, ?, ?)
SQL,
      'UPDATE_STATUS_MATERIAL_REQUEST' => <<<SQL
      UPDATE REQUISICAOMATERIAL
      SET
        STATUS = ?,
        DSRETORNO = ?
      WHERE IDREQUISICAO = ?
SQL,
      'READ_FOOD' => <<<SQL
        SELECT
          DATE_FORMAT(RA.DTREFEICAO, '%d/%m/%Y') AS DTREFEICAO,
          TR.NMREFEICAO,
          SUM(RA.COMENSAIS) AS COMENSAIS,
          ROUND(SUM(RA.SOBRALIMPA), 2) AS SOBRALIMPA,
          ROUND(SUM(RA.SOBRASUJA), 2) AS SOBRASUJA,
          ROUND(SUM(RA.RESTOINGESTA), 2) AS RESTOINGESTA
        FROM
          REGISTROALIMENTAR RA
          INNER JOIN TIPOREFEICAO TR
            ON RA.IDTIPOREFEICAO = TR.ID
        WHERE
          RA.IDESCOLA = ?
          AND MONTH(RA.DTREFEICAO) = ?
          AND YEAR(RA.DTREFEICAO) = ?
          AND RA.IDUSERINCLUSAO = COALESCE(?, RA.IDUSERINCLUSAO)
        GROUP BY
          RA.DTREFEICAO,
          TR.NMREFEICAO
SQL,
      'DSB_FOOD' => <<<SQL
        SELECT
          DATE_FORMAT(RA.DTREFEICAO, '%m/%Y') AS MES_ANO,
          ROUND(SUM(RA.SOBRALIMPA), 2) AS SOBRALIMPA,
          ROUND(SUM(RA.SOBRASUJA), 2) AS SOBRASUJA,
          ROUND(SUM(RA.RESTOINGESTA), 2) AS RESTOINGESTA
        FROM
          REGISTROALIMENTAR RA
        WHERE
          RA.IDESCOLA = ?
          AND RA.DTREFEICAO >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
        GROUP BY
          DATE_FORMAT(RA.DTREFEICAO, '%m/%Y')
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