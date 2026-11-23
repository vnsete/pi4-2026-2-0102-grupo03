# ServiHUB

Sistema web desenvolvido para auxiliar pequenos prestadores de serviços na organização de clientes, serviços, agendamentos, orçamentos e pagamentos.

O projeto foi desenvolvido como parte do **Projeto Integrador IV — Turma 0102, Grupo 03**, da PUC-Campinas.

## 1. Integrantes

- Breno Masiesque — 25020087
- Felipe Bianco Gaya dos Santos — 25008962
- João Victor Pensado — 25008630
- Samuel Henrique do Nascimento Pereira — 25005896
- Thiago Viel Denadai — 25004361
- Vinícius Logatto Costa Sete — 25003510

## 2. Tecnologias utilizadas

O ServiHUB foi desenvolvido utilizando:

- **Frontend:** HTML, CSS e JavaScript
- **Backend 1:** Java 17 e Maven
- **Backend 2:** Java 17 e Maven
- **Banco de dados:** MySQL 9.2
- **Servidor web:** Nginx
- **Contêineres:** Docker e Docker Compose
- **Testes automatizados:** JUnit 4 e JavaScript

## 3. Repositórios do projeto

O código foi organizado em quatro repositórios:

- [Repositório principal](https://github.com/vnsete/pi4-2026-2-0102-grupo03)
- [Backend 1](https://github.com/vnsete/pi4-0102-g3-backend-1)
- [Backend 2](https://github.com/vnsete/pi4-0102-g3-backend-2)
- [Frontend](https://github.com/vnsete/pi4-0102-g3-frontend)

O repositório principal contém os arquivos de configuração do Docker Compose, estrutura do banco de dados e documentação do projeto. Os demais repositórios armazenam o código de cada módulo.

## 4. Como executar o sistema

A execução do ServiHUB é realizada pelo Docker Compose, responsável por iniciar os quatro serviços necessários para o funcionamento da aplicação.

### 4.1 Pré-requisitos

Antes de iniciar, é necessário ter:

- Git instalado.
- Docker Desktop instalado e em execução, com suporte a Docker Compose v2.
- Conexão com a internet para baixar as imagens e dependências.
- Porta 3000 disponível no computador.

Não é necessário instalar Java, Maven ou MySQL diretamente no computador para executar a aplicação pelo Docker.

### 4.2 Clonar os repositórios

Abra o PowerShell ou outro terminal com Git instalado e execute:

```bash
git clone https://github.com/vnsete/pi4-2026-2-0102-grupo03.git
cd pi4-2026-2-0102-grupo03
```

Em seguida, clone os três módulos dentro da pasta principal:

```bash
git clone https://github.com/vnsete/pi4-0102-g3-backend-1.git backend-1
git clone https://github.com/vnsete/pi4-0102-g3-backend-2.git backend-2
git clone https://github.com/vnsete/pi4-0102-g3-frontend.git frontend
```

A estrutura esperada é:

```text
pi4-2026-2-0102-grupo03/
├── backend-1/
├── backend-2/
├── frontend/
├── db/
├── compose.yaml
├── nginx.conf
├── .env.example
└── README.md
```

### 4.3 Configurar as variáveis de ambiente

No PowerShell, ainda na pasta principal, execute:

```powershell
Copy-Item .env.example .env
notepad .env
```

O arquivo `.env` deve conter:

```dotenv
MYSQL_ROOT_PASSWORD=SENHA_LOCAL_DO_MYSQL
DB_PASSWORD=SENHA_LOCAL_DO_BANCO
INTERNAL_API_KEY=CHAVE_INTERNA_COM_32_OU_MAIS_CARACTERES
ADMIN_EMAIL=admin@servihub.local
ADMIN_PASSWORD=SENHA_LOCAL_DO_ADMINISTRADOR
```

Substitua os valores de exemplo pelas credenciais desejadas.

As variáveis são utilizadas para configurar o banco de dados, a comunicação entre os backends e o acesso do administrador ao sistema.

**Importante:** o arquivo `.env` contém informações sensíveis e não deve ser enviado ao GitHub.

### 4.4 Validar a configuração

Antes de iniciar os contêineres, execute:

```bash
docker compose config --quiet
```

Se o comando terminar sem apresentar mensagens de erro, a configuração foi aceita pelo Docker Compose.

### 4.5 Iniciar os contêineres

Execute:

```bash
docker compose up --build -d
```

O Docker irá construir as imagens dos backends, configurar o banco de dados e iniciar o servidor do Frontend.

Depois, confira o funcionamento dos serviços:

```bash
docker compose ps
```

Os quatro serviços esperados são:

| Serviço | Função |
|---|---|
| mysql | Armazenamento dos dados |
| backend-1 | Gerenciamento das funcionalidades principais |
| backend-2 | Funcionalidades complementares e integração |
| frontend | Interface web disponibilizada pelo Nginx |

O MySQL deverá apresentar o estado `healthy` após a inicialização.

### 4.6 Acessar o sistema

Com os contêineres iniciados, abra o navegador e acesse:

**http://localhost:3000**

Na tela de login, utilize o e-mail e a senha definidos nas variáveis `ADMIN_EMAIL` e `ADMIN_PASSWORD` do arquivo `.env`.

## 5. Funcionalidades

O ServiHUB reúne as principais atividades de um pequeno prestador de serviços em um único sistema.

Entre as funcionalidades desenvolvidas estão:

- Cadastro e consulta de clientes.
- Cadastro e consulta de endereços vinculados aos clientes.
- Gerenciamento do catálogo de serviços.
- Registro e acompanhamento dos serviços realizados.
- Criação e aprovação de orçamentos.
- Agendamento de atendimentos.
- Consulta da agenda.
- Controle de pagamentos.
- Consulta de pendências financeiras.
- Consulta de lembretes de atendimentos.
- Autenticação e controle de sessão.

## 6. Testes do projeto

Foram desenvolvidos testes automatizados para os dois backends e testes em JavaScript para verificar funcionalidades do Frontend.

### 6.1 Testes do Backend 1

O Backend 1 possui oito testes JUnit:

- Seis testes na classe `RegistrationTest.java`.
- Dois testes na classe `AccountPolicyTest.java`.

Para executar os testes utilizando Docker, abra o terminal na pasta principal do projeto.

**No PowerShell:**

```powershell
docker run --rm -v "${PWD}\backend-1:/app" -w /app maven:3.9-eclipse-temurin-17 mvn test
```

Resultado obtido na execução local de 23/11/2026:

```text
Tests run: 8, Failures: 0, Errors: 0, Skipped: 0
BUILD SUCCESS
```

### 6.2 Testes do Backend 2

O Backend 2 possui quatro testes JUnit na classe `FinancialAccessTest.java`, relacionados ao tratamento de rotas e métodos HTTP.

Para executar:

```powershell
docker run --rm -v "${PWD}\backend-2:/app" -w /app maven:3.9-eclipse-temurin-17 mvn test
```

Resultado obtido na execução local de 23/11/2026:

```text
Tests run: 4, Failures: 0, Errors: 0, Skipped: 0
BUILD SUCCESS
```

Caso o Maven já esteja instalado no computador, também é possível executar `mvn test` diretamente dentro da pasta de cada backend.

### 6.3 Teste do Frontend

O Frontend contém testes desenvolvidos em JavaScript.

O teste `agenda.test.cjs` verifica comportamentos relacionados ao calendário, duração dos atendimentos, bloqueio de datas, navegação e aprovação de orçamentos.

Para executar pelo Docker, utilize:

```powershell
docker run --rm -v "${PWD}\frontend:/app" -w /app node:22 node public/agenda.test.cjs
```

Resultado obtido em 23/11/2026:

```text
Calendário, duração, bloqueio de datas, navegação e aprovação: OK
```

O repositório do Frontend também possui outros arquivos de teste para funcionalidades operacionais, contas, financeiro e integração.

### 6.4 Resumo dos resultados

| Módulo | Resultado |
|---|---|
| Backend 1 | 8 testes JUnit aprovados |
| Backend 2 | 4 testes JUnit aprovados |
| Frontend | Teste automatizado de calendário aprovado |
| Docker Compose | Quatro serviços iniciados corretamente |

Os resultados apresentados correspondem às execuções locais realizadas em 23/11/2026.

A inicialização dos módulos integrados foi verificada com Docker Compose. A execução de todos os fluxos funcionais de ponta a ponta não está comprovada pelos testes listados acima.

## 7. Comandos úteis

Os comandos abaixo devem ser executados na pasta principal do projeto.

**Iniciar os serviços:**

```bash
docker compose up -d
```

**Parar os serviços:**

```bash
docker compose stop
```

**Reiniciar os serviços:**

```bash
docker compose restart
```

**Visualizar os contêineres:**

```bash
docker compose ps
```

**Consultar os logs:**

```bash
docker compose logs -f
```

**Reconstruir e iniciar novamente:**

```bash
docker compose up --build -d
```

**Parar e remover os contêineres:**

```bash
docker compose down
```

O banco de dados utiliza um volume persistente chamado `mysql_data`. Para preservar os dados armazenados, não utilize `docker compose down -v`, pois essa opção remove os volumes associados ao projeto.

## 8. Documentação do projeto

A documentação foi organizada entre o repositório principal e os repositórios dos módulos.

O projeto possui materiais relacionados a:

- Escopo e requisitos.
- Arquitetura e decisões arquiteturais.
- Estrutura do banco de dados.
- Contratos das APIs.
- Testes e correções.
- Instruções de execução.

Os contratos das APIs estão disponíveis nos repositórios dos respectivos backends.

O acompanhamento das atividades e dos defeitos encontrados durante o desenvolvimento foi realizado pelo OpenProject.

## 9. Limitações

O ServiHUB foi desenvolvido como um projeto acadêmico, com foco nas funcionalidades de gestão de serviços.

Não fazem parte do escopo funcionalidades como emissão de notas fiscais, boletos bancários ou marketplace.

A versão entregue também não possui um pipeline de integração contínua configurado no GitHub Actions nem resultados de análise de qualidade pelo SonarQube.

## 10. Versão do sistema

**Versão:** 1.0

**Projeto:** ServiHUB — Projeto Integrador IV

**Turma:** 0102 — Grupo 03

**Instituição:** PUC-Campinas

**Ano:** 2026

A versão 1.0 corresponde à entrega acadêmica do sistema, reunindo os módulos de Frontend, Backend 1, Backend 2 e banco de dados, com execução local por Docker Compose.
