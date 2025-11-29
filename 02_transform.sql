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
