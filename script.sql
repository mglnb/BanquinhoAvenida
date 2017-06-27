-- -----------------------------------------------------
-- Schema MercadoAvenida
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS mercadoavenida;
USE mercadoavenida;

-- -----------------------------------------------------
-- Table MercadoAvenida.clientes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS clientes (
  idclientes INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  telefone VARCHAR(12) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  clientescol VARCHAR(45) NOT NULL,
  PRIMARY KEY (idclientes))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table .produtos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS produtos (
  idprodutos INT NOT NULL,
  descricao VARCHAR(150) NOT NULL,
  qtd INT NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (idprodutos))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table .venda
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS venda (
  idvenda INT NOT NULL,
  clientes_idclientes INT NOT NULL,
  produtos_idprodutos INT NOT NULL,
  PRIMARY KEY (idvenda, clientes_idclientes, produtos_idprodutos),
  INDEX fk_venda_clientes_idx (clientes_idclientes ASC),
  INDEX fk_venda_produtos1_idx (produtos_idprodutos ASC),
  CONSTRAINT fk_venda_clientes
    FOREIGN KEY (clientes_idclientes)
    REFERENCES clientes (idclientes),
  CONSTRAINT fk_venda_produtos1
    FOREIGN KEY (produtos_idprodutos)
    REFERENCES produtos (idprodutos)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Schema RevendaHerbie
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS revendaherbie;
USE revendaherbie;

-- -----------------------------------------------------
-- Table clientes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS clientes (
  idclientes INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  telefone VARCHAR(12) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  PRIMARY KEY (idclientes)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table carro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS carro (
  idcarro INT NOT NULL,
  modelo VARCHAR(150) NOT NULL,
  cor VARCHAR(25) NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (idcarro)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table venda
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS venda (
  idvenda INT NOT NULL,
  clientes_idclientes INT NOT NULL,
  produtos_idprodutos INT NOT NULL,
  PRIMARY KEY (idvenda, clientes_idclientes, produtos_idprodutos),
  INDEX fk_venda_clientes_idx (clientes_idclientes ASC),
  INDEX fk_venda_produtos1_idx (produtos_idprodutos ASC),
  CONSTRAINT fk_venda_clientes
    FOREIGN KEY (clientes_idclientes)
    REFERENCES clientes (idclientes),
  CONSTRAINT fk_venda_produtos1
    FOREIGN KEY (produtos_idprodutos)
    REFERENCES carro (idcarro)
)
ENGINE = InnoDB;


CREATE USER 'system'@'localhost' IDENTIFIED BY 'system';
CREATE USER 'adminAvenida'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'adminHerbie'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';
CREATE USER 'client'@'localhost' IDENTIFIED BY 'client';
CREATE USER 'jonsnow'@'localhost' IDENTIFIED BY 'jonsnow';



GRANT ALL PRIVILEGES ON *.* TO 'system'@'localhost';


GRANT ALL PRIVILEGES ON mercadoavenida.* TO 'adminAvenida'@'localhost';
REVOKE DROP ON adminHerbie.* FROM 'adminAvenida'@'localhost';

GRANT ALL PRIVILEGES ON mercadoavenida.* TO 'adminHerbie'@'localhost';
REVOKE DROP ON adminHerbie.* FROM 'adminHerbie'@'localhost';


GRANT INSERT, SELECT, UPDATE ON *.* TO 'user'@'localhost';

GRANT SELECT ON *.* TO 'client'@'localhost';

FLUSH PRIVILEGES;

















