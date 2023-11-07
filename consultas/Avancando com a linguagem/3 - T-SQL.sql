USE VENDAS_SUCOS_2;

--  Declarando variáveis

DECLARE @NOME VARCHAR(6);
DECLARE @SOBRENOME VARCHAR(5), @IDADE INT;

-- Adicionando valor as variáveis

SET @NOME = 'Samuel'; 
SET @SOBRENOME = 'Souza';
SET @IDADE = 24

-- Exibindo valor das variáveis

PRINT 'Meu nome é: ' + CONCAT(@NOME,' ',@SOBRENOME, '. ') + 'Tenho ' + CAST(@IDADE AS VARCHAR(3)) + ' anos.';  

SELECT ('Meu nome é: ' + CONCAT(@NOME,' ',@SOBRENOME, '. ') + 'Tenho ' + CAST(@IDADE AS VARCHAR(3)) + ' anos.') as Resultado;

-- Inserindo dados em uma tabela a partir das variáveis

DECLARE @NOME VARCHAR(6), @SOBRENOME VARCHAR(5), @IDADE INT;

SET @NOME = 'Samuel'; 
SET @SOBRENOME = 'Souza';
SET @IDADE = 24;

CREATE TABLE #temp (
	id SMALLINT IDENTITY(1,1) NOT NULL,
	nome VARCHAR(6) NOT NULL,
	sobrenome VARCHAR(5) DEFAULT NULL,
	idade INT DEFAULT NULL
);

INSERT INTO #temp (nome, sobrenome, idade)
VALUES 
(@NOME, @SOBRENOME, @IDADE);

SELECT * FROM #temp;

-- Atribuindo valores as variaveis a partir de colunas de tabelas já existentes

DECLARE @CPF VARCHAR(11), @NOME VARCHAR(6), @IDADE INT;

SET @CPF = '2600586709';

SELECT 
	@NOME = nome,
	@IDADE = idade
FROM clientes
WHERE cpf = @CPF;

PRINT 'Nome: ' + @NOME + ', Idade: ' + CAST(@IDADE AS VARCHAR(3));

-- uso do IF

DECLARE @DIA_SEMANA VARCHAR(20), @NUMERO_DIAS INT;

SET @NUMERO_DIAS = 15;
SET @DIA_SEMANA = DATENAME(WEEKDAY, DATEADD(DAY, @NUMERO_DIAS, GETDATE())); -- Calculando o nome do dia da semana considerando a partir da data de hoje 

IF @DIA_SEMANA = 'Sábado' OR @DIA_SEMANA = 'Domingo'
BEGIN
	PRINT 'Daqui a ' + CAST(@NUMERO_DIAS AS VARCHAR(5)) + ' dias será ' + @DIA_SEMANA;
	PRINT 'Hoje é fim de semana';
END
ELSE
BEGIN
	PRINT 'Daqui a ' + CAST(@NUMERO_DIAS AS VARCHAR(5)) + ' dias será ' + @DIA_SEMANA;
	PRINT 'Hoje é dia de semana';
END


-- Uso do IF em consultas

/*
A cláusula IF pode ser usada para comparação com um comando SELECT, desde que o SELECT retorne apenas 1 campo e 1 linha na consulta.
*/

DECLARE @LIMITE_MAXIMO FLOAT, @BAIRRO VARCHAR(20);

SET @LIMITE_MAXIMO = 150000;
SET @BAIRRO = 'Água Santa';

IF @LIMITE_MAXIMO <= (SELECT SUM([LIMITE_DE_CREDITO]) FROM SUCOS_FRUTAS..tabela_de_clientes WHERE BAIRRO = @BAIRRO)
	PRINT 'Valor estourou'
ELSE
	PRINT 'Valor não estourou'


-- IF para manipulação de tabelas

CREATE TABLE teste (
	coluna1 VARCHAR(10),
	coluna2 VARCHAR(20)
);

SELECT * FROM teste;

IF OBJECT_ID('teste', 'u') IS NOT NULL
	DROP TABLE teste;
CREATE TABLE teste (
	coluna3 VARCHAR(3),
	coluna4 VARCHAR(4)
);

SELECT * FROM teste;


-- Uso do WHILE

DECLARE @LIMITE_MINIMO INT;
DECLARE @LIMITE_MAXIMO INT;

SET @LIMITE_MINIMO = 1;
SET @LIMITE_MAXIMO = 10;

PRINT 'Entrei no looping';

WHILE @LIMITE_MINIMO <= @LIMITE_MAXIMO
BEGIN
	PRINT @LIMITE_MINIMO;
	SET @LIMITE_MINIMO = @LIMITE_MINIMO + 1
END;
PRINT 'Sai do looping'

-- Simulando um FOR (de referência do Python) usando o WHILE

DECLARE @I INT;
SET @I = 0;
WHILE @I < 15
BEGIN
	PRINT @I
	SET @I = @I + 1;
END;


-- parando o WHILE com o BREAK

DECLARE @I INT;
SET @I = 0;
WHILE @I < 15
BEGIN
	IF @I > 10
	BEGIN
		PRINT 'Caiu na condição, parando looping...'
		BREAK
	END
	ELSE
		PRINT @I;
	SET @I = @I + 1;
END;
