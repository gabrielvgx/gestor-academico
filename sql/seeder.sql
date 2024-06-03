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
  '75e4f0a9-7a12-4806-887f-2e390d483da3',
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
(1, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 'Material necessário para aula de artes.', '2024-06-01'),
(2, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 'Uso em atividades de matemática.', '2024-06-02'),
(3, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 'Solicitação para projetos de ciências.', '2024-06-03'),
(4, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 'Necessário para educação física.', '2024-06-04'),
(5, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 'Materiais de apoio para leitura.', '2024-06-05'),
(6, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 'Recurso audiovisual para aulas.', '2024-06-06'),
(7, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 'Material para trabalhos manuais.', '2024-06-07'),
(8, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 'Uso em aulas de música.', '2024-06-08'),
(9, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 'Necessário para ensino de história.', '2024-06-09'),
(10, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 'Materiais para experimentos químicos.', '2024-06-10'),
(1, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 'Uso em aulas de geografia.', '2024-06-11'),
(2, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 'Recurso didático para português.', '2024-06-12'),
(3, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 'Material de apoio para educação infantil.', '2024-06-13'),
(4, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 'Uso em atividades de artes plásticas.', '2024-06-14'),
(5, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 'Solicitação para esportes.', '2024-06-15'),
(6, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 'Material de apoio para leitura.', '2024-06-16'),
(7, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 'Uso em projetos de ciências.', '2024-06-17'),
(8, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 'Necessário para aula de música.', '2024-06-18'),
(9, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 'Solicitação para ensino de história.', '2024-06-19'),
(10, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 'Materiais para experiências químicas.', '2024-06-20');

/


INSERT INTO REGISTROALIMENTAR (DTREFEICAO, IDTIPOREFEICAO, IDFAIXAETARIA, REPETICAO, SOBRALIMPA, SOBRASUJA, RESTOINGESTA, IDESCOLA, IDUSERINCLUSAO)
VALUES 
('2024-01-15', 1, 1, 3, 5.5, 4.3, 6.2, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-02-10', 2, 2, 2, 3.7, 5.1, 4.8, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-03-20', 3, 3, 4, 2.1, 1.9, 7.3, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-04-05', 4, 1, 0, 8.4, 2.2, 5.5, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-05-18', 5, 2, 1, 6.5, 7.8, 3.9, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-06-22', 6, 3, 3, 4.3, 3.7, 2.6, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-07-14', 7, 1, 6, 7.2, 6.6, 8.1, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-08-29', 8, 2, 5, 5.1, 8.3, 1.2, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-09-11', 9, 3, 4, 1.9, 2.4, 4.4, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-10-08', 10, 1, 0, 6.3, 5.5, 7.6, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-11-25', 1, 2, 3, 4.6, 7.7, 5.9, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-12-19', 2, 3, 1, 9.8, 1.1, 3.5, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-01-30', 3, 1, 5, 2.7, 6.4, 6.1, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-02-27', 4, 2, 2, 5.9, 3.2, 4.2, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-03-15', 5, 3, 6, 4.8, 9.0, 8.4, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-04-12', 6, 1, 1, 3.6, 4.1, 7.7, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-05-27', 7, 2, 4, 8.9, 5.3, 2.8, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-06-30', 8, 3, 0, 1.5, 2.6, 6.9, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-07-23', 9, 1, 3, 6.7, 7.5, 4.0, 1, 'b2310879-047c-4f5c-801e-90fe18db6146'),
('2024-08-15', 10, 2, 2, 5.4, 3.8, 8.2, 1, 'b2310879-047c-4f5c-801e-90fe18db6146');

/
INSERT INTO TURNO (NMTURNO)
VALUES
('Manhã 08:30 - 11:00'),
('Tarde 13:00 - 16:00')
/
INSERT INTO PLANEJAMENTO (IDTURNO, STATUS, DTPLANO, IDBNCC, IDESCOLA, IDTURMA, DSATIVIDADE, DSRETORNO, IDUSERINCLUSAO)
VALUES
    (1, 'APROVADO', '2024-06-03', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-04', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-05', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-06', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-07', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-10', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-11', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-12', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-13', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-14', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-17', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-18', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-19', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-20', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-21', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-24', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-25', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-26', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-27', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-28', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-03', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-04', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-05', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-06', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-07', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-10', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-11', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-12', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-13', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-14', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-17', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-18', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-19', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-20', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-21', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-24', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-25', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-26', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-27', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-28', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-03', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-04', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-05', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-06', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-07', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-10', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-11', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-12', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-13', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-14', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-17', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 3', 'Motivo da rejeição para Semana 3', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-18', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 3', 'Motivo da rejeição para Semana 3', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-19', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 3', 'Motivo da rejeição para Semana 3', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-20', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 3', 'Motivo da rejeição para Semana 3', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-21', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 3', 'Motivo da rejeição para Semana 3', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-24', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-25', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-26', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-27', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-28', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-03', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-04', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-05', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-06', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-07', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-10', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-11', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-12', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-13', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-14', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-17', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-18', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-19', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-20', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-21', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-24', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-25', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-26', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-27', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-28', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-03', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-04', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-05', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-06', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-07', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-10', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-11', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-12', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-13', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'PENDENTE', '2024-06-14', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-17', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-18', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-19', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-20', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'APROVADO', '2024-06-21', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-24', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-25', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-26', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-27', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (1, 'REJEITADO', '2024-06-28', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-03', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-04', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-05', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-06', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-07', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-10', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-11', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-12', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-13', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-14', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-17', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-18', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-19', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-20', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-21', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-24', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-25', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-26', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-27', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-28', ';1;2;3;', 1, 1, 'Atividade para Turma 1 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-03', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-04', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-05', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-06', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-07', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-10', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-11', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-12', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-13', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-14', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-17', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-18', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-19', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-20', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-21', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-24', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-25', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-26', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-27', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-28', ';1;2;3;', 1, 2, 'Atividade para Turma 2 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-03', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-04', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-05', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-06', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-07', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-10', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-11', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-12', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-13', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-14', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-17', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 3', 'Motivo da rejeição para Semana 3', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-18', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 3', 'Motivo da rejeição para Semana 3', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-19', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 3', 'Motivo da rejeição para Semana 3', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-20', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 3', 'Motivo da rejeição para Semana 3', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-21', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 3', 'Motivo da rejeição para Semana 3', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-24', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-25', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-26', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-27', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-28', ';1;2;3;', 1, 3, 'Atividade para Turma 3 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-03', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-04', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-05', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-06', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-07', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 1', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-10', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-11', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-12', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-13', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-14', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 2', 'Motivo da rejeição para Semana 2', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-17', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-18', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-19', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-20', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-21', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-24', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-25', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-26', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-27', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-28', ';1;2;3;', 1, 4, 'Atividade para Turma 4 - Semana 4', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-03', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-04', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-05', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-06', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-07', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 1', 'Motivo da rejeição para Semana 1', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-10', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-11', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-12', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-13', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'PENDENTE', '2024-06-14', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 2', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-17', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-18', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-19', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-20', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'APROVADO', '2024-06-21', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 3', NULL, '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-24', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-25', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-26', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-27', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3'),
    (2, 'REJEITADO', '2024-06-28', ';1;2;3;', 1, 5, 'Atividade para Turma 5 - Semana 4', 'Motivo da rejeição para Semana 4', '75e4f0a9-7a12-4806-887f-2e390d483da3');   
    /
INSERT INTO CAMPOEXPBNCC
(NMCAMPOEXP)
VALUES
('Traços, sons, cores e formas'),
('O eu, o outro e o nós'),
('Corpo, gestos e movimentos'),
('Escuta, fala, pensamento e imaginação'),
('Espaços, tempos, quantidades, relações e transformações')

/

INSERT INTO FAIXAETARIABNCC
(DSFAIXAETARIA)
VALUES
('Bebês (zero a 1 ano e 6 meses)'),
('Crianças bem pequenas (1 ano e 7 meses a 3 anos e 11 meses)'),
('Crianças pequenas (4 anos a 5 anos e 11 meses)')

/

INSERT INTO BNCC (CODBNCC, IDCAMPOEXPBNCC, DSOBJETIVO, IDFAIXAETARIABNCC) VALUES
('EI01TS01', 1, 'Explorar sons produzidos com o próprio corpo e com objetos do ambiente.', 1),
('EI02TS01', 1, 'Criar sons com materiais, objetos e instrumentos musicais, para acompanhar diversos ritmos de música.', 2),
('EI03TS01', 1, 'Utilizar sons produzidos por materiais, objetos e instrumentos musicais durante brincadeiras de faz de conta, encenações, criações musicais, festas.', 3),
('EI01TS02', 1, 'Traçar marcas gráficas, em diferentes suportes, usando instrumentos riscantes e tintas.', 1),
('EI02TS02', 1, 'Utilizar materiais variados com possibilidades de manipulação (argila, massa de modelar), explorando cores, texturas, superfícies, planos, formas e volumes ao criar objetos tridimensionais.', 2),
('EI03TS02', 1, 'Expressar-se livremente por meio de desenho, pintura, colagem, dobradura e escultura, criando produções bidimensionais e tridimensionais.', 3),
('EI01TS03', 1, 'Explorar diferentes fontes sonoras e materiais para acompanhar brincadeiras cantadas, canções, músicas e melodias.', 1),
('EI02TS03', 1, 'Utilizar diferentes fontes sonoras disponíveis no ambiente em brincadeiras cantadas, canções, músicas e melodias.', 2),
('EI03TS03', 1, 'Reconhecer as qualidades do som (intensidade, duração, altura e timbre), utilizando-as em suas produções sonoras e ao ouvir músicas e sons.', 3);

/
INSERT INTO BNCC (CODBNCC, IDCAMPOEXPBNCC, DSOBJETIVO, IDFAIXAETARIABNCC) VALUES
('EI01EO01', 2, 'Perceber que suas ações têm efeitos nas outras crianças e nos adultos.', 1),
('EI01EO02', 2, 'Perceber as possibilidades e os limites de seu corpo nas brincadeiras e interações das quais participa.', 1),
('EI01EO03', 2, 'Interagir com crianças da mesma faixa etária e adultos ao explorar espaços, materiais, objetos, brinquedos.', 1),
('EI01EO04', 2, 'Comunicar necessidades, desejos e emoções, utilizando gestos, balbucios, palavras.', 1),
('EI01EO05', 2, 'Reconhecer seu corpo e expressar suas sensações em momentos de alimentação, higiene, brincadeira e descanso.', 1),
('EI01EO06', 2, 'Interagir com outras crianças da mesma faixa etária e adultos, adaptando-se ao convívio social.', 1),
('EI02EO01', 2, 'Demonstrar atitudes de cuidado e solidariedade na interação com crianças e adultos.', 2),
('EI02EO02', 2, 'Demonstrar imagem positiva de si e confiança em sua capacidade para enfrentar dificuldades e desafios.', 2),
('EI02EO03', 2, 'Compartilhar os objetos e os espaços com crianças da mesma faixa etária e adultos.', 2),
('EI02EO04', 2, 'Comunicar-se com os colegas e os adultos, buscando compreendê-los e fazendo-se compreender.', 2),
('EI02EO05', 2, 'Perceber que as pessoas têm características físicas diferentes, respeitando essas diferenças.', 2),
('EI02EO06', 2, 'Respeitar regras básicas de convívio social nas interações e brincadeiras.', 2),
('EI02EO07', 2, 'Resolver conflitos nas interações e brincadeiras, com a orientação de um adulto.', 2),
('EI03EO01', 2, 'Demonstrar empatia pelos outros, percebendo que as pessoas têm diferentes sentimentos, necessidades e maneiras de pensar e agir.', 3),
('EI03EO02', 2, 'Agir de maneira independente, com confiança em suas capacidades, reconhecendo suas conquistas e limitações.', 3),
('EI03EO03', 2, 'Ampliar as relações interpessoais, desenvolvendo atitudes de participação e cooperação.', 3),
('EI03EO04', 2, 'Comunicar suas ideias e sentimentos a pessoas e grupos diversos.', 3),
('EI03EO05', 2, 'Demonstrar valorização das características de seu corpo e respeitar as características dos outros (crianças e adultos) com os quais convive.', 3),
('EI03EO06', 2, 'Manifestar interesse e respeito por diferentes culturas e modos de vida.', 3),
('EI03EO07', 2, 'Usar estratégias pautadas no respeito mútuo para lidar com conflitos nas interações com crianças e adultos.', 3);

/

INSERT INTO BNCC (CODBNCC, IDCAMPOEXPBNCC, DSOBJETIVO, IDFAIXAETARIABNCC) VALUES
-- Crianças pequenas (4 anos a 5 anos e 11 meses)
('EI03CG01', 3, 'Criar com o corpo formas diversificadas de expressão de sentimentos, sensações e emoções, tanto nas situações do cotidiano quanto em brincadeiras, dança, teatro, música.', 3),
('EI03CG02', 3, 'Demonstrar controle e adequação do uso de seu corpo em brincadeiras e jogos, escuta e reconto de histórias, atividades artísticas, entre outras possibilidades.', 3),
('EI03CG03', 3, 'Criar movimentos, gestos, olhares e mímicas em brincadeiras, jogos e atividades artísticas como dança, teatro e música.', 3),
('EI03CG04', 3, 'Adotar hábitos de autocuidado relacionados a higiene, alimentação, conforto e aparência.', 3),
('EI03CG05', 3, 'Coordenar suas habilidades manuais no atendimento adequado a seus interesses e necessidades em situações diversas.', 3),
('EI02CG01', 3, 'Apropriar-se de gestos e movimentos de sua cultura no cuidado de si e nos jogos e brincadeiras.', 2),
('EI02CG02', 3, 'Deslocar seu corpo no espaço, orientando-se por noções como em frente, atrás, no alto, embaixo, dentro, fora etc., ao se envolver em brincadeiras e atividades de diferentes naturezas.', 2),
('EI02CG03', 3, 'Explorar formas de deslocamento no espaço (pular, saltar, dançar), combinando movimentos e seguindo orientações.', 2),
('EI02CG04', 3, 'Demonstrar progressiva independência no cuidado do seu corpo.', 2),
('EI02CG05', 3, 'Desenvolver progressivamente as habilidades manuais, adquirindo controle para desenhar, pintar, rasgar, folhear, entre outros.', 2),
('EI01CG01', 3, 'Movimentar as partes do corpo para exprimir corporalmente emoções, necessidades e desejos.', 1),
('EI01CG02', 3, 'Experimentar as possibilidades corporais nas brincadeiras e interações em ambientes acolhedores e desafiantes.', 1),
('EI01CG03', 3, 'Imitar gestos e movimentos de outras crianças, adultos e animais.', 1),
('EI01CG04', 3, 'Participar do cuidado do seu corpo e da promoção do seu bem-estar.', 1),
('EI01CG05', 3, 'Utilizar os movimentos de preensão, encaixe e lançamento, ampliando suas possibilidades de manuseio de diferentes materiais e objetos.', 1);

/

INSERT INTO BNCC (CODBNCC, IDCAMPOEXPBNCC, DSOBJETIVO, IDFAIXAETARIABNCC) VALUES
('EI01EF01', 4, 'Reconhecer quando é chamado por seu nome e reconhecer os nomes de pessoas com quem convive.', 1),
('EI01EF02', 4, 'Demonstrar interesse ao ouvir a leitura de poemas e a apresentação de músicas.', 1),
('EI01EF03', 4, 'Demonstrar interesse ao ouvir histórias lidas ou contadas, observando ilustrações e os movimentos de leitura do adulto-leitor (modo de segurar o portador e de virar as páginas).', 1),
('EI01EF04', 4, 'Reconhecer elementos das ilustrações de histórias, apontando-os, a pedido do adulto-leitor.', 1),
('EI01EF05', 4, 'Imitar as variações de entonação e gestos realizados pelos adultos, ao ler histórias e ao cantar.', 1),
('EI01EF06', 4, 'Comunicar-se com outras pessoas usando movimentos, gestos, balbucios, fala e outras formas de expressão.', 1),
('EI01EF07', 4, 'Conhecer e manipular materiais impressos e audiovisuais em diferentes portadores (livro, revista, gibi, jornal, cartaz, CD, tablet etc.).', 1),
('EI01EF08', 4, 'Participar de situações de escuta de textos em diferentes gêneros textuais (poemas, fábulas, contos, receitas, quadrinhos, anúncios etc.).', 1),
('EI01EF09', 4, 'Conhecer e manipular diferentes instrumentos e suportes de escrita.', 1),
('EI02EF01', 4, 'Dialogar com crianças e adultos, expressando seus desejos, necessidades, sentimentos e opiniões.', 2),
('EI02EF02', 4, 'Identificar e criar diferentes sons e reconhecer rimas e aliterações em cantigas de roda e textos poéticos.', 2),
('EI02EF03', 4, 'Demonstrar interesse e atenção ao ouvir a leitura de histórias e outros textos, diferenciando escrita de ilustrações, e acompanhando, com orientação do adulto-leitor, a direção da leitura (de cima para baixo, da esquerda para a direita).', 2),
('EI02EF04', 4, 'Formular e responder perguntas sobre fatos da história narrada, identificando cenários, personagens e principais acontecimentos.', 2),
('EI02EF05', 4, 'Relatar experiências e fatos acontecidos, histórias ouvidas, filmes ou peças teatrais assistidos etc.', 2),
('EI02EF06', 4, 'Criar e contar histórias oralmente, com base em imagens ou temas sugeridos.', 2),
('EI02EF07', 4, 'Manusear diferentes portadores textuais, demonstrando reconhecer seus usos sociais.', 2),
('EI02EF08', 4, 'Manipular textos e participar de situações de escuta para ampliar seu contato com diferentes gêneros textuais (parlendas, histórias de aventura, tirinhas, cartazes de sala, cardápios, notícias etc.).', 2),
('EI02EF09', 4, 'Manusear diferentes instrumentos e suportes de escrita para desenhar, traçar letras e outros sinais gráficos.', 2),
('EI03EF01', 4, 'Expressar ideias, desejos e sentimentos sobre suas vivências, por meio da linguagem oral e escrita (escrita espontânea), de fotos, desenhos e outras formas de expressão.', 3),
('EI03EF02', 4, 'Inventar brincadeiras cantadas, poemas e canções, criando rimas, aliterações e ritmos.', 3),
('EI03EF03', 4, 'Escolher e folhear livros, procurando orientar-se por temas e ilustrações e tentando identificar palavras conhecidas.', 3),
('EI03EF04', 4, 'Recontar histórias ouvidas e planejar coletivamente roteiros de vídeos e de encenações, definindo os contextos, os personagens, a estrutura da história.', 3),
('EI03EF05', 4, 'Recontar histórias ouvidas para produção de reconto escrito, tendo o professor como escriba.', 3),
('EI03EF06', 4, 'Produzir suas próprias histórias orais e escritas (escrita espontânea), em situações com função social significativa.', 3),
('EI03EF07', 4, 'Levantar hipóteses sobre gêneros textuais veiculados em portadores conhecidos, recorrendo a estratégias de observação gráfica e/ou de leitura.', 3),
('EI03EF08', 4, 'Selecionar livros e textos de gêneros conhecidos para a leitura de um adulto e/ou para sua própria leitura (partindo de seu repertório sobre esses textos, como a recuperação pela memória, pela leitura das ilustrações etc.).', 3),
('EI03EF09', 4, 'Levantar hipóteses em relação à linguagem escrita, realizando registros de palavras e textos, por meio de escrita espontânea.', 3);

/

INSERT INTO BNCC (CODBNCC, IDCAMPOEXPBNCC, DSOBJETIVO, IDFAIXAETARIABNCC) VALUES
('EI01ET01', 5, 'Explorar e descobrir as propriedades de objetos e materiais (odor, cor, sabor, temperatura).', 1),
('EI01ET02', 5, 'Explorar relações de causa e efeito (transbordar, tingir, misturar, mover e remover etc.) na interação com o mundo físico.', 1),
('EI01ET03', 5, 'Explorar o ambiente pela ação e observação, manipulando, experimentando e fazendo descobertas.', 1),
('EI01ET04', 5, 'Manipular, experimentar, arrumar e explorar o espaço por meio de experiências de deslocamentos de si e dos objetos.', 1),
('EI01ET05', 5, 'Manipular materiais diversos e variados para comparar as diferenças e semelhanças entre eles.', 1),
('EI01ET06', 5, 'Vivenciar diferentes ritmos, velocidades e fluxos nas interações e brincadeiras (em danças, balanços, escorregadores etc.).', 1),
('EI02ET01', 5, 'Explorar e descrever semelhanças e diferenças entre as características e propriedades dos objetos (textura, massa, tamanho).', 2),
('EI02ET02', 5, 'Observar, relatar e descrever incidentes do cotidiano e fenômenos naturais (luz solar, vento, chuva etc.).', 2),
('EI02ET03', 5, 'Compartilhar, com outras crianças, situações de cuidado de plantas e animais nos espaços da instituição e fora dela.', 2),
('EI02ET04', 5, 'Identificar relações espaciais (dentro e fora, em cima, embaixo, acima, abaixo, entre e do lado) e temporais (antes, durante e depois).', 2),
('EI02ET05', 5, 'Classificar objetos, considerando determinado atributo (tamanho, peso, cor, forma etc.).', 2),
('EI02ET06', 5, 'Utilizar conceitos básicos de tempo (agora, antes, durante, depois, ontem, hoje, amanhã, lento, rápido, depressa, devagar).', 2),
('EI02ET07', 5, 'Contar oralmente objetos, pessoas, livros etc., em contextos diversos.', 2),
('EI02ET08', 5, 'Registrar com números a quantidade de crianças (meninas e meninos, presentes e ausentes) e a quantidade de objetos da mesma natureza (bonecas, bolas, livros etc.).', 2),
('EI03ET01', 5, 'Estabelecer relações de comparação entre objetos, observando suas propriedades.', 3),
('EI03ET02', 5, 'Observar e descrever mudanças em diferentes materiais, resultantes de ações sobre eles, em experimentos envolvendo fenômenos naturais e artificiais.', 3),
('EI03ET03', 5, 'Identificar e selecionar fontes de informações, para responder a questões sobre a natureza, seus fenômenos, sua conservação.', 3),
('EI03ET04', 5, 'Registrar observações, manipulações e medidas, usando múltiplas linguagens (desenho, registro por números ou escrita espontânea), em diferentes suportes.', 3),
('EI03ET05', 5, 'Classificar objetos e figuras de acordo com suas semelhanças e diferenças.', 3),
('EI03ET06', 5, 'Relatar fatos importantes sobre seu nascimento e desenvolvimento, a história dos seus familiares e da sua comunidade.', 3),
('EI03ET07', 5, 'Relacionar números às suas respectivas quantidades e identificar o antes, o depois e o entre em uma sequência.', 3),
('EI03ET08', 5, 'Expressar medidas (peso, altura etc.), construindo gráficos básicos.', 3);


/
INSERT INTO REQUISICAOMATERIAL (IDREQUISICAO, IDESCOLA, IDMATERIAL, IDUSERINCLUSAO, STATUS, QTMATERIAL, DSJUSTIFICATIVA, DTUTILIZACAO) VALUES
('19c13fae-2112-11ef-b8ff-00155de2fde7', 1, 2, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 5, 'Necessidade de papel A4 para atividades escolares.', '2024-09-01')
/

INSERT INTO REQUISICAOMATERIAL (IDREQUISICAO, IDESCOLA, IDMATERIAL, IDUSERINCLUSAO, STATUS, QTMATERIAL, DSJUSTIFICATIVA, DTUTILIZACAO) VALUES
(UUID(), 1, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 10, 'Necessidade de papel A4 para atividades escolares.', '2024-09-01'),
(UUID(), 1, 2, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 5, 'Canetas coloridas para atividades artísticas.', '2024-09-01'),
(UUID(), 1, 3, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 7, 'Tesouras sem ponta para segurança das crianças.', '2024-09-01'),
(UUID(), 1, 4, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 12, 'Cola branca para trabalhos manuais.', '2024-08-15'),
(UUID(), 1, 5, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 20, 'Lápis de cor para atividades de desenho.', '2024-08-15'),
(UUID(), 1, 6, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 15, 'Papéis coloridos para origami.', '2024-08-15'),
(UUID(), 1, 7, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 8, 'Canetinhas hidrocor para ilustração.', '2024-10-20'),
(UUID(), 1, 8, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 6, 'Pinceis de pintura para aquarela.', '2024-10-20'),
(UUID(), 1, 9, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 4, 'Cadernos de desenho para atividades livres.', '2024-10-20'),
(UUID(), 1, 10, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 3, 'Tintas guache para pintura em papel.', '2024-11-05'),
(UUID(), 1, 11, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 9, 'Papel kraft para artesanato.', '2024-11-05'),
(UUID(), 1, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 14, 'Folhas sulfite para impressões.', '2024-12-01'),
(UUID(), 1, 2, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 5, 'Grampeadores para atividades de papel.', '2024-12-01'),
(UUID(), 1, 3, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 3, 'Régua para atividades de desenho técnico.', '2024-12-01'),
(UUID(), 1, 4, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 10, 'Fitas adesivas para colagem em papel.', '2024-07-15'),
(UUID(), 1, 5, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 8, 'Marcadores permanentes para trabalhos.', '2024-07-15'),
(UUID(), 1, 6, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 12, 'Apontadores de lápis para sala de aula.', '2024-07-15'),
(UUID(), 1, 7, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 6, 'Quadros brancos para uso em sala.', '2024-08-25'),
(UUID(), 1, 8, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 7, 'Papelão para maquetes escolares.', '2024-08-25'),
(UUID(), 1, 9, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 2, 'Caixas organizadoras para materiais.', '2024-08-25'),
(UUID(), 1, 10, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 9, 'Tintas de quadro branco.', '2024-09-10'),
(UUID(), 1, 11, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 3, 'Fita crepe para demarcação.', '2024-09-10'),
(UUID(), 1, 1, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 5, 'Copos descartáveis para eventos.', '2024-09-10'),
(UUID(), 1, 2, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 4, 'Pranchetas para desenho.', '2024-10-01'),
(UUID(), 1, 3, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 7, 'Papel vegetal para traçados.', '2024-10-01'),
(UUID(), 1, 4, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'REPROVADO', 8, 'Estiletes para corte de papel.', '2024-10-01'),
(UUID(), 1, 5, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 6, 'Pasta suspensa para organização.', '2024-11-15'),
(UUID(), 1, 6, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 9, 'Caixas de arquivo.', '2024-11-15'),
(UUID(), 1, 7, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'PENDENTE', 11, 'Papelão corrugado.', '2024-11-15'),
(UUID(), 1, 8, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 3, 'Bloco de anotações.', '2024-12-20'),
(UUID(), 1, 9, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 2, 'Etiqueta adesiva.', '2024-12-20'),
(UUID(), 1, 10, '75e4f0a9-7a12-4806-887f-2e390d483da3', 'APROVADO', 4, 'Lápis grafite.', '2024-12-20');