# ServiHUB

Aplicação web voltada à gestão rotineira de pequenos prestadores de serviços.

## Integrantes
- Breno Masiesque - 25020087
- Felipe Bianco Gaya dos Santos - 25008962
- João Victor Pensado - 25008630
- Samuel Henrique do Nascimento Pereira - 25005896
- Thiago Viel Denadai - 25004361
- Vinícius Logatto Costa Sete - 25003510

# ServiHUB — instruções para execução

Aplicação acadêmica com frontend HTML/CSS/JS, dois backends Java 17 e banco MySQL 9.2. Esta é uma implementação inicial, não uma garantia de atendimento integral à especificação.

## Requisitos

- Docker Desktop instalado, iniciado e com suporte a Docker Compose.
- Portas 3000 disponíveis; internet para baixar as imagens Docker e dependências Maven na primeira execução.
- Windows PowerShell ou outro terminal compatível.

## Primeira execução (Windows)

1. Extraia o ZIP inteiro, mantendo as pastas.
2. Abra o PowerShell na pasta que contém este README e `docker-compose.yml`.
3. Execute `Copy-Item .env.exemplo .env`.
4. Abra `.env` em um editor e substitua os três valores por credenciais suas. A `INTERNAL_API_KEY` deve ter ao menos 32 caracteres; não use os valores de exemplo.
5. Execute `docker compose config` e corrija eventuais mensagens.
6. Execute `docker compose up --build -d`. Aguarde a inicialização.
7. Verifique `docker compose ps` e, se necessário, `docker compose logs --tail=100`.
8. Abra http://localhost:3000 e entre com `ADMIN_EMAIL` e `ADMIN_PASSWORD` definidos antes da primeira inicialização.

**Importante:** o administrador é criado no primeiro início do banco. Alterar ADMIN_PASSWORD depois disso não redefine automaticamente a senha existente. Não apague volumes para tentar corrigir o login, pois isso apaga dados.

## Fluxo do atendimento

1. Cadastre o cliente em **Clientes** e o produto ou serviço no catálogo em **Serviços**.
2. Em **Orçamentos**, selecione o cliente e o item, confira o valor e crie o orçamento.
3. Quando o cliente confirmar, clique em **Aprovar orçamento**. A **Agenda** abre com o atendimento selecionado.
4. Escolha o dia e o horário. O término é calculado pela duração do serviço.
5. Em **Pagamentos**, selecione o serviço para registrar a data, antes ou depois de agendar.

## Comandos úteis

- Iniciar novamente: `docker compose up -d`
- Parar sem apagar os dados: `docker compose down`
- Acompanhar erros: `docker compose logs -f`
- Inspecionar o banco: `docker compose exec mysql mysql -uservihub -pservihub_local servihub_pdf`
- Teste local do calendário (com Node.js instalado): `node frontend/agenda.test.cjs`
- Teste da API: `node frontend/agenda-api.test.cjs` (requer aplicação em execução e pode exigir condições específicas de teste).

**Nunca use** `docker compose down -v` se quiser preservar o banco. As credenciais de MySQL no compose são de desenvolvimento local; não exponha esta instalação à internet sem configuração de segurança adicional.

## Problemas frequentes

- Docker não reconhecido: instale/inicie Docker Desktop e reabra o terminal.
- Porta 3000 ocupada: encerre o programa conflitante ou ajuste a porta no `docker-compose.yml`.
- `INTERNAL_API_KEY` inválida: substitua o valor no `.env` por chave longa e reinicie os serviços.
- Login falhou: confira as credenciais usadas na **primeira inicialização** e os logs do backend-1.
- Erro de banco: confira `docker compose ps` e os logs do mysql e backend-1; não remova volumes existentes sem backup.

## Escopo e limitações

Inclui cadastro de clientes, catálogo, serviços, agenda, orçamentos e pagamentos. A entrega ainda precisa de validação funcional integrada e revisão de regras da especificação. Não há emissão de notas fiscais, boletos ou marketplace.
