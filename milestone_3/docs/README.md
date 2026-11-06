# FilaCidadã: índice da documentação do projeto

Milestones M1, M2 e M3 · Unidade: Engenharia de Software (Fábrica de Software I)

Este é o ponto de entrada da documentação de projeto. A documentação técnica da API (rotas, autenticação, banco, GraphQL) fica em `documentacao/`, e o `README.md` da raiz descreve como rodar o sistema. Aqui ficam o contexto do projeto, a equipe, o cliente, os catálogos de IDs e o mapa de todos os artefatos.

## Projeto

O FilaCidadã é uma API para gestão de filas de atendimento presencial e online. O cidadão retira uma senha pelo celular ou escaneando um QR Code; o operador chama, atende e finaliza; o administrador da instituição configura filas, mesas, tipos de etapa e QR Codes e acompanha o painel; o administrador da plataforma aprova as instituições que solicitam acesso.

A implementação usa Node.js 22 com Express 5, PostgreSQL com Prisma, autenticação por sessão do BetterAuth, Socket.IO para tempo real e Apollo Server 5 para GraphQL ao lado do REST. O código é a fonte da verdade: quando um documento diverge dele, vale o código e a divergência é registrada na seção [Divergências](#divergências).

## Equipe (fictícia)

Equipe 04, "Fila Certa". Os integrantes são identificados pelo papel no projeto, não pelo nome.

| Papel no projeto | Responsabilidade principal |
|---|---|
| Gerente de projeto | Planejamento, milestones, quadro de issues e cronograma |
| Analista de requisitos | Requisitos funcionais e não funcionais, histórias e backlog |
| Analista de modelagem | Casos de uso, classes, sequência, estados e OCL |
| Projetista de interface | Protótipo, mapa do site, IFML e wireframes |
| Responsável pelo banco | Modelo conceitual, lógico, dicionário e schema SQL |
| Responsável pela qualidade | Matriz de rastreabilidade, monitorias e retrospectivas |

## Cliente (fictício)

Rede Municipal de Atendimento Cidadão, órgão público fictício que atende o público em postos presenciais e por canal online. Quer reduzir a espera nas filas, dar transparência ao cidadão sobre a posição na fila e permitir que cada posto configure suas próprias filas e mesas sem depender da equipe de tecnologia.

## Atores

| ID | Ator | Papel no código (`src/constants/roles.js`) | Quem é |
|---|---|---|---|
| ACT-01 | Cidadão | `USUARIO_FINAL` | Retira senha online ou presencial e acompanha o atendimento |
| ACT-02 | Operador | `OPERADOR` | Chama, rechama, assume, finaliza ou cancela senhas |
| ACT-03 | Administrador da Instituição | `ADMIN_INSTITUICAO` | Configura filas, mesas, tipos de etapa, QR Codes e usuários da instituição |
| ACT-04 | Administrador da Plataforma | `ADMIN_PLATAFORMA` | Avalia solicitações de instituição e visão global do sistema |

Um usuário pode acumular papéis (tabela `UsuarioPapel`). Os papéis do código não mudam os nomes do catálogo acima.

## Milestones

| Milestone | Foco | Pasta principal |
|---|---|---|
| M1 | Visão do produto, processo, requisitos, histórias e protótipo | `01-visao/`, `02-processo/`, `03-requisitos/`, `04-prototipo/` |
| M2 | Modelagem: casos de uso, classes, sequência, atividades, estados e OCL | `05-modelagem/` e métricas do GitLab da M2 |
| M3 | Banco de dados, rastreabilidade, qualidade e entrega final | `06-banco-de-dados/`, `07-rastreabilidade/`, `08-qualidade/` |

Cada entrega de milestone tem um resumo em `09-entregas/`. O histórico de mudanças da documentação está em [CHANGELOG](CHANGELOG.md).

## Documentos

Status: "Em elaboração" indica que o artefato está sendo produzido nesta etapa. Atualize a coluna ao concluir cada documento.

| Documento | Conteúdo | Milestone | Status |
|---|---|---|---|
| [01-visao/README.md](01-visao/README.md) | Índice da visão do produto | M1 | Em elaboração |
| [01-visao/rfp.md](01-visao/rfp.md) | Pedido do cliente e escopo do projeto | M1 | Em elaboração |
| [01-visao/pm-canvas.md](01-visao/pm-canvas.md) e [.svg](01-visao/pm-canvas.svg) | PM Canvas do projeto | M1 | Em elaboração |
| [01-visao/glossario.md](01-visao/glossario.md) | Termos do domínio e do projeto | M1 | Em elaboração |
| [02-processo/README.md](02-processo/README.md) | Processo de desenvolvimento | M1 | Em elaboração |
| [02-processo/fluxo-processo.svg](02-processo/fluxo-processo.svg) | Fluxo do processo | M1 | Em elaboração |
| [02-processo/bpmn/README.md](02-processo/bpmn/README.md) | Processo atual (as-is) em BPMN e SVG | M1 | Em elaboração |
| [02-processo/metricas/README.md](02-processo/metricas/README.md) | Kanban e métricas exportadas do GitLab (M2 e M3) | M2 e M3 | Em elaboração |
| [03-requisitos/requisitos-funcionais.md](03-requisitos/requisitos-funcionais.md) | Requisitos funcionais e mapeamento UC para RF | M1 | Em elaboração |
| [03-requisitos/requisitos-nao-funcionais.md](03-requisitos/requisitos-nao-funcionais.md) | Requisitos não funcionais | M1 | Em elaboração |
| [03-requisitos/historias-de-usuario.md](03-requisitos/historias-de-usuario.md) | Histórias de usuário (US) | M1 | Em elaboração |
| [03-requisitos/backlog.md](03-requisitos/backlog.md) | Backlog priorizado | M1 | Em elaboração |
| [03-requisitos/rastreabilidade-requisitos.svg](03-requisitos/rastreabilidade-requisitos.svg) | Rastreabilidade entre requisitos e histórias | M1 | Em elaboração |
| [04-prototipo/README.md](04-prototipo/README.md) | Índice do protótipo | M1 | Em elaboração |
| [04-prototipo/site-map.md](04-prototipo/site-map.md) e [.svg](04-prototipo/site-map.svg) | Mapa do site por perfil | M1 | Em elaboração |
| [04-prototipo/ifml/README.md](04-prototipo/ifml/README.md) | Modelo IFML em SVG | M1 | Em elaboração |
| [04-prototipo/wireframes/README.md](04-prototipo/wireframes/README.md) | Wireframes por perfil (telas `T-<perfil>-NN`) | M1 | Em elaboração |
| [05-modelagem/README.md](05-modelagem/README.md) | Índice da modelagem UML | M2 | Em elaboração |
| [05-modelagem/casos-de-uso/README.md](05-modelagem/casos-de-uso/README.md) | Diagrama e descrição dos casos de uso (UC-01 a UC-15) | M2 | Em elaboração |
| [05-modelagem/classes/README.md](05-modelagem/classes/README.md) | Diagrama de classes do domínio | M2 | Em elaboração |
| [05-modelagem/sequencia/README.md](05-modelagem/sequencia/README.md) | Diagramas de sequência (`seq-*.svg`) | M2 | Em elaboração |
| [05-modelagem/atividades/README.md](05-modelagem/atividades/README.md) | Diagramas de atividade (`ativ-*.svg`) | M2 | Em elaboração |
| [05-modelagem/estados/README.md](05-modelagem/estados/README.md) | Diagramas de estado (`estado-*.svg`) | M2 | Em elaboração |
| [05-modelagem/ocl/README.md](05-modelagem/ocl/README.md) | Restrições em OCL | M2 | Em elaboração |
| [05-modelagem/ocl/divergencias-m2.md](05-modelagem/ocl/divergencias-m2.md) | Divergências entre OCL e código levantadas na M2 | M2 | Em elaboração |
| [06-banco-de-dados/README.md](06-banco-de-dados/README.md) | Índice do banco de dados | M3 | Em elaboração |
| [06-banco-de-dados/modelo-conceitual.svg](06-banco-de-dados/modelo-conceitual.svg) | Modelo conceitual | M3 | Em elaboração |
| [06-banco-de-dados/modelo-logico.svg](06-banco-de-dados/modelo-logico.svg) | Modelo lógico | M3 | Em elaboração |
| [06-banco-de-dados/dicionario-de-dados.md](06-banco-de-dados/dicionario-de-dados.md) | Dicionário de dados | M3 | Em elaboração |
| [06-banco-de-dados/schema.sql](06-banco-de-dados/schema.sql) | Esquema SQL | M3 | Em elaboração |
| [07-rastreabilidade/matriz.md](07-rastreabilidade/matriz.md) | Matriz de rastreabilidade (IDs em tabela) | M3 | Em elaboração |
| [07-rastreabilidade/lacunas.md](07-rastreabilidade/lacunas.md) | Elos da malha que ainda faltam | M3 | Em elaboração |
| [07-rastreabilidade/malha-rastreabilidade.svg](07-rastreabilidade/malha-rastreabilidade.svg) | Malha de rastreabilidade completa | M3 | Em elaboração |
| [08-qualidade/monitorias.md](08-qualidade/monitorias.md) | Registro das monitorias de qualidade | M3 | Em elaboração |
| [08-qualidade/retrospectiva-swebok.md](08-qualidade/retrospectiva-swebok.md) | Retrospectiva com base no SWEBOK | M3 | Em elaboração |
| [08-qualidade/retrospectiva-final.md](08-qualidade/retrospectiva-final.md) | Retrospectiva final do projeto | M3 | Em elaboração |
| [09-entregas/milestone-1.md](09-entregas/milestone-1.md) | Entrega da M1 | M1 | Em elaboração |
| [09-entregas/milestone-2.md](09-entregas/milestone-2.md) | Entrega da M2 | M2 | Em elaboração |
| [09-entregas/milestone-3.md](09-entregas/milestone-3.md) | Entrega da M3 | M3 | Em elaboração |
| [templates/](templates/) | Modelos de caso de uso, história, requisito e ADR | Apoio | Em elaboração |
| [adr/README.md](adr/README.md) | Registros de decisões de arquitetura (ADR) | Apoio | Em elaboração |
| [CHANGELOG.md](CHANGELOG.md) | Histórico de mudanças da documentação | Apoio | Em elaboração |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Fluxo de contribuição no GitLab | Apoio | Em elaboração |

## Árvore

```text
docs/
├── README.md                  este índice
├── CHANGELOG.md               histórico da documentação por milestone
├── CONTRIBUTING.md            fluxo GitLab: issues, branches, MR e critério de pronto
├── 01-visao/                  visão do produto (RFP, PM Canvas, glossário)
├── 02-processo/               processo, BPMN as-is e métricas do GitLab
├── 03-requisitos/             RF, RNF, histórias, backlog e rastreabilidade
├── 04-prototipo/              mapa do site, IFML e wireframes por perfil
│   ├── ifml/
│   └── wireframes/            pub, cidadao, operador, admin-instituicao, admin-plataforma
├── 05-modelagem/              UML: casos de uso, classes, sequência, atividades, estados, OCL
├── 06-banco-de-dados/         modelos conceitual e lógico, dicionário, schema.sql
├── 07-rastreabilidade/        matriz, lacunas e malha de rastreabilidade
├── 08-qualidade/              monitorias e retrospectivas
├── 09-entregas/               uma entrega por milestone
├── templates/                 modelos de caso de uso, história, requisito e ADR
└── adr/                       decisões de arquitetura numeradas
```

O `README.md` da raiz do repositório é o da API. Este é o índice do projeto e fica em `docs/README.md`.

## Catálogo de casos de uso

Os IDs abaixo são fixos e aparecem com o mesmo sentido em todos os documentos.

| ID | Caso de uso | Ator principal |
|---|---|---|
| UC-01 | Autenticar-se (cadastro, login, logout) | ACT-01, ACT-02, ACT-03, ACT-04 |
| UC-02 | Gerenciar perfil | Todos os atores autenticados |
| UC-03 | Solicitar cadastro de instituição | ACT-03 |
| UC-04 | Avaliar solicitação de instituição (aprovar, rejeitar, reconsiderar) | ACT-04 |
| UC-05 | Gerenciar usuários e papéis | ACT-03, ACT-04 |
| UC-06 | Gerenciar filas | ACT-03, ACT-02 |
| UC-07 | Configurar tipos de etapa | ACT-03 |
| UC-08 | Emitir senha online | ACT-01 |
| UC-09 | Emitir senha presencial | ACT-02 |
| UC-10 | Chamar, rechamar e assumir senha | ACT-02 |
| UC-11 | Finalizar ou cancelar atendimento | ACT-02 |
| UC-12 | Gerenciar QR Codes | ACT-03 |
| UC-13 | Consultar dashboard e estatísticas | ACT-03, ACT-04 |
| UC-14 | Consultar auditoria | ACT-03, ACT-04 |
| UC-15 | Acompanhar minha senha (meu atendimento) | ACT-01 |

Requisitos funcionais seguem a convenção RF-0xx ligada ao UC, na ordem do catálogo (UC-01 a RF-001 a RF-003, e assim por diante). A tabela final de mapeamento está em [requisitos-funcionais.md](03-requisitos/requisitos-funcionais.md). Histórias são numeradas US-001 em diante, na ordem dos UC.

Convenções de outros IDs:

- Telas: `T-<perfil>-NN`, com perfis CID (cidadão), OPE (operador), ADI (administrador da instituição), ADP (administrador da plataforma) e PUB (públicas e login). Exemplo: `T-CID-01`.
- Classes de domínio: nomes em português, no singular, derivados do schema (`Usuario`, `Instituicao`, `Fila`, `Mesa`, `Senha`, `QrCode`, `Auditoria`, `Notificacao`, `LandingPage`).

## Como ler a malha de rastreabilidade

A malha (`07-rastreabilidade/malha-rastreabilidade.svg`) mostra os elos entre os artefatos. Cada elo é um ID do catálogo, e o mesmo ID aparece em todos os documentos que tratam daquela parte do sistema. A cadeia vai do objetivo até a tela e a regra:

1. **Ator** (ACT-xx) realiza um **caso de uso** (UC-xx).
2. O caso de uso se desdobra em **requisitos funcionais** (RF-0xx) e em **histórias** (US-xxx).
3. A história é realizada por **telas** (T-<perfil>-NN) do protótipo.
4. O caso de uso usa **classes** (diagrama de classes) e é descrito por **sequência**, **atividades** e **estados**.
5. As regras de negócio que não cabem no diagrama ficam em **OCL**, e as classes viram tabelas no modelo de dados.

Para verificar um elo, busque o ID no repositório de documentos com `rg "UC-06" docs/`. A matriz (`07-rastreabilidade/matriz.md`) é a mesma informação em tabela. O arquivo `07-rastreabilidade/lacunas.md` lista os elos que ainda faltam, e uma história sem elo completo é uma lacuna a resolver antes do fechamento da milestone.

## Divergências

Onde o catálogo ou o texto de referência deste índice não bate com o código, vale o código (`src/`, `prisma/schema.prisma`).

1. **UC-15 "Acompanhar minha senha (meu atendimento)"**: a rota `GET /senhas/meu-atendimento` é a fila de atendimento do operador e do administrador da instituição (`authorize(OPERADOR, ADMIN_INSTITUICAO)`), não o acompanhamento do cidadão. O cidadão acompanha a senha por `GET /publico/senhas/:token/status` (sem login) e lista as próprias senhas em `GET /senhas`, que retorna as dele quando o papel é `USUARIO_FINAL`. Os casos de uso e as telas devem usar essas rotas.
2. **UC-01 "cadastro, login, logout"**: não há rotas próprias para isso. Cadastro, login e logout são do BetterAuth, em `/api/auth/sign-up/email`, `/api/auth/sign-in/email` e `/api/auth/sign-out`. As rotas `/auth/*` foram removidas em 30/09/2026, e só `GET /auth/me` permanece.
3. **Papel como classe**: o catálogo lista `Papel` como classe, mas no schema `Papel` é um `enum` e a relação com o usuário é a tabela de junção `UsuarioPapel` (N para N). Um usuário pode ter mais de um papel.
4. **UC-05 "gerenciar usuários e papéis"**: não existe rota própria de papéis. Os papéis são enviados no campo `papeis` de `POST /instituicoes/:instituicaoId/usuarios` e `PATCH /usuarios/:id`.

Veja também: [CHANGELOG](CHANGELOG.md) · [Como contribuir](CONTRIBUTING.md) · [Documentação técnica da API](../documentacao/README.md) · [README da API](../README.md) · [Histórico técnico](../documentacao/12-historico.md) · [Visão do produto](01-visao/README.md) · [Requisitos funcionais](03-requisitos/requisitos-funcionais.md) · [Matriz de rastreabilidade](07-rastreabilidade/matriz.md)
