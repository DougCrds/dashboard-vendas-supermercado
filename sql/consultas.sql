-- ============================================================
-- PROJETO: Dashboard de Vendas por Seção
-- BANCO: PostgreSQL
-- DESCRIÇÃO:
-- Consultas utilizadas na preparação e análise dos dados
-- para construção do dashboard no Power BI.
-- ============================================================


-- ============================================================
-- 1. Faturamento e quantidade vendida por produto e seção
-- ============================================================

SELECT
    v.wnomefiscal AS produto,
    SUM(v.qtd) AS quantidade_vendida,
    SUM(v.venda) AS faturamento,
    s.wnomesecao AS secao
FROM view_dash v
JOIN secoes s
    ON s.widsecao = v.widsecao
GROUP BY
    v.wnomefiscal,
    s.wnomesecao;


-- ============================================================
-- 2. Top 6 produtos por faturamento
-- Seção: Açougue Bovino
-- ============================================================

SELECT
    v.wnomefiscal AS produto,
    SUM(v.venda) AS faturamento,
    s.wnomesecao AS secao
FROM view_dash v
JOIN secoes s
    ON s.widsecao = v.widsecao
WHERE s.wnomesecao = 'AÇOUGUE BOVINO'
GROUP BY
    v.wnomefiscal,
    s.wnomesecao
ORDER BY
    SUM(v.venda) DESC
LIMIT 6;


-- ============================================================
-- 3. Quantidade vendida por produto e data
-- Seção: Biscoitos
-- Período: 01/01/2025 a 15/01/2025
-- ============================================================

SELECT
    v.wdatacaixa AS data_venda,
    v.wnomefiscal AS produto,
    SUM(v.qtd) AS quantidade_vendida
FROM view_dash v
JOIN secoes s
    ON s.widsecao = v.widsecao
WHERE
    s.wnomesecao = 'BISCOITOS'
    AND v.wdatacaixa BETWEEN '2025-01-01' AND '2025-01-15'
GROUP BY
    v.wdatacaixa,
    v.wnomefiscal
ORDER BY
    v.wdatacaixa;
