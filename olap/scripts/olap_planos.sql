CREATE TABLE FatosEntregaPlanos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_id INT,
    plano_id INT,
    status VARCHAR(255),
    FOREIGN KEY (data_id) REFERENCES DimData(id),
    FOREIGN KEY (plano_id) REFERENCES DimPlano(id)
);

CREATE TABLE DimData (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    mes INT,
    ano INT
);

CREATE TABLE DimPlano (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255)
);

INSERT INTO DimData (data, mes, ano) VALUES ('2024-01-01', 1, 2024), ('2024-02-01', 2, 2024);
INSERT INTO DimPlano (nome) VALUES ('Plano X'), ('Plano Y');

INSERT INTO FatosEntregaPlanos (data_id, plano_id, status)
VALUES (1, 1, 'Entregue no prazo'), (2, 2, 'Entregue atrasado');
