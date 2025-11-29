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