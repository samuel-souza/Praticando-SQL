/*
	Tabela utilizadas:

notas_fiscais
itens_notas_fiscais
*/

-- Funções de agregação e agrupamento

SELECT * FROM NOTAS_FISCAIS
SELECT * FROM ITENS_NOTAS_FISCAIS


-- Agrupamento:

SELECT 
	codigo_do_produto,
	quantidade = SUM(quantidade)
FROM itens_notas_fiscais
GROUP BY codigo_do_produto
ORDER BY quantidade DESC

-- Agrupamento com condição da função de agregação:

SELECT 
	codigo_do_produto,
	quantidade = SUM(quantidade)
FROM itens_notas_fiscais
GROUP BY codigo_do_produto
HAVING SUM(quantidade) >= 390000

-- Agrupando por mais de uma coluna:

SELECT 
	codigo_do_produto,
	preco,
	quantidade = SUM(quantidade)
FROM itens_notas_fiscais
GROUP BY 
	codigo_do_produto,
	preco

-- Contagem

SELECT 
	matricula,
	contagem_cpf = COUNT(cpf)
FROM notas_fiscais
GROUP BY matricula

-- Soma

SELECT
	codigo_do_produto,
	quantidade_vendida = SUM(quantidade)
FROM itens_notas_fiscais
GROUP BY codigo_do_produto

-- Max

SELECT 
	codigo_do_produto,
	preco = MAX(preco)
FROM itens_notas_fiscais
GROUP BY codigo_do_produto


-- Min

SELECT 
	codigo_do_produto,
	preco = MIN(preco)
FROM itens_notas_fiscais
GROUP BY codigo_do_produto