
CREATE TABLE planetas
(
	id_planetas INT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	rotacao FLOAT NOT NULL,
	orbita FLOAT NOT NULL,
	diametro FLOAT NOT NULL,
	clima VARCHAR(50) NOT NULL,
	populacao INT NOT NULL
)

CREATE TABLE naves
(
	id_nave INT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	modelo VARCHAR (150) NOT NULL,
	qtd_passageiros INT NOT NULL,
	qtd_carga FLOAT NOT NULL,
	classe VARCHAR(100) NOT NULL
)

CREATE TABLE pilotos
(
	id_pilotos INT PRIMARY KEY,
	nome VARCHAR(200) NOT NULL,
	ano_nascimento VARCHAR(10) NOT NULL,
	id_planeta INT NOT NULL
)

ALTER TABLE pilotos ADD CONSTRAINT fk_pilotos_planetas FOREIGN KEY (id_planeta) 
REFERENCES planetas (id_planetas)

CREATE TABLE pilotos_naves
(
	id_piloto INT NOT NULL,
	id_nave INT NOT NULL,
	flag_autorizado bit NOT NULL
)

ALTER TABLE pilotos_naves ADD CONSTRAINT pk_pilotos_naves PRIMARY KEY(id_piloto, id_nave)

ALTER TABLE pilotos_naves ADD CONSTRAINT fk_pilotos_naves_pilotos FOREIGN KEY(id_piloto)
REFERENCES pilotos(id_pilotos)

ALTER TABLE pilotos_naves ADD CONSTRAINT fk_pilotos_naves_naves FOREIGN KEY(id_nave)
REFERENCES naves(id_nave)

ALTER TABLE pilotos_naves ADD CONSTRAINT df_pilotos_naves_flagauto DEFAULT (1) FOR flag_autorizado

CREATE TABLE historico_viagens
(
	id_nave INT NOT NULL,
	id_pilotos INT NOT NULL,
	dt_saida DATETIME NOT NULL,
	dt_chegada DATETIME NULL
)

ALTER TABLE historico_viagens ADD CONSTRAINT fk_historico_viagens_pilotos_naves FOREIGN KEY (id_nave, id_pilotos)
REFERENCES pilotos_naves(id_piloto, id_nave)




