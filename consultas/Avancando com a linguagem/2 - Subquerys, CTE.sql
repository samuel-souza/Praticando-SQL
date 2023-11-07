USE VENDAS_SUCOS_2

/*
COMMON TABLE EXPRESSIONS (CTEs):
- Tabelas temporárias definidas com a cláusula WITH.
- Melhoram a legibilidade, permitem reutilização e são úteis em consultas recursivas.
- São definidas uma vez e podem ser referenciadas várias vezes na consulta principal.
*/

SELECT * FROM clientes; -- cpf, nome, endereco, bairro, cidade, estado, cep, data_nascimento, idade, genero, limite_de_credito, volume_de_compra, primeira_compra
SELECT * FROM itens_vendidos; -- numero, codigo, quantidade, preco
SELECT * FROM produtos; -- codigo, descritor, sabor, tamanho, embalagem, preco_lista
SELECT * FROM vendas; -- numero, data_venda, cpf, matricula, imposto
SELECT * FROM vendedores; -- matricula, nome, bairro, comissao, data_admissao, ferias

-- Quantidade de compras e quantidade de itens comprados de cada cliente (Usando CTE)

WITH CTE AS (
	SELECT 
		a.cpf,
		qtd_compras = COUNT(b.numero)
	FROM clientes a
	INNER JOIN vendas b
		ON  a.cpf = b.cpf
	GROUP BY 
		a.cpf
), 
CTE2 AS (
	SELECT 
		a.cpf,
		qtd_itens_compra = SUM(b.quantidade)
	FROM vendas a
	INNER JOIN itens_vendidos b 
		ON a.numero = b.numero 
	GROUP BY 
		a.cpf
)
SELECT 
	a.cpf,
	a.qtd_compras,
	b.qtd_itens_compra
FROM CTE a
INNER JOIN CTE2 b
	ON a.cpf = b.cpf

/* 
SUBQUERYS (Subconsultas):
- Consultas aninhadas dentro de outra consulta.
- Usadas para buscar dados com base em resultados de outra consulta.
- Pode ser usada em várias cláusulas.
*/

-- Quantidade de compras e quantidade de itens comprados de cada cliente (Usando Subquerys)

SELECT 
	a.cpf,
	a.qtd_compras,
	b.qtd_itens_compra
FROM (
	SELECT 
		a.cpf,
		qtd_compras = COUNT(b.numero)
	FROM clientes a
	INNER JOIN vendas b
		ON  a.cpf = b.cpf
	GROUP BY 
		a.cpf
) a
INNER JOIN (
	SELECT 
		a.cpf,
		qtd_itens_compra = SUM(b.quantidade)
	FROM vendas a
	INNER JOIN itens_vendidos b 
		ON a.numero = b.numero 
	GROUP BY 
		a.cpf
) b
	ON a.cpf = b.cpf

-- PARTIÇÃO DE TABELAS

-- Quantidade de vendas de cada vendedor por mês (COM GROUP BY):

SELECT 
	matricula,
	mes_referencia = LEFT(CAST(data_venda AS DATE),7),
	qtd_vendas = COUNT(numero)
FROM vendas 
GROUP BY 
	matricula,
	LEFT(CAST(data_venda AS DATE),7)
ORDER BY matricula, mes_referencia;

-- Quantidade de vendas de cada vendedor por mês (COM PARTITION BY):

SELECT DISTINCT -- O uso do DISTINCT nessa query faz com que os resultados sejam iguais a consulta usando o GROUP BY.
    a.matricula,
    mes_referencia = LEFT(CAST(a.data_venda AS DATE),7),
    qtd_vendas = COUNT(a.numero) OVER (PARTITION BY a.matricula, LEFT(CAST(a.data_venda AS DATE),7) ORDER BY LEFT(CAST(a.data_venda AS DATE),7)) 
FROM vendas a
INNER JOIN vendedores b 
    ON a.matricula = b.matricula
ORDER BY a.matricula, mes_referencia

SELECT -- Uso do PARTITION BY mantendo as linhas originais da tabela.
    a.matricula,
    mes_referencia = LEFT(CAST(a.data_venda AS DATE),7),
    qtd_vendas = COUNT(a.numero) OVER (PARTITION BY a.matricula, LEFT(CAST(a.data_venda AS DATE),7) ORDER BY LEFT(CAST(a.data_venda AS DATE),7)) 
FROM vendas a
INNER JOIN vendedores b 
    ON a.matricula = b.matricula
ORDER BY a.matricula, mes_referencia
