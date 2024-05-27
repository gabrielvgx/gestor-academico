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
  'SUPERVISOR',
  'teste@teste.com',
  '46070d4bf934fb0d4b06d9e2c46e346944e322444900a435d7d9a95e6d7435f5' -- teste
);
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
  'bc63637b-f4d5-4ddf-8465-9b63e1ad8b71',
  'Teste2',
  'TEACHER',
  'teste2@teste.com',
  '46070d4bf934fb0d4b06d9e2c46e346944e322444900a435d7d9a95e6d7435f5' -- teste
);
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
  'b2310879-047c-4f5c-801e-90fe18db6146',
  'Teste3',
  'KITCHEN',
  'teste3@teste.com',
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


INSERT INTO PLANEJAMENTO (STATUS, DTPLANO, IDESCOLA, IDTURMA, DSATIVIDADE, IDUSERINCLUSAO)
SELECT 
    'APROVADO',
    (
      ADDDATE('2024-01-01', 
      (FLOOR(RAND() * 52) * 7) + 
      (CASE WHEN WEEKDAY('2024-01-01') > 0 THEN 7 - WEEKDAY('2024-01-01') ELSE 0 END))
    ),  -- Data inicial aleatória nos últimos 10 dias
    1,  -- ID da escola fictícia
    FLOOR(RAND() * 5) + 1,  -- ID da turma fictícia (entre 1 e 5)
    CONCAT('Atividade ', FLOOR(RAND() * 100)),  -- Descrição da atividade fictícia
    '632d8eee-cc52-49ed-9338-939af6296880'
FROM 
    INFORMATION_SCHEMA.TABLES t1, INFORMATION_SCHEMA.TABLES t2
LIMIT 20;


/
INSERT INTO MATERIAL (NMMATERIAL, DSMATERIAL, IDUSERINCLUSAO) VALUES
('Lápis', 'Lápis de cor para desenhos', '632d8eee-cc52-49ed-9338-939af6296880'),
('Borracha', 'Borracha branca para apagar', '632d8eee-cc52-49ed-9338-939af6296880'),
('Caderno', 'Caderno de 100 folhas pautado', '632d8eee-cc52-49ed-9338-939af6296880'),
('Tesoura', 'Tesoura sem ponta para crianças', '632d8eee-cc52-49ed-9338-939af6296880'),
('Cola', 'Cola branca líquida 90g', '632d8eee-cc52-49ed-9338-939af6296880'),
('Régua', 'Régua plástica de 30 cm', '632d8eee-cc52-49ed-9338-939af6296880'),
('Mochila', 'Mochila escolar infantil', '632d8eee-cc52-49ed-9338-939af6296880'),
('Apontador', 'Apontador com depósito', '632d8eee-cc52-49ed-9338-939af6296880'),
('Canetinha', 'Canetinha hidrográfica 12 cores', '632d8eee-cc52-49ed-9338-939af6296880'),
('Lápis de cor', 'Lápis de cor 24 cores', '632d8eee-cc52-49ed-9338-939af6296880');

/