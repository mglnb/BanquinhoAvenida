# Roteiro Aula 13  
### Adicionado e alterando permissões de usuários

Primeiramente foi feito a criação do dois bancos de dados.

    CREATE DATABASE IF NOT EXISTS mercadoavenida;
    CREATE DATABASE IF NOT EXISTS revendaherbie;


O Banco de dados do Mercado Avenida haverá as seguintes tabelas com os seguintes campos:  

1. Clientes   
    * Id
    * Nome
    * Telefone
    * CPF
1. Produtos
    * Id
    * Descrição
    * Quantidade
    * Valor
1. Vendas
    * Id
    * Clientes_idClientes
    * Produtos_idProdutos

O Banco de dados do Revenda Herbie haverá as seguintes tabelas com os seguintes campos: 

1. Clientes   
    * Id
    * Nome
    * Telefone
    * CPF
1. Carros
    * Id
    * Modelo
    * Cor
    * Valor
1. Vendas
    * Id
    * Clientes_idClientes
    * Carro_idCarro
    

## Criando as tabelas do Mercado Avenida.

Primeiramente

```mysql
USE mercadoavenida;
```


Tabela Clientes
---------------
```mysql
CREATE TABLE IF NOT EXISTS clientes (
  idclientes INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  telefone VARCHAR(12) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  PRIMARY KEY (idclientes))
ENGINE = InnoDB;
```

Tabela Produtos
------------
```mysql
CREATE TABLE IF NOT EXISTS produtos (
  idprodutos INT NOT NULL,
  descricao VARCHAR(150) NOT NULL,
  qtd INT NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (idprodutos))
ENGINE = InnoDB;
```
Tabela Venda
--------
```mysql
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
```

## Criando as tabelas do Revenda Herbie.

Entrando no revenda herbie

```mysql
USE revendaherbie;
```

Tabela Clientes
--------------
```mysql
CREATE TABLE IF NOT EXISTS clientes (
  idclientes INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  telefone VARCHAR(12) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  PRIMARY KEY (idclientes)
)
ENGINE = InnoDB;
```

Tabela Carro
------------
```mysql
CREATE TABLE IF NOT EXISTS carro (
  idcarro INT NOT NULL,
  modelo VARCHAR(150) NOT NULL,
  cor VARCHAR(25) NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (idcarro)
)
ENGINE = InnoDB;
```

Tabela Venda
------------
```mysql
CREATE TABLE IF NOT EXISTS venda (
  idvenda INT NOT NULL,
  clientes_idclientes INT NOT NULL,
  carro_idcarro INT NOT NULL,
  PRIMARY KEY (idvenda, clientes_idclientes, produtos_idprodutos),
  INDEX fk_venda_clientes_idx (clientes_idclientes ASC),
  INDEX fk_venda_carro1_idx (carro_idcarro ASC),
  CONSTRAINT fk_venda_clientes
    FOREIGN KEY (clientes_idclientes)
    REFERENCES clientes (idclientes),
  CONSTRAINT fk_venda_produtos1
    FOREIGN KEY (carro_idcarro)
    REFERENCES carro (idcarro)
)
ENGINE = InnoDB;
```

### Usuários
Teremos 6 usuários:
* System - Terá todas permissões a todos os sistema
* AdminAvenida - Terá todas permissões no sistema mercadoAvenida
* AdminHerbie - Terá todas permissões no sistema revendaHerbie
* User - Terá permissões de incluir, buscar, e atualizar dados
* Client - Terá permissão de visualização
* JonSnow - Não terá permissão nenhuma pois Jon Snow não sabe nada.

Criaremos eles com os seguintes comandos:

```mysql
CREATE USER 'system'@'localhost' IDENTIFIED BY 'system';
CREATE USER 'adminAvenida'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'adminHerbie'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';
CREATE USER 'client'@'localhost' IDENTIFIED BY 'client';
CREATE USER 'jonsnow'@'localhost' IDENTIFIED BY 'jonsnow';
```


Primeiramente daremos permissão ao system
---------
```mysql
GRANT ALL PRIVILEGES ON *.* TO 'system'@'localhost';
```

Logo então daremos todas permissões aos admins e retiraremos a forma de excluir tabelas
--------
```mysql
GRANT ALL PRIVILEGES ON mercadoavenida.* TO 'adminAvenida'@'localhost';
REVOKE DROP ON adminHerbie.* FROM 'adminAvenida'@'localhost';

GRANT ALL PRIVILEGES ON mercadoavenida.* TO 'adminHerbie'@'localhost';
REVOKE DROP ON adminHerbie.* FROM 'adminHerbie'@'localhost';
```


Daremos permissão ao usuário
-----------
```mysql
GRANT INSERT, SELECT, UPDATE ON *.* TO 'user'@'localhost';
```

Permissões de visualização para o cliente
-----------
```mysql
GRANT SELECT ON *.* TO 'client'@'localhost';
```

Para atualizar todas as permissões:
----------
```mysql
FLUSH PRIVILEGES;
```






















































