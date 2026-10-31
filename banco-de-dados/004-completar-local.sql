-- NAO executar sem backup atualizado e autorizacao.
-- Revalidar antes: conta e pagamento_orcamento ausentes;
-- orcamento.catalogo_id e fk_orcamento_catalogo ausentes.
-- Nao inclui os dados demonstrativos opcionais do script 002.
USE servihub;
CREATE TABLE conta (
 id INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(120) NOT NULL,
 email VARCHAR(254) NOT NULL UNIQUE, papel ENUM('admin','funcionario','cliente') NOT NULL,
 cliente_id INT NULL, salt VARBINARY(16) NOT NULL, senha_hash VARBINARY(32) NOT NULL,
 ativo BOOLEAN NOT NULL DEFAULT TRUE, ultimo_acesso DATETIME(6) NULL,
 criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 FOREIGN KEY(cliente_id) REFERENCES cliente(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE orcamento ADD COLUMN catalogo_id INT NULL;
ALTER TABLE orcamento ADD CONSTRAINT fk_orcamento_catalogo
 FOREIGN KEY(catalogo_id) REFERENCES catalogo_servico(id);

CREATE TABLE pagamento_orcamento (
 id INT AUTO_INCREMENT PRIMARY KEY, orcamento_id INT NOT NULL UNIQUE,
 valor DECIMAL(12,2) NOT NULL, situacao VARCHAR(10) NOT NULL DEFAULT 'pendente',
 vencimento_em DATE NULL, pago_em DATETIME(6) NULL,
 atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 FOREIGN KEY(orcamento_id) REFERENCES orcamento(id),
 CHECK(valor>0), CHECK(situacao IN ('pendente','pago'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;