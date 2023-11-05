/* Problema I: 
"olha, me vê dentro de um mês quais foram os clientes que compraram mais do que o volume de compra especificado para eles"
*/

--SELECT * FROM notas_fiscais
--SELECT * FROM itens_notas_fiscais
--SELECT * FROM tabela_de_clientes

SELECT
	cli.cpf,
	cli.volume_de_compra,
	aux.mes_ano,
	aux.qtd_vendida
FROM tabela_de_clientes cli
INNER JOIN 
(
	SELECT 
	nf.cpf,
	mes_ano = LEFT(CAST(nf.data_venda AS DATE),7),
	qtd_vendida = SUM(inf.quantidade)
FROM NOTAS_FISCAIS nf
INNER JOIN ITENS_NOTAS_FISCAIS inf 
	ON nf.numero = inf.numero
GROUP BY 
	nf.cpf,
	LEFT(CAST(nf.data_venda AS DATE),7)
) aux
	ON cli.cpf = aux.cpf

/* Problema II: 
"liste somente os que tiveram vendas inválidas e calcule a diferença entre o limite de venda máximo e o realizado, em percentuais"
*/


SELECT
	cli.cpf,
	cli.volume_de_compra,
	aux.mes_ano,
	aux.qtd_total,
	tipo_venda = CASE WHEN cli.volume_de_compra >= aux.qtd_total THEN 'Válida' ELSE 'Inválida' END,
	[diferenca %] = ROUND(1.0 - (cli.volume_de_compra/aux.qtd_total) * 100.0,2) 
FROM tabela_de_clientes cli
INNER JOIN 
(
	SELECT 
	nf.cpf,
	mes_ano = LEFT(CAST(nf.data_venda AS DATE),7),
	qtd_total = SUM(inf.quantidade)
FROM NOTAS_FISCAIS nf
INNER JOIN ITENS_NOTAS_FISCAIS inf 
	ON nf.numero = inf.numero
GROUP BY 
	nf.cpf,
	LEFT(CAST(nf.data_venda AS DATE),7)
) aux
	ON cli.cpf = aux.cpf
WHERE cli.volume_de_compra < aux.qtd_total 
ORDER BY mes_ano DESC