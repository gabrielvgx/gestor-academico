INSERT INTO `usuario`
(
  ID,
  NMUSUARIO,
  CARGO,
  EMAIL,
  PASSWORD
)
VALUES
(
  '632d8eee-cc52-49ed-9338-939af6296880',
  'Teste',
  'PROFESSOR',
  'teste@teste.com',
  '46070d4bf934fb0d4b06d9e2c46e346944e322444900a435d7d9a95e6d7435f5' -- teste
);

INSERT INTO ESCOLA (NMESCOLA, IDUSERINCLUSAO)
VALUES ('Escola Primária ABC', '632d8eee-cc52-49ed-9338-939af6296880');

INSERT INTO TURMA (NMTURMA, DTINCLUSAO, IDUSERINCLUSAO, IDESCOLA)
VALUES 
    ('Turma 1', NOW(), '632d8eee-cc52-49ed-9338-939af6296880', 1),
    ('Turma 2', NOW(), '632d8eee-cc52-49ed-9338-939af6296880', 1),
    ('Turma 3', NOW(), '632d8eee-cc52-49ed-9338-939af6296880', 1),
    ('Turma 4', NOW(), '632d8eee-cc52-49ed-9338-939af6296880', 1),
    ('Turma 5', NOW(), '632d8eee-cc52-49ed-9338-939af6296880', 1);


INSERT INTO PLANEJAMENTOSEMANAL (STATUS, DTINICIALPLANO, DTFINALPLANO, IDESCOLA, IDTURMA, DSATIVIDADE, IDUSERINCLUSAO)
SELECT 
    'Concluído',
    NOW() - INTERVAL FLOOR(RAND() * 10) DAY,  -- Data inicial aleatória nos últimos 10 dias
    NOW() + INTERVAL FLOOR(RAND() * 20) DAY,  -- Data final aleatória nos próximos 20 dias
    1,  -- ID da escola fictícia
    FLOOR(RAND() * 5) + 1,  -- ID da turma fictícia (entre 1 e 5)
    CONCAT('Atividade ', FLOOR(RAND() * 100)),  -- Descrição da atividade fictícia
    '632d8eee-cc52-49ed-9338-939af6296880'
FROM 
    INFORMATION_SCHEMA.TABLES t1, INFORMATION_SCHEMA.TABLES t2
LIMIT 20;