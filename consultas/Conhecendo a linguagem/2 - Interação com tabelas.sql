/* 
-- TABELAS UTILIZADAS:
tabela_de_clientes
*/


-- INTERA��O SIMPLES COM TABELAS


-- Criando tabela vazia:

CREATE TABLE primeira_tabela (
	
	nome VARCHAR(100) NOT NULL,
	idade SMALLINT NOT NULL,
	genero CHAR(1) NOT NULL

)

SELECT * FROM primeira_tabela

-- Exclus�o de tabelas

DROP TABLE primeira_tabela

-- Inserindo valores na tabela vazia:

INSERT INTO primeira_tabela
VALUES ('Samuel',24,'M')

SELECT * FROM primeira_tabela 

-- Inserindo m�ltiplas linhas:

INSERT INTO primeira_tabela
VALUES 
('Luquinha', 25, 'M'),
('Anyh', 26, 'F'),
('Vinicius', 25, 'M'),
('Angelica', 32, 'F'),

SELECT * FROM primeira_tabela 


-- Alterando dados de uma tabela:

UPDATE primeira_tabela 
SET idade = '26' 
WHERE nome = 'Vinicius'

SELECT * FROM primeira_tabela


-- Deletando uma linha do banco de dados

DELETE FROM primeira_tabela WHERE nome = 'Angelica'

SELECT * FROM primeira_tabela

-- Deletando todos os registros

DELETE FROM primeira_tabela 

SELECT * FROM primeira_tabela

-- Deletando tabela 

DROP TABLE primeira_tabela

-- Criando tabela a partir de outra tabela existente

SELECT 
	cpf,
	nome,
	genero
INTO segunda_tabela
FROM tabela_de_clientes

SELECT * FROM tabela_de_clientes 
SELECT * FROM segunda_tabela

-- Tabelas tempor�rias

CREATE TABLE #teste (
	id INT,
	letra VARCHAR(1)
)

SELECT * FROM #teste -- Tabela v�lida apenas durante a conex�o do usu�rio

CREATE TABLE ##teste (
	id INT,
	numero INT
)

SELECT * FROM ##teste -- Tabela v�lida apenas durante a conex�o de todos os usu�rios conectados

