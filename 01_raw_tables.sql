/* Criar tabelas BRUTAS (Raw Layer) */
DROP TABLE IF EXISTS faturamento_raw;
DROP TABLE IF EXISTS pesagem_raw;

CREATE TABLE faturamento_raw (
    id INTEGER,
    motorista TEXT,
    inicio TEXT,
    fim TEXT,
    valor TEXT
);

INSERT INTO faturamento_raw VALUES
(1, 'João Silva', '2025-01-10 08:00', '2025-01-10 08:10', 'R$ 1.250,00'),
(2, 'Maria Souza', '2025-01-10 09:15', '2025-01-10 09:27', '1.430,00'),
(3, 'Pedro Santos', '2025-01-10 10:00', '2025-01-10 10:08', 'R$950');

CREATE TABLE pesagem_raw (
    id INTEGER,
    placa TEXT,
    peso_bruto TEXT,
    peso_tara TEXT,
    peso_liquido TEXT
);

INSERT INTO pesagem_raw VALUES
(1, 'ABC1234', '59000kg', '18000', '41000kg'),
(2, 'BRZ9080', '62500KG', '20000KG', '42500Kg'),
(3, 'CRF2020', ' 58000 ', ' 19000 ', '39000');