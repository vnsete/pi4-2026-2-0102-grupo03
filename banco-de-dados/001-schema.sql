CREATE TABLE IF NOT EXISTS cliente (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(120) NOT NULL,
 telefone VARCHAR(15) NOT NULL,
 email VARCHAR(254),
 criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 CHECK(CHAR_LENGTH(TRIM(nome))>0),
 CHECK(telefone REGEXP '^[0-9]{10,15}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS endereco (
 id INT AUTO_INCREMENT PRIMARY KEY,
 cliente_id INT NOT NULL,
 logradouro VARCHAR(120) NOT NULL,
 numero VARCHAR(20) NOT NULL,
 complemento VARCHAR(120),
 bairro VARCHAR(120) NOT NULL,
 cidade VARCHAR(120) NOT NULL,
 uf CHAR(2) NOT NULL,
 cep CHAR(8) NOT NULL,
 criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 UNIQUE KEY endereco_cliente(id,cliente_id),
 FOREIGN KEY(cliente_id) REFERENCES cliente(id),
 CHECK(cep REGEXP '^[0-9]{8}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS catalogo_servico (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(120) NOT NULL,
 descricao VARCHAR(500),
 preco_padrao DECIMAL(12,2) NOT NULL,
 duracao_minutos INT NOT NULL,
 criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 CHECK(CHAR_LENGTH(TRIM(nome))>0),
 CHECK(preco_padrao>0),
 CHECK(duracao_minutos BETWEEN 1 AND 1440)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS servico (
 id INT AUTO_INCREMENT PRIMARY KEY,
 cliente_id INT NOT NULL,
 endereco_id INT,catalogo_id INT,
 descricao VARCHAR(500) NOT NULL,
 valor_previsto DECIMAL(12,2),
 status VARCHAR(20) NOT NULL DEFAULT 'registrado',
 criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 UNIQUE KEY servico_cliente(id,cliente_id),
 FOREIGN KEY(cliente_id) REFERENCES cliente(id),
 FOREIGN KEY(endereco_id,cliente_id) REFERENCES endereco(id,cliente_id),
 FOREIGN KEY(catalogo_id) REFERENCES catalogo_servico(id),
 CHECK(CHAR_LENGTH(TRIM(descricao))>0),
 CHECK(valor_previsto>0),
 CHECK(status IN ('registrado','agendado','em_andamento','concluido','cancelado'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS agendamento (
 id INT AUTO_INCREMENT PRIMARY KEY,
 servico_id INT NOT NULL UNIQUE,
 inicio_em DATETIME(6) NOT NULL,
 fim_em DATETIME(6) NOT NULL,
 criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 FOREIGN KEY(servico_id) REFERENCES servico(id),
 CHECK(fim_em>inicio_em),
 INDEX agenda_periodo(inicio_em,fim_em)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS orcamento (
 id INT AUTO_INCREMENT PRIMARY KEY,
 cliente_id INT NOT NULL,
 servico_id INT,
 descricao VARCHAR(500) NOT NULL,
 valor_total DECIMAL(12,2) NOT NULL,
 status VARCHAR(10) NOT NULL DEFAULT 'pendente',
 criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 FOREIGN KEY(cliente_id) REFERENCES cliente(id),
 FOREIGN KEY(servico_id,cliente_id) REFERENCES servico(id,cliente_id),
 CHECK(valor_total>0),CHECK(CHAR_LENGTH(TRIM(descricao))>0),
 CHECK(status IN ('pendente','aprovado','recusado')),INDEX orcamento_cliente(cliente_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS pagamento (
 id INT AUTO_INCREMENT PRIMARY KEY,
 servico_id INT NOT NULL UNIQUE,
 valor DECIMAL(12,2) NOT NULL,
 situacao VARCHAR(10) NOT NULL,
 vencimento_em DATE,pago_em DATETIME(6),
 atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 FOREIGN KEY(servico_id) REFERENCES servico(id),
 CHECK(valor>0),CHECK(situacao IN ('pendente','pago')),
 CHECK((situacao='pago' AND pago_em IS NOT NULL) OR (situacao='pendente' AND pago_em IS NULL)),
 INDEX pagamento_situacao(situacao)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS configuracao (
 id INT PRIMARY KEY,nome_empresa VARCHAR(120) NOT NULL DEFAULT 'ServiHUB',
 usar_clientes BOOLEAN NOT NULL DEFAULT TRUE,
 usar_agenda BOOLEAN NOT NULL DEFAULT TRUE,
 usar_orcamentos BOOLEAN NOT NULL DEFAULT TRUE,
 usar_pagamentos BOOLEAN NOT NULL DEFAULT TRUE,
 CHECK(id=1),CHECK(CHAR_LENGTH(TRIM(nome_empresa))>0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO configuracao(id,nome_empresa) VALUES(1,'ServiHUB');
