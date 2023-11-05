/*
Tabelas utilizadas:
notas_fiscais
itens_notas_fiscais
tabela_de_vendedores
*/

-- Junção, união e visão

SELECT * FROM NOTAS_FISCAIS -- colunas: cpf, matricula, data_venda, numero, imposto
SELECT * FROM ITENS_NOTAS_FISCAIS -- colunas: numero, codigo_do_produto, quantidade, preco

-- Uso do INNER JOIN

SELECT 
	a.cpf,
	a.matricula,
	a.data_venda,
	a.imposto,
	b.numero,
	b.codigo_do_produto,
	b.quantidade,
	b.preco
FROM notas_fiscais a
INNER JOIN itens_notas_fiscais b 
	ON a.numero = b.numero -- forma 1: 213.364 linhas


SELECT 
	a.cpf,
	a.matricula,
	a.data_venda,
	a.imposto,
	b.numero,
	b.codigo_do_produto,
	b.quantidade,
	b.preco
FROM notas_fiscais a
JOIN itens_notas_fiscais b 
	ON a.numero = b.numero -- forma 2: 213.364 linhas

-- Uso do LEFT JOIN e RIGHT JOIN

SELECT 
	a.cpf,
	a.matricula,
	a.data_venda,
	a.imposto,
	b.numero,
	b.codigo_do_produto,
	b.quantidade,
	b.preco
FROM notas_fiscais a
LEFT JOIN itens_notas_fiscais b 
	ON a.numero = b.numero -- 213.447 linhas


SELECT 
	a.cpf,
	a.matricula,
	a.data_venda,
	a.imposto,
	b.numero,
	b.codigo_do_produto,
	b.quantidade,
	b.preco
FROM notas_fiscais a
RIGHT JOIN itens_notas_fiscais b 
	ON a.numero = b.numero -- 213.364 linhas

-- Uso do VIEW


CREATE VIEW notas_fiscais_reduzida
AS
SELECT TOP 10
	*
FROM notas_fiscais 

CREATE VIEW itens_notas_fiscais_reduzida
AS
SELECT TOP 10
	*
FROM itens_notas_fiscais 


SELECT 
	*
FROM itens_notas_fiscais_reduzida;

SELECT 
	*
FROM notas_fiscais_reduzida


-- Uso do FULL JOIN e CROSS JOIN

SELECT 
	a.cpf,
	a.matricula,
	a.data_venda,
	a.imposto,
	b.numero,
	b.codigo_do_produto,
	b.quantidade,
	b.preco
FROM notas_fiscais_reduzida a
FULL JOIN itens_notas_fiscais_reduzida b 
	ON a.numero = b.numero 

SELECT 
	a.cpf,
	a.matricula,
	a.data_venda,
	a.imposto,
	b.numero,
	b.codigo_do_produto,
	b.quantidade,
	b.preco
FROM notas_fiscais_reduzida a
CROSS JOIN itens_notas_fiscais_reduzida b 

/* 
UNION usado em tabelas com mesmos valores não há alteração, pois ele só une valores distintos de mesmas colunas
UNION ALL une independentemente dos valores serem iguais ou não.
*/

-- UNION

SELECT 
* 
FROM tabela_de_vendedores
UNION
SELECT 
* 
FROM tabela_de_vendedores

-- UNOIN ALL

SELECT 
* 
FROM tabela_de_vendedores
UNION ALL
SELECT 
* 
FROM tabela_de_vendedores

