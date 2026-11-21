# ServiHUB

Sistema web desenvolvido para auxiliar pequenos prestadores de serviços no gerenciamento de clientes, agendamentos, orçamentos e pagamentos.

## Integrantes

- Breno Masiesque - 25020087
- Felipe Bianco Gaya dos Santos - 25008962
- João Victor Pensado - 25008630
- Samuel Henrique do Nascimento Pereira - 25005896
- Thiago Viel Denadai - 25004361
- Vinícius Logatto Costa Sete - 25003510

## Tecnologias

- Frontend: HTML, CSS e JavaScript
- Backends: Java 17 e Maven
- Banco de dados: MySQL 9.2
- Testes: JUnit
- Infraestrutura: Docker Compose e Nginx

## Repositórios

- [Projeto principal](https://github.com/vnsete/pi4-2026-2-0102-grupo03)
- [Backend 1](https://github.com/vnsete/pi4-0102-g3-backend-1)
- [Backend 2](https://github.com/vnsete/pi4-0102-g3-backend-2)
- [Frontend](https://github.com/vnsete/pi4-0102-g3-frontend)

## Como executar

**Pré-requisitos:** Git, Docker Desktop em funcionamento, internet e porta 3000 disponível.

**1. Clone os repositórios:**

```bash
git clone https://github.com/vnsete/pi4-2026-2-0102-grupo03.git
cd pi4-2026-2-0102-grupo03

git clone https://github.com/vnsete/pi4-0102-g3-backend-1.git backend-1
git clone https://github.com/vnsete/pi4-0102-g3-backend-2.git backend-2
git clone https://github.com/vnsete/pi4-0102-g3-frontend.git frontend
```

**2. Configure o ambiente:**

No PowerShell:

```powershell
Copy-Item .env.example .env
```

Edite o `.env` com as senhas do MySQL, chave interna e credenciais do administrador.

**3. Inicie o sistema:**

```bash
docker compose config
docker compose up --build -d
docker compose ps
```

**4. Acesse:**

http://localhost:3000

Entre com as credenciais `ADMIN_EMAIL` e `ADMIN_PASSWORD` configuradas no `.env`.

## Funcionalidades

- Cadastro e consulta de clientes e endereços.
- Gerenciamento de serviços e orçamentos.
- Agenda de atendimentos.
- Registro e acompanhamento de pagamentos.
- Consulta de lembretes e pendências.

## Testes

Os backends possuem testes automatizados com JUnit.

```bash
cd backend-1
mvn test

cd ../backend-2
mvn test
```

**Resultados obtidos:** Backend 1 com 8 testes aprovados e Backend 2 com 4 testes aprovados, sem falhas ou erros.

As imagens Docker dos dois backends também foram construídas com sucesso. A execução integrada dos módulos ainda precisa ser validada.

## Comandos úteis

```bash
docker compose up -d
docker compose down
docker compose logs -f
```

Para preservar os dados, não utilize `docker compose down -v`.

## Documentação

Os contratos das APIs estão nos respectivos repositórios dos backends. A especificação, o escopo, as decisões arquiteturais e os arquivos do banco estão no repositório principal.

## Limitações

O projeto não contempla emissão de notas fiscais, boletos ou marketplace, por exemplo.
