-- Execute uma única vez após 001-schema.sql e 002-contas-e-exemplos.sql
ALTER TABLE orcamento ADD COLUMN catalogo_id INT NULL;
ALTER TABLE orcamento ADD CONSTRAINT fk_orcamento_catalogo FOREIGN KEY (catalogo_id) REFERENCES catalogo_servico(id);
CREATE TABLE IF NOT EXISTS pagamento_orcamento (
 id INT AUTO_INCREMENT PRIMARY KEY, orcamento_id INT NOT NULL UNIQUE,
 valor DECIMAL(12,2) NOT NULL, situacao VARCHAR(10) NOT NULL DEFAULT 'pendente',
 vencimento_em DATE NULL, pago_em DATETIME(6) NULL,
 atualizado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 FOREIGN KEY (orcamento_id) REFERENCES orcamento(id),
 CHECK (valor>0), CHECK (situacao IN ('pendente','pago'))
);
