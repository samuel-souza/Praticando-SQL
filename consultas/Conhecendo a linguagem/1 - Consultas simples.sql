/* 
-- TABELAS UTILIZADAS:
notas_fiscais
tabela_de_clientes
*/

-- COMANDOS BÁSICOS SQL

-- Todos os registros

SELECT * FROM notas_fiscais

-- Limitando registros

SELECT TOP 10 * FROM notas_fiscais

-- Selecionando colunas específicas

SELECT 
	cpf, 
	matricula,
	imposto
FROM notas_fiscais

-- Aplicando condição

SELECT 
	cpf,
	matricula,
	imposto
FROM notas_fiscais
WHERE imposto > 0.1

-- Mais de uma condição 

SELECT 
	*
FROM notas_fiscais
WHERE imposto >= 0.1 AND imposto <= 0.15 -- Forma 1

SELECT
	*
FROM notas_fiscais
WHERE imposto BETWEEN 0.1 AND 0.15 -- Forma 2, a função 'BETWEEN' retorna os registros 'ENTRE' os valores escolhidos

-- Verificando se bateu a quantidade de linhas

SELECT 
	count(*) -- conta a quantidade de linhas
FROM notas_fiscais
WHERE imposto >= 0.1 AND imposto <= 0.15 -- 87877

SELECT 
	count(*)
FROM notas_fiscais
WHERE imposto BETWEEN 0.1 AND 0.15 -- 87877

-- Apelidos

SELECT 
	a.cpf as identificador, -- podemos usar o 'as' para apelidar uma coluna ou tabela
	tributaçao = a.imposto, -- podemos usar o '=' na sintaxe 
	[id vendedor] = a.matricula -- podemos adicionar colunas com espaço usando '[]'
FROM notas_fiscais a -- tabelas podem ser apelidadas
WHERE a.imposto > 0.1 -- o nome utilizado em condições deve ser o nome real da coluna

-- Valores distintos

SELECT DISTINCT 
	matricula
FROM notas_fiscais 

SELECT DISTINCT 
	matricula,
	imposto
FROM notas_fiscais

-- Ordenando valores

SELECT 
	cpf,
	imposto 
FROM notas_fiscais
ORDER BY imposto 

SELECT 
	cpf,
	imposto 
FROM notas_fiscais
ORDER BY imposto DESC

-- Inclusão 

SELECT 
	*
FROM notas_fiscais 
WHERE cpf IN ('3623344710','492472718','3623344710','3623344710')


SELECT 
	*
FROM notas_fiscais 
WHERE cpf NOT IN ('3623344710','492472718','3623344710','3623344710')


-- Operador Like

SELECT 
	*
FROM tabela_de_clientes
WHERE nome LIKE '%Silva%'


SELECT 
	*
FROM tabela_de_clientes
WHERE nome LIKE 'Abel%'


SELECT 
	cidade
FROM tabela_de_clientes
WHERE cidade LIKE '%Janeiro'


-- Case WHEN

SELECT 
	cpf,
	nome,
	idade,
	genero,
	limite_de_credito = CASE WHEN limite_de_credito >= 100000 THEN 'Alto' END
FROM tabela_de_clientes

SELECT 
	cpf,
	nome,
	idade,
	genero,
	limite_de_credito = (
	CASE 
		WHEN limite_de_credito >= 150000 THEN 'Alto' 
		WHEN limite_de_credito >= 100000 AND limite_de_credito < 150000 THEN 'Medio'
		ELSE 'Baixo'
	END
	)
FROM tabela_de_clientes
