CREATE TABLE FatosSolicitacaoMateriais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_id INT,
    material_id INT,
    quantidade INT,
    FOREIGN KEY (data_id) REFERENCES DimData(id),
    FOREIGN KEY (material_id) REFERENCES DimMaterial(id)
);

CREATE TABLE DimData (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    mes INT,
    ano INT
);

CREATE TABLE DimMaterial (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255)
);

INSERT INTO DimData (data, mes, ano) VALUES ('2024-01-01', 1, 2024), ('2024-02-01', 2, 2024);
INSERT INTO DimMaterial (nome) VALUES ('Material A'), ('Material B');

INSERT INTO FatosSolicitacaoMateriais (data_id, material_id, quantidade)
VALUES (1, 1, 10), (2, 2, 20);
