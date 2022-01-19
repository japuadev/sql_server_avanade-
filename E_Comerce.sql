USE E_comerce

create table Clientes
(
	codigo INT IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	tipo_pessoa CHAR(1) NOT NULL,
	data_criacao DATETIME
)

create table Produtos
(
	codigo INT IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	descricao VARCHAR (200) NOT NULL,
	preco FLOAT NOT NULL
)

create table Pedido
(
	codigo INT IDENTITY(1,1) PRIMARY KEY,
	data_solicitacao DATETIME,
	flag_pago BIT NOT NULL,
	total_pedido FLOAT NOT NULL,
	codigo_Clientes INT
)

create table PedidoItem
(
	codigo_Pedido INT,
	codigo_Produto INT,
	preco FLOAT NOT NULL,
	qtd INT NOT NULL
)

--ADICIONANDO PK COMPOSTA NA TABELA PEDIDO ITEM
ALTER TABLE PedidoItem ALTER COLUMN codigo_Pedido INT NOT NULL;
ALTER TABLE PedidoItem ALTER COLUMN codigo_Produto INT NOT NULL;

ALTER TABLE PedidoItem ADD CONSTRAINT pk_PedidoItem PRIMARY KEY(codigo_Pedido, codigo_Produto);

--ADICIONANDO FK NAS TABELAS
ALTER TABLE PedidoItem ADD CONSTRAINT fk_pedido FOREIGN KEY (codigo_Pedido) REFERENCES Pedido(Codigo); 
ALTER TABLE PedidoItem ADD CONSTRAINT fk_produto FOREIGN KEY (codigo_Produto) REFERENCES Produto(Codigo);
ALTER TABLE Pedido ADD CONSTRAINT fk_pedido_clientes FOREIGN KEY (codigo_Clientes) REFERENCES Clientes(Codigo);

SELECT * FROM Clientes

--ADICIONANDO COLUNAS EM TABELA EXISTENTE
ALTER TABLE Pedido ADD codigo_Status INT
ALTER TABLE Pedido ADD	desc_Status VARCHAR(50)

--CRIANDO UMA NOVA TABELA PARA STATUS
create table StatusPedido
(
	codigo INT IDENTITY(1,1) PRIMARY KEY,
	descricao VARCHAR(50) NOT NULL
)

--ADICIONANDO FK_STATUSPEDIDO NA TABELA PEDIDO
ALTER TABLE Pedido ADD CONSTRAINT fk_pedido_status FOREIGN KEY (codigo_Status) REFERENCES StatusPedido(codigo)

--CRIANDO NOVAS TABELAS
create table StatusPedidoItem 
(
	codigo INT IDENTITY (1,1) PRIMARY KEY,
	descricao VARCHAR(50)
)

create table tblCodigos 
(
	codigo_Pedido INT,
	codigo_Produto INT,
	codigo_StatusPedidoItem INT,
	dataMovimento DATETIME
)

ALTER TABLE Pedido ADD CONSTRAINT fk_pedido_status FOREIGN KEY (codigo_Status) REFERENCES StatusPedido(codigo)
ALTER TABLE tblCodigos ADD CONSTRAINT fk_pedidoitem FOREIGN KEY (codigo_Pedido, codigo_Produto) REFERENCES PedidoItem (codigo_Pedido, codigo_Produto)
ALTER TABLE tblCodigos ADD CONSTRAINT fk_statuspedidoitem FOREIGN KEY (codigo_StatusPedidoItem) REFERENCES StatusPedidoItem(codigo)
