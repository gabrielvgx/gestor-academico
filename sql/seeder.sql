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

INSERT INTO REQUISICAOMATERIAL (IDMATERIAL, IDESCOLA, IDUSERINCLUSAO, STATUS, DSJUSTIFICATIVA, DTUTILIZACAO)
VALUES
(1, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'PENDENTE', 'Material necessário para aula de artes.', '2024-06-01'),
(2, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'APROVADO', 'Uso em atividades de matemática.', '2024-06-02'),
(3, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'REPROVADO', 'Solicitação para projetos de ciências.', '2024-06-03'),
(4, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'PENDENTE', 'Necessário para educação física.', '2024-06-04'),
(5, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'APROVADO', 'Materiais de apoio para leitura.', '2024-06-05'),
(6, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'REPROVADO', 'Recurso audiovisual para aulas.', '2024-06-06'),
(7, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'PENDENTE', 'Material para trabalhos manuais.', '2024-06-07'),
(8, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'APROVADO', 'Uso em aulas de música.', '2024-06-08'),
(9, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'REPROVADO', 'Necessário para ensino de história.', '2024-06-09'),
(10, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'PENDENTE', 'Materiais para experimentos químicos.', '2024-06-10'),
(1, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'APROVADO', 'Uso em aulas de geografia.', '2024-06-11'),
(2, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'REPROVADO', 'Recurso didático para português.', '2024-06-12'),
(3, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'PENDENTE', 'Material de apoio para educação infantil.', '2024-06-13'),
(4, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'APROVADO', 'Uso em atividades de artes plásticas.', '2024-06-14'),
(5, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'REPROVADO', 'Solicitação para esportes.', '2024-06-15'),
(6, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'PENDENTE', 'Material de apoio para leitura.', '2024-06-16'),
(7, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'APROVADO', 'Uso em projetos de ciências.', '2024-06-17'),
(8, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'REPROVADO', 'Necessário para aula de música.', '2024-06-18'),
(9, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'PENDENTE', 'Solicitação para ensino de história.', '2024-06-19'),
(10, 1, '632d8eee-cc52-49ed-9338-939af6296880', 'APROVADO', 'Materiais para experiências químicas.', '2024-06-20');
