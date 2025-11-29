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

/* TRANSFORMAR (limpando e padronizando) */
DROP TABLE IF EXISTS faturamento_tratado;

CREATE TABLE faturamento_tratado AS
SELECT
    id,
    motorista,
    datetime(inicio) AS inicio,
    datetime(fim) AS fim,
    CAST(
        REPLACE(
            REPLACE(
                REPLACE(valor, 'R$', ''), 
            '.', ''), 
        ',', '.') AS REAL
    ) AS valor_corrigido,
    (strftime('%s', fim) - strftime('%s', inicio)) / 60.0 AS tempo_minutos
FROM faturamento_raw;

DROP TABLE IF EXISTS pesagem_tratada;

CREATE TABLE pesagem_tratada AS
SELECT
    id,
    placa,
    CAST(REPLACE(REPLACE(LOWER(peso_bruto), 'kg', ''), ' ', '') AS INTEGER) AS peso_bruto,
    CAST(REPLACE(REPLACE(LOWER(peso_tara), 'kg', ''), ' ', '') AS INTEGER) AS peso_tara,
    CAST(REPLACE(REPLACE(LOWER(peso_liquido), 'kg', ''), ' ', '') AS INTEGER) AS peso_liquido
FROM pesagem_raw;

/* LOAD (camada final pronta para consumo) */
DROP TABLE IF EXISTS fato_operacional;

CREATE TABLE fato_operacional AS
SELECT
    f.id,
    f.motorista,
    f.tempo_minutos,
    f.valor_corrigido,
    p.placa,
    p.peso_liquido
FROM faturamento_tratado f
LEFT JOIN pesagem_tratada p
ON f.id = p.id;


/* KPIs do ETL */
SELECT 
    ROUND(AVG(tempo_minutos), 2) AS tempo_medio_atendimento,
    SUM(valor_corrigido) AS faturamento_total,
    SUM(peso_liquido) AS peso_movimentado
FROM fato_operacional;