-- ESTRUTURA DO BANCO DE DADOS

-- Cria��o do banco de dados:

CREATE DATABASE [VENDAS_SUCOS_2]
ON (
	NAME = 'VENDAS_SUCOS_2_DAT',
	FILENAME = 'C:\TEMP\VENDAS_SUCOS_2.MDF',
	SIZE = 10, -- Tamanho inicial do banco de dados, por padr�o, em MB.
	MAXSIZE = 50, -- Tamanho m�ximo do banco de dados, por padr�o, em MB.
	FILEGROWTH  = 5 -- Crescimento do banco de dados a medida que o tamanho inicial for atingido at� o tamanho m�ximo.
)
LOG ON 
(	
	NAME = 'VENDAS_SUCOS_2_LOG',
	FILENAME = 'C:\TEMP\VENDAS_SUCOS_2.LDF',
	SIZE = 10,
	MAXSIZE = 50,
	FILEGROWTH  = 5
);

-- Exclus�o do banco de dados:

DROP DATABASE [VENDAS_SUCOS_2];

-- Uso da base de dados:

USE VENDAS_SUCOS_2;

-- Cria��o das tabelas:

CREATE TABLE clientes (
	cpf VARCHAR(11) NOT NULL, -- Tipo: Caractere vari�vel de tamanho m�ximo 11, n�o permitindo ser nulo;
	nome VARCHAR(100) NULL, -- Tipo: Caractere vari�vel de tamanho m�ximo 100, podendo ser nulo, valor padr�o NULL; 
	endereco VARCHAR(100) NULL, -- .
	bairro VARCHAR(50) NULL, -- .
	cidade VARCHAR(50) NULL, -- .
	estado VARCHAR(50) NULL, -- .
	cep VARCHAR(8) NULL, -- Tipo: Caractere vari�vel de tamanho m�ximo 8, podendo ser nulo, valor padr�o NULL;
	data_nascimento DATE NULL, -- Tipo: Data no formato: yyyy/mm/dd, podendo ser nulo, valor padr�o NULL;
	idade INTEGER NULL, -- Tipo: Inteiro , podendo ser nulo, valor padr�o NULL;
	genero VARCHAR(1) NULL, -- Tipo: Caractere vari�vel de tamanho m�ximo 1, podendo ser nulo, valor padr�o NULL;
	limite_de_credito FLOAT, -- Tipo: Ponto flutuante, podendo ser nulo;
	volume_de_compra FLOAT, -- Tipo: Ponto flutuante, podendo ser nulo;
	primeira_compra BIT -- Tipo: bin�rio (0 ou 1), podendo ser nulo;
	PRIMARY KEY (cpf) -- Defini��o da chave prim�ria da tabela
);


CREATE TABLE vendas (
	numero VARCHAR(5) NOT NULL, 
	data_venda DATE NULL, 
	cpf VARCHAR(11) NOT NULL, 
	matricula VARCHAR(11) NOT NULL, 
	imposto FLOAT NULL,
	PRIMARY KEY (numero) 
);

CREATE TABLE produtos (
	codigo VARCHAR(10) NOT NULL,
	descritor VARCHAR(100) NULL,
	sabor VARCHAR(50) NULL,
	tamanho VARCHAR(50) NULL,
	embalagem VARCHAR(50) NULL,
	preco_lista FLOAT NULL,
	PRIMARY KEY (codigo)
);


CREATE TABLE vendedores (
	matricula VARCHAR(11) NOT NULL,
	nome VARCHAR(100) NULL,
	bairro VARCHAR(50) NULL,
	comissao FLOAT NULL,
	data_admissao DATE NULL,
	ferias BIT NULL,
	PRIMARY KEY (matricula)
);

CREATE TABLE itens_vendidos (
	numero VARCHAR(5) NOT NULL,
	codigo VARCHAR(10) NOT NULL,
	quantidade INTEGER NULL,
	preco FLOAT NULL
	PRIMARY KEY (numero, codigo) -- Chave prim�ria composta (com mais de um campo como PK).
);

-- Adicionando chaves estrangeiras e relacionamento entre as tabelas


-- itens_vendidos

ALTER TABLE itens_vendidos 
ADD CONSTRAINT FK_numero FOREIGN KEY (numero) -- Adicionando restri��o de dados (ADD CONSTRAINT) chamada 'FK_numero' do tipo chave estrangeira na coluna 'numero'.
REFERENCES vendas (numero); -- Adicionando relacionamento com a tabela de vendas usando a coluna 'numero'.

ALTER TABLE itens_vendidos 
ADD CONSTRAINT FK_produtos FOREIGN KEY (codigo) 
REFERENCES produtos (codigo); 

-- vendas

ALTER TABLE vendas
ADD CONSTRAINT FK_clientes FOREIGN KEY (cpf) 
REFERENCES clientes (cpf);

ALTER TABLE vendas
ADD CONSTRAINT FK_vendedores FOREIGN KEY (matricula) 
REFERENCES vendedores (matricula);

-- Visualizando tabela em outro banco de dados

SELECT TOP 10 * FROM SUCOS_FRUTAS.dbo.tabela_de_produtos;
SELECT TOP 10 * FROM SUCOS_FRUTAS..tabela_de_produtos;

-- Adicionando valores em uma tabela vazia a partir de uma tabela de outro banco de dados:
--OBS: � necess�rio que os campos de ambas as tabelas possuam o mesmo nome e o mesmo tipo para realizar esse procedimento.
--OBS2: Tamb�m � recomendado que se inicie a inclus�o de dados dessa forma pelas tabelas de entidades principais.


-- produtos

SELECT TOP 10 * FROM produtos;
SELECT TOP 10 * FROM SUCOS_FRUTAS..tabela_de_produtos;

INSERT INTO produtos 
SELECT 
	codigo = codigo_do_produto, 
	descritor = nome_do_produto, 
	sabor,
	tamanho,
	embalagem,
	preco_lista = preco_de_lista 
FROM SUCOS_FRUTAS..tabela_de_produtos;

SELECT * FROM produtos;

-- clientes

SELECT TOP 10 * FROM clientes;
SELECT TOP 10 * FROM SUCOS_FRUTAS..tabela_de_clientes;

INSERT INTO clientes
SELECT 
	cpf,
	nome,
	endereco = endereco_1,
	bairro,
	cidade,
	estado,
	cep,
	data_nascimento = data_de_nascimento,
	idade, 
	genero, 
	limite_de_credito,
	volume_de_compra,
	primeira_compra
FROM SUCOS_FRUTAS..tabela_de_clientes;

SELECT * FROM clientes;

-- vendedores
SELECT TOP 10 * FROM vendedores;
SELECT TOP 10 * FROM SUCOS_FRUTAS..tabela_de_vendedores;

INSERT INTO vendedores
SELECT 
	matricula,
	nome,
	bairro,
	comissao = percentual_comissao,
	data_admissao,
	ferias = de_ferias
FROM SUCOS_FRUTAS..tabela_de_vendedores;

SELECT * FROM vendedores;

-- vendas 

SELECT TOP 10 * FROM vendas;
SELECT TOP 10 * FROM SUCOS_FRUTAS..notas_fiscais;

INSERT INTO vendas
SELECT 
	numero,
	data_venda,
	cpf,
	matricula,
	imposto
FROM SUCOS_FRUTAS..notas_fiscais;

SELECT * FROM vendas;

-- itens_vendidos

SELECT TOP 10 * FROM itens_vendidos;
SELECT TOP 10 * FROM SUCOS_FRUTAS..itens_notas_fiscais;

INSERT INTO itens_vendidos
SELECT 
	numero,
	codigo = codigo_do_produto,
	quantidade,
	preco
FROM SUCOS_FRUTAS..itens_notas_fiscais; 

SELECT * FROM itens_vendidos;

-- Atualizando valores das tabelas:

-- Atualizando o valor dos produtos de laranja, com um aumento de 10%:

SELECT 
	* 
FROM produtos
WHERE sabor = 'Laranja' -- valores originais

UPDATE produtos SET preco_lista = preco_lista * 1.1
WHERE sabor = 'Laranja'

-- Atualizando o volume dos produtos de 350ml para 550ml:

SELECT
	*
FROM produtos
WHERE tamanho = '350 ml' -- valores originais

UPDATE produtos SET descritor = REPLACE(descritor, '350 ml', '550 ml'), tamanho = '550 ml'
WHERE tamanho = '350 ml'

-- Atualizando o valor do produto com base em outra tabela

SELECT 
	codigo,
	descritor,
	sabor,
	tamanho,
	embalagem,
	preco_lista_aumentado = preco_lista * 1.3
INTO #aux
FROM produtos;

SELECT 
	a.preco_lista,
	b.preco_lista_aumentado
FROM produtos a
INNER JOIN #aux b
	ON a.codigo = b.codigo -- comparando pre�os nas tabelas

UPDATE a
SET a.preco_lista = b.preco_lista_aumentado
FROM produtos a 
INNER JOIN #aux b 
	ON a.codigo = b.codigo


-- Atualizando por meio da cl�usula MERGE

DROP TABLE #aux;
SELECT 
	codigo,
	descritor,
	sabor,
	tamanho,
	embalagem,
	preco_lista_diminuido = preco_lista * 0.7
INTO #aux
FROM produtos;

MERGE INTO produtos a
USING #aux b 
	ON a.codigo = b.codigo
WHEN MATCHED THEN 
	UPDATE SET a.preco_lista = b.preco_lista_diminuido;

SELECT 
	a.preco_lista,
	b.preco_lista_diminuido
FROM produtos a
INNER JOIN #aux b
	ON a.codigo = b.codigo -- comparando pre�os nas tabelas


-- Excluindo registros

INSERT INTO produtos (codigo, descritor, sabor, tamanho, embalagem, preco_lista)
VALUES
('1111111', 'Guaran� do amazonas - 700 ml', 'Guaran�', '700 ml', 'Garrafa', 8),
('2222222', 'Guaran� do amazonas - 1 Litro', 'Guaran�', '1 Litro', 'Garrafa', 10),
('3333333', 'A�a� do amazonas - 1 Litro', 'A�a�', '1 Litro', 'Garrafa', 10) -- Adicionando registros a serem exclu�dos

SELECT * FROM produtos WHERE descritor LIKE '%amazonas%' -- verificando os registros na base 

DELETE FROM produtos WHERE descritor LIKE '%Guaran� do amazonas%' AND tamanho = '700 ml' -- excluindo apenas 1 registro

DELETE FROM produtos WHERE descritor LIKE '%amazonas%' AND tamanho = '1 Litro' -- excluindo mais de 1 registro


-- Tabela com autoincremento, valores default e restri��es

CREATE TABLE Tb_estudo(
	id INT IDENTITY(1,1) NOT NULL, -- A cl�usula IDENTITY(1,1) remete ao autoincremento do ID de 1 em 1 partindo do valor 1.
	descritor VARCHAR(30) NOT NULL,
	data_insercao DATETIME DEFAULT GETDATE(), -- A cl�usula DEFAULT permite a quem cria a tabela definir valores padr�es para os campos para caso n�o possuam valor na inser��o
	nome VARCHAR(30) DEFAULT NULL,
	privilegio VARCHAR(30) DEFAULT 'usu�rio',
);

INSERT INTO Tb_estudo (descritor, nome, privilegio)
VALUES
('teste 1', 'Samuel', 'admin')

INSERT INTO Tb_estudo (descritor)
VALUES
('teste 2')

SELECT * FROM Tb_estudo -- verificando resultados das inser��es


