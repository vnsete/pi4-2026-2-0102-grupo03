CREATE TABLE IF NOT EXISTS conta (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(120) NOT NULL,
 email VARCHAR(254) NOT NULL UNIQUE,
 papel ENUM('admin','funcionario','cliente') NOT NULL,
 cliente_id INT NULL, salt VARBINARY(16) NOT NULL,
 senha_hash VARBINARY(32) NOT NULL,
 ativo BOOLEAN NOT NULL DEFAULT TRUE,
 ultimo_acesso DATETIME(6) NULL,
 criado_em DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 FOREIGN KEY(cliente_id) REFERENCES cliente(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Serviços fictícios de demonstração (inserção idempotente por nome).
INSERT INTO catalogo_servico(nome,descricao,preco_padrao,duracao_minutos)
SELECT x.nome,x.descricao,x.preco,x.duracao FROM (
 SELECT 'Limpeza residencial' nome,'Limpeza de apartamento ou casa' descricao,180.00 preco,180 duracao UNION ALL
 SELECT 'Manutenção elétrica','Diagnóstico e pequenos reparos elétricos',150.00,90 UNION ALL
 SELECT 'Instalação de ventilador','Instalação de ventilador de teto',220.00,120 UNION ALL
 SELECT 'Manutenção hidráulica','Reparo de torneiras e vazamentos',170.00,90
) x WHERE NOT EXISTS (SELECT 1 FROM catalogo_servico c WHERE c.nome=x.nome);

-- Dados fictícios de demonstração, sem informações reais.
INSERT INTO cliente(nome,telefone,email)
SELECT 'Cliente Demonstração','11999990000','cliente.demo@example.test'
WHERE NOT EXISTS(SELECT 1 FROM cliente WHERE email='cliente.demo@example.test');

INSERT INTO servico(cliente_id,catalogo_id,descricao,valor_previsto,status)
SELECT c.id,k.id,'Limpeza residencial demonstrativa',180.00,'agendado'
FROM cliente c JOIN catalogo_servico k ON k.nome='Limpeza residencial'
WHERE c.email='cliente.demo@example.test' AND NOT EXISTS(SELECT 1 FROM servico WHERE descricao='Limpeza residencial demonstrativa');

INSERT INTO agendamento(servico_id,inicio_em,fim_em)
SELECT s.id,UTC_TIMESTAMP()+INTERVAL 2 DAY,UTC_TIMESTAMP()+INTERVAL 2 DAY+INTERVAL 3 HOUR
FROM servico s WHERE s.descricao='Limpeza residencial demonstrativa'
AND NOT EXISTS(SELECT 1 FROM agendamento WHERE servico_id=s.id);
