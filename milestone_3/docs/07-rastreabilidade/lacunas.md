# Lacunas e órfãos de rastreabilidade

Milestone 2 · Fábrica de Software I · Unidade de rastreabilidade

Responde às quatro perguntas de rastreabilidade, lista os órfãos nos dois sentidos e registra cada lacuna com ação, issue e prazo. A tabela base está em [matriz.md](matriz.md). Os números de issue são fictícios (formato `#n` do GitLab do grupo) e devem ser trocados pelos reais ao abrir. Os prazos são sugeridos a partir de 06/11/2026.

## Resumo das quatro perguntas

| Pergunta | Resposta | Situação |
|---|---|---|
| Toda US tem UC? | Sim: 41 de 41 têm "Vínculo: UC-xx". Cinco vínculos são forçados (D-13). Nenhuma US declara RF. | Parcial |
| Todo dado do wireframe existe em classe? | Não. Em 38 SVGs, cinco dados de domínio estão ausentes, há oito dúvidas e quatro divergências entre tela e schema. | Não |
| Todo cenário principal tem sequência? | Não. Seis diagramas: quatro UC completos, dois parciais, nove sem diagrama. | Não |
| Toda classe com status tem máquina de estados? | Sim. Instituicao, Senha e RastreioFluxo têm diagrama. Um estado de RastreioFluxo não tem método que o grave. | Sim, com ressalva |

## 1. Órfãos

### 1.1 Requisitos sem elo

| Elo ausente | RF | Qtde |
|---|---|---|
| US | RF-011, RF-015, RF-016, RF-017, RF-018, RF-019, RF-025, RF-029, RF-030, RF-031, RF-046, RF-048 | 12 |
| Tela | RF-003, RF-004, RF-014, RF-016, RF-023, RF-028, RF-029, RF-030, RF-031, RF-043, RF-044, RF-047, RF-055, RF-061, RF-062 | 15 |
| Teste | RF-001, RF-004, RF-010, RF-015, RF-018, RF-019, RF-025, RF-029, RF-031, RF-032, RF-033, RF-048, RF-052, RF-053, RF-056, RF-062 | 16 |

RF sem sequência (54) não são órfãos: o diagrama cobre só cenário principal. Essa parte está na pergunta 3.

### 1.2 Itens sem requisito (sentido inverso)

| Item | Onde está | Situação |
|---|---|---|
| `GET /examples` | `src/routes/exampleRoutes.js` | Aceito: modelo de exemplo, excluído do levantamento (divergência 6 de `requisitos-funcionais.md`) |
| `GET /`, `GET /docs`, `GET /docs.json` | `src/routes/index.js` | Aceito: infraestrutura |
| API GraphQL (`/graphql`) | `src/graphql/` e `src/tests/graphql/graphql.spec.js` | Lacuna L-08: nenhum RF cita GraphQL |
| Testes de camadas de suporte | `src/tests/unit/utils/*`, `unit/middleware/asyncWrapper.test.js`, `unit/schema/restricoes.test.js`, `unit/repository/*`, `unit/controllers/*`, `unit/UsuarioService_mock.test.js` | Aceito: sustentam RF sem cobrir um RF próprio |
| Testes com RF indireto | `unit/infra/NpaasClient.test.js` (RF-064, envio de notificação); `unit/services/EventBusService.test.js` (RF-065, tempo real) | Não listados na matriz; a coluna Teste pode incluí-los em revisão futura |
| Tabelas `sessions`, `accounts`, `verifications` | `prisma/schema.prisma` (BetterAuth) | Aceito: fora das classes de domínio |
| Enum `Papel` e modelo `UsuarioPapel` | `prisma/schema.prisma` | Lacuna L-18: o briefing lista a classe `Papel`, o modelo de classes não a tem |
| Telas sem RF declarado | READMEs de `04-prototipo/wireframes/` | Lacuna L-06 |

Todas as 16 classes oficiais aparecem em pelo menos um RF, e todas as 41 US aparecem em pelo menos um RF na matriz.

## 2. As quatro perguntas em detalhe

### 2.1 Toda US tem UC?

- Sim: as 41 histórias trazem `Vínculo: UC-xx`.
- Cinco vínculos não constam do catálogo de casos de uso (D-13 de `historias-de-usuario.md`): US-003 (recuperação de senha, UC-01), US-027 (assumir atendimento, UC-10), US-030 (flow, UC-11), US-040 (chat, UC-15) e US-041 (notificações, UC-15). Lacuna L-03.
- Toda US tem RF? Não declarado. As 41 histórias trazem "RF: pendente". A matriz deriva o vínculo por endpoint e UC; 53 RF ficam com pelo menos uma US. Lacuna L-02.

### 2.2 Todo dado do wireframe existe em classe?

Conferência item a item dos 38 SVGs (pub 3, cidadão 12, operador 7, admin-instituição 9, admin-plataforma 7). Foram lidos os textos visíveis de cada tela e descartados botões, títulos, navegação e textos de ajuda. Atributos conferidos contra `prisma/schema.prisma` e o modelo de classes.

Dados de domínio ausentes:

- Início e chamada do atendimento ("Iniciado às 09:42", "Chamada às 09:42", tempo médio no dashboard). `Senha` não tem campo de chamada nem de início. Mais próximo: Auditoria (CHAMAR_SENHA). Lacuna L-09.
- Data de finalização e de cancelamento ("Finalizadas hoje", datas no histórico do cidadão). Não há `finalizadaEm` nem `canceladaEm`. Mais próximo: Auditoria (FINALIZAR_SENHA, CANCELAR_SENHA) ou `updatedAt`. Lacuna L-09.
- Criador da senha ("Emitida por Ana Souza", recibo do operador). Não há `criadoPorId`. Mais próximo: Auditoria.usuarioId (CRIAR_SENHA). Lacuna L-10.
- Vínculo operador-estação ("Estação: Guichê 1" no painel). Não há FK; `Senha.mesa` é texto. Lacuna L-11.
- Observação enviada na aprovação (ADP-02). `Instituicao` não tem o campo; `motivoRejeicao` serve só para rejeição. Lacuna L-12.

Ausente do domínio, aceito: senha de acesso (login, cadastro, senha inicial), que fica em `Account.password` do BetterAuth.

Dúvidas (sem regra clara no código ou no schema): convite por e-mail (ADI-05); bloqueio após tentativas de login (PUB-02); conteúdo de `Notificacao.dados` (cidadão, tela 07); limite de 500 caracteres na descrição (ADI-08); definição de "abandono" (ADI-01 e ADP-01); data exibida no histórico do cidadão (tela 05); fonte do fuso horário no cabeçalho (`Usuario.fusoHorario` ou `Instituicao.configuracoes`); definição de "prioritárias" (OPE-01). Lacunas L-17, L-21 e L-22.

Divergências entre tela e schema:

- Número da senha "único por instituição" (OPE-03). O schema tem só índice não único, e INV-09 da OCL diz o contrário. Lacuna L-13.
- Exclusão de fila (ADP-03): a tela diz que é bloqueada quando um passo de flow aponta para a fila com histórico. O schema (`FlowStep.fila`, `onDelete: Restrict`) bloqueia qualquer passo. Lacuna L-14.
- ADI-07 cita a "divergência 3 do README" para datas. A divergência 3 trata de TipoEtapa. Lacuna L-15.
- Nomes de estação ("Guichê 1", "Estação 1", "Balcão 1", "Estação 3") não seguem `Mesa.numero` e `Mesa.nome`. Lacuna L-16.

Resposta: não. As divergências 1 e 2 do modelo de classes (NORMAL gravado como nulo; `Senha.mesa` sem FK) já estão registradas no próprio README de classes.

### 2.3 Todo cenário principal tem sequência?

| UC | Cenário principal | Diagrama | Situação |
|---|---|---|---|
| UC-01 | Login, cadastro, logout | `seq-login.svg` (login) | Parcial: cadastro e logout sem diagrama |
| UC-02 | Editar perfil, senha, avatar | Nenhum | Não |
| UC-03 | Solicitar cadastro de instituição | Nenhum | Não |
| UC-04 | Aprovar, rejeitar, reconsiderar | `seq-aprovar-instituicao.svg` | Parcial: rejeitar e reconsiderar sem diagrama |
| UC-05 | Gerenciar usuários e papéis | Nenhum | Não |
| UC-06 | Gerenciar filas e flows | Nenhum | Não |
| UC-07 | Configurar tipos de etapa | Nenhum | Não |
| UC-08 | Emitir senha online | `seq-emitir-senha-online.svg` | Sim |
| UC-09 | Emitir senha presencial | `seq-emitir-senha-presencial.svg` | Sim |
| UC-10 | Chamar, rechamar, assumir | `seq-chamar-senha.svg` | Sim |
| UC-11 | Finalizar ou cancelar | `seq-finalizar-cancelar.svg` | Sim; alta no flow sem diagrama |
| UC-12 | Gerenciar QR Codes | Nenhum | Não |
| UC-13 | Dashboard e estatísticas | Nenhum | Não |
| UC-14 | Consultar auditoria | Nenhum | Não |
| UC-15 | Acompanhar senha, chat, notificações | Nenhum | Não |

Resultado: quatro completos, dois parciais e nove sem diagrama. O `sequencia/README.md` afirma que os seis diagramas "cobrem os cenários principais", o que não se sustenta para os UC 02, 03, 05 a 07, 12 a 15. Lacuna L-19.

### 2.4 Toda classe com status tem máquina de estados?

| Classe | Campo e enum | Diagrama | Situação |
|---|---|---|---|
| Instituicao | `status`, `StatusInstituicao` | `estado-instituicao.svg` | Coberta. O campo `ativo` aparece em nota do diagrama |
| Senha | `status`, `StatusSenha` | `estado-senha.svg` | Coberta |
| RastreioFluxo | `status`, `SenhaFlowStatus` | `estado-senha-flow.svg` | Coberta. O estado CANCELADO não tem método que o grave (L-20) |

Classes com flag booleana (`Usuario.ativo`, `Fila.ativa`, `Mesa.ativa`, `TipoEtapa.ativo`, `QrCode.ativo`, `Fluxo.ativo`, `EtapaFluxo.ativo`) não têm diagrama. São tratadas como flag de ativação, não como máquina de estados. Aceito.

Resposta: sim, com a ressalva de L-20.

## 3. Lacunas e ações

| ID | Elo | Lacuna | Ação | Issue | Prazo |
|---|---|---|---|---|---|
| L-01 | US | 12 RF sem história | Criar histórias para RF-011, 015 a 019, 025, 029 a 031, 046 e 048 | #101 | 13/11/2026 |
| L-02 | US | 41 histórias com "RF: pendente" | Preencher o campo RF em `historias-de-usuario.md` a partir da matriz | #102 | 10/11/2026 |
| L-03 | UC | 5 histórias com UC fora do catálogo (D-13) | Incluir recuperação de senha, assumir, flow, chat e notificações no catálogo ou criar UC próprios | #103 | 13/11/2026 |
| L-04 | Teste | 16 RF sem teste | Criar testes para RF-001, 004, 010, 015, 018, 019, 025, 029, 031, 032, 033, 048, 052, 053, 056 e 062, ou registrar no backlog | #104 | 20/11/2026 |
| L-05 | Teste | Testes só de serviço para tipos de etapa, flows, QR Codes, auditoria, dashboard, chat e notificações | Criar specs de rota para as rotas desses RF | #105 | 20/11/2026 |
| L-06 | Tela | 15 RF sem tela; 23 telas (ADI, ADP, OPE) sem RF declarado | Preencher RF nos READMEs dos perfis; criar telas para RF-014, 016, 023, 028, 055 e 061, ou marcar como sem tela | #106 | 13/11/2026 |
| L-07 | Tela | IDs de tela inconsistentes: ADI-xx e ADP-xx sem prefixo `T-`, enquanto o briefing pede `T-<perfil>-NN` | Padronizar os IDs e atualizar os links | #107 | 09/11/2026 |
| L-08 | RF | API GraphQL sem RF | Criar RF para as operações GraphQL (saúde, usuários, eu, filas, login e logout) | #108 | 13/11/2026 |
| L-09 | Classe e tabela | Sem campo de chamada, início, finalização e cancelamento de atendimento; tempo médio do dashboard sem fonte | Decidir entre novos campos em `Senha` ou leitura pela Auditoria. Mudança de schema depende de decisão da equipe | #109 | 20/11/2026 |
| L-10 | Classe | Sem criador da senha (`criadoPorId`) | Decidir entre novo campo ou uso de Auditoria (CRIAR_SENHA) | #110 | 20/11/2026 |
| L-11 | Classe | Operador e estação sem vínculo (`Senha.mesa` é texto) | Criar FK ou aceitar texto e registrar a decisão no modelo de classes | #111 | 20/11/2026 |
| L-12 | Classe | Observação de aprovação sem campo (ADP-02) | Remover a observação da tela ou criar o campo em `Instituicao` | #112 | 20/11/2026 |
| L-13 | Regra | Número da senha não é único por instituição no schema, mas INV-09 diz que é | Decidir: índice único em `(instituicaoId, numero)` ou corrigir a OCL | #113 | 13/11/2026 |
| L-14 | Regra | Exclusão de fila: tela e schema descrevem regras diferentes | Alinhar a tela ADP-03 ao `onDelete: Restrict` ou ajustar o schema | #114 | 13/11/2026 |
| L-15 | Documentação | ADI-07 cita divergência errada do README | Corrigir a referência | #115 | 13/11/2026 |
| L-16 | Classe | Nomes de estação inconsistentes entre telas e `Mesa` | Adotar uma convenção (numero, nome) e aplicar nas telas | #116 | 20/11/2026 |
| L-17 | Regra | Fuso horário em duas fontes (`Usuario.fusoHorario` e `Instituicao.configuracoes`) | Definir a fonte de verdade | #117 | 20/11/2026 |
| L-18 | Classe | Classe `Papel` citada no briefing e ausente do modelo de classes | Decidir se `Papel` vira classe ou se fica como enum de `UsuarioPapel` | #118 | 20/11/2026 |
| L-19 | Sequência | 9 UC sem diagrama e 2 parciais; README diz que cobrem os cenários principais | Ajustar o README e priorizar diagramas de UC-02, 03, 05, 06, 12 a 15 | #119 | 20/11/2026 |
| L-20 | Estado | CANCELADO em `SenhaFlowStatus` sem método que o grave | Implementar o cancelamento ou remover o estado do diagrama e do enum | #120 | 20/11/2026 |
| L-21 | Regra | "Abandono" e "prioritárias" sem definição (ADI-01, ADP-01, OPE-01) | Definir as fórmulas no glossário | #121 | 20/11/2026 |
| L-22 | Regra | Regras de tela sem origem no código: convite por e-mail, bloqueio de login, limite de 500 caracteres | Confirmar com a equipe se viram requisito ou saem da tela | #122 | 20/11/2026 |

## 4. Itens aceitos, sem issue

- `GET /examples`: exemplo fora do escopo.
- `GET /`, `GET /docs`, `GET /docs.json`: infraestrutura.
- Tabelas `sessions`, `accounts` e `verifications`, e a senha em `Account.password`: BetterAuth, fora do domínio.
- Flags booleanas (`ativo`, `ativa`): tratadas como flag, não como máquina de estados.
- Testes de suporte sem RF próprio (listados em 1.2).

## Veja também

- [Matriz de rastreabilidade](matriz.md)
- [Malha de rastreabilidade (diagrama)](malha-rastreabilidade.svg)
- [Requisitos funcionais](../03-requisitos/requisitos-funcionais.md)
- [Histórias de usuário](../03-requisitos/historias-de-usuario.md)
- [Casos de uso](../05-modelagem/casos-de-uso/README.md)
- [Sequência](../05-modelagem/sequencia/README.md)
- [Classes](../05-modelagem/classes/README.md)
- [OCL](../05-modelagem/ocl/README.md)
