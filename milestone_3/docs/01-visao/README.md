# Visão do produto

Fábrica de Software I · Milestone 1 · visão, problema, objetivos e partes interessadas

Esta pasta parte da RFP fictícia do cliente e chega à visão do FilaCidadã. Ela define o problema, os objetivos, o escopo e quem participa. Não traz requisitos: esses saem da RFP e são detalhados em [03-requisitos](../03-requisitos/README.md).

## Problema

Quem precisa de atendimento em órgão público, hospital ou cartório enfrenta uma fila física. Não sabe quanto vai esperar, precisa ficar no balcão e, às vezes, perde a vez sem aviso. A instituição, por sua vez, não sabe quem foi atendido, por quem nem em quanto tempo, e controla a fila de improviso.

## Visão do produto

O FilaCidadã é uma plataforma multi-instituição para filas de atendimento. Cada instituição é isolada das outras e tem suas filas, mesas, operadores e QR Codes. O cidadão entra na fila pelo aplicativo ou pelo QR Code do balcão, acompanha a própria posição e é avisado quando for chamado. O operador chama, atende e finaliza. Os eventos chegam em tempo real aos clientes web e mobile.

## Objetivos

Os objetivos são qualitativos. As metas numéricas (tempo de espera, volume, prazo) ainda estão na lista de perguntas da [RFP](rfp.md), seção 12.

| Código | Objetivo | Casos de uso |
|---|---|---|
| OBJ-01 | Permitir emitir senha online e presencialmente | UC-08, UC-09 |
| OBJ-02 | Organizar o atendimento: chamar, rechamar, assumir e finalizar | UC-10, UC-11 |
| OBJ-03 | Permitir que cada instituição configure filas, mesas, etapas e QR Codes | UC-06, UC-07, UC-12 |
| OBJ-04 | Dar à instituição visão do atendimento e rastro das ações | UC-13, UC-14, UC-15 |
| OBJ-05 | Controlar acesso: cadastro, papéis e aprovação de instituições | UC-01 a UC-05 |
| OBJ-06 | Servir a mesma regra de negócio a web e mobile, por REST, GraphQL e tempo real | Transversal |

## Escopo

**Dentro do escopo:** o que está no catálogo de casos de uso (UC-01 a UC-15) e os objetivos acima.

**Fora do escopo:** pagamento de taxas, agendamento com data futura e integração com prontuário ou cadastro de outros órgãos. Nada disso existe no código hoje.

## Partes interessadas

| Quem | Código | Papel no sistema | Interesse principal |
|---|---|---|---|
| Cidadão | ACT-01 | `USUARIO_FINAL` | Retirar senha e acompanhar a posição sem ficar no balcão |
| Operador | ACT-02 | `OPERADOR` | Chamar e finalizar atendimentos com o mínimo de cliques |
| Administrador da instituição | ACT-03 | `ADMIN_INSTITUICAO` | Configurar a própria instituição e acompanhar o painel |
| Administrador da plataforma | ACT-04 | `ADMIN_PLATAFORMA` | Aprovar instituições e manter a plataforma isolada entre elas |
| Cliente patrocinador | | | Órgão fictício da RFP; define o que deve funcionar |
| Equipe de desenvolvimento | | | Produz os artefatos e o código |
| Professor avaliador | | | Valida os artefatos a cada milestone |
| Times de web e mobile | | | Consomem a API e precisam de contrato estável |

Os atores ACT-01 a ACT-04 e seus papéis conferem com `src/constants/roles.js`.

## Casos de uso do catálogo

| Código | Caso de uso | Ator principal |
|---|---|---|
| UC-01 | Autenticar-se (cadastro, login, logout) | Todos |
| UC-02 | Gerenciar perfil | Usuário logado |
| UC-03 | Solicitar cadastro de instituição | Qualquer usuário autenticado (ACT-01 na prática) |
| UC-04 | Avaliar solicitação de instituição (aprovar, rejeitar, reconsiderar) | ACT-04 |
| UC-05 | Gerenciar usuários e papéis | ACT-03, ACT-04 |
| UC-06 | Gerenciar filas | ACT-03, ACT-02 |
| UC-07 | Configurar tipos de etapa | ACT-03, ACT-04 |
| UC-08 | Emitir senha online | ACT-01 |
| UC-09 | Emitir senha presencial | ACT-02, ACT-03 |
| UC-10 | Chamar, rechamar e assumir senha | ACT-02, ACT-03 |
| UC-11 | Finalizar ou cancelar atendimento (finalizar: ACT-02, ACT-03; cancelar: também ACT-01 e ACT-04) | ACT-02, ACT-03 |
| UC-12 | Gerenciar QR Codes | ACT-02, ACT-03 |
| UC-13 | Consultar dashboard e estatísticas | ACT-02, ACT-03, ACT-04 |
| UC-14 | Consultar auditoria | ACT-03, ACT-04 |
| UC-15 | Acompanhar minha senha | ACT-01 |

Os atores de cada caso de uso seguem o que as rotas exigem em `src/routes/` e `src/services/`. Quando o catálogo e o código divergem, a seção [Divergências](#divergências) registra.

## Documentos desta pasta

- [PM Canvas](pm-canvas.md), com o desenho em grade em [pm-canvas.svg](pm-canvas.svg).
- [RFP fictícia do cliente](rfp.md), ponto de partida, sem requisitos prontos.
- [Glossário](glossario.md), termos do domínio em ordem alfabética.

## Divergências

Diferenças entre o catálogo da disciplina e o código. Vale o código; a frente responsável deve decidir o ajuste.

1. **Flows, chat, notificações e landing page sem caso de uso.** O código tem `/flows…`, `/senhas/:id/flow/*`, `/senhas/:id/chat`, `/notificacoes…` e `GET /landing-page`. O catálogo fixo (UC-01 a UC-15) não cobre nenhum deles. A frente de requisitos precisa decidir se entram em um UC existente ou em um novo ID.
2. **Classe `Usuario` do catálogo.** O model no Prisma se chama `User`, mapeado para a tabela `users`. A frente de classes deve escolher entre `Usuario` (nome do catálogo) e `User` (nome do schema). Esta pasta usa "Usuário" no glossário, com a referência ao model.
3. **Classe `Papel`.** No schema, `Papel` é um enum. A ligação usuário-papel é o model `UsuarioPapel`, tabela `usuario_papeis`. Não há classe `Papel` própria.
4. **Contexto da disciplina.** O enunciado fala em Fábrica de Software I. O `documentacao/README.md` do projeto diz que o sistema é o exemplo da disciplina de Web Services (CST em ADS, IFRO, 2026/2). Os dois podem coexistir, mas o cabeçalho dos documentos desta pasta usa o nome do enunciado.

## Veja também

- [PM Canvas](pm-canvas.md)
- [RFP fictícia do cliente](rfp.md)
- [Glossário](glossario.md)
- [Processo](../02-processo/README.md)
- [Requisitos](../03-requisitos/README.md)
- [Modelagem](../05-modelagem/README.md)
