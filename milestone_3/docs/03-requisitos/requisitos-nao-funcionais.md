# Requisitos não funcionais

Milestone 1 (requisitos) · Unidade de requisitos da disciplina Engenharia de Software (Fábrica de Software I) · FilaCidadã API

Este documento lista os requisitos não funcionais (RNF) da API FilaCidadã, derivados do código e da configuração do repositório. Cada RNF traz tipo, métrica verificável e evidência com caminho relativo à raiz do projeto. Os requisitos funcionais que cada RNF afeta estão em [requisitos-funcionais.md](requisitos-funcionais.md); as histórias, em [historias-de-usuario.md](historias-de-usuario.md).

## Como ler

Tipos usados: produto, desempenho, segurança, usabilidade, disponibilidade, organizacional e externo.

Estados:

| Estado | Significado |
|---|---|
| Atendido | O código implementa o requisito e há evidência no repositório |
| Parcial | Implementado em parte, ou sem verificação automatizada |
| Lacuna | Não implementado, ou desativado no código |
| Não medido | Meta proposta; o repositório não traz medição que a comprove |

Metas marcadas como "proposta" são sugestões do grupo de requisitos. O código ainda não as comprova.

## Resumo

| Tipo | Total | Atendido | Parcial | Lacuna | Não medido |
|---|---:|---:|---:|---:|---:|
| Produto | 5 | 3 | 2 | 0 | 0 |
| Desempenho | 4 | 2 | 1 | 0 | 1 |
| Segurança | 10 | 5 | 3 | 2 | 0 |
| Usabilidade | 3 | 1 | 1 | 0 | 1 |
| Disponibilidade | 5 | 1 | 1 | 2 | 1 |
| Organizacional | 2 | 0 | 2 | 0 | 0 |
| Externo | 3 | 2 | 0 | 1 | 0 |
| **Total** | **32** | **14** | **10** | **5** | **3** |

## Produto

Qualidade interna do software: integridade, testabilidade, manutenibilidade e implantação.

| ID | Requisito | Métrica verificável | Evidência no repositório | Estado |
|---|---|---|---|---|
| RNF-001 | Integridade dos dados garantida pelo SGBD | Toda regra de integridade (chave estrangeira, enum, unicidade, `onDelete`) é coberta por teste contra PostgreSQL real; `npm test` sem falhas | `prisma/schema.prisma` (`onDelete`, `@@unique`, enums); `src/tests/unit/schema/restricoes.test.js`; `documentacao/14-testes.md` | Atendido |
| RNF-002 | Testes automatizados em banco real | 0 falhas em `npm test`; execução disparada a cada merge request | `package.json` (script `test`); 31 arquivos em `src/tests/`; `jest.setup.js` (TRUNCATE por suíte). Sem `coverageThreshold` em `jest.config.mjs`. `.gitlab-ci.yml` não executa `npm test` | Parcial |
| RNF-003 | Código padronizado por lint | `npx eslint .` com 0 erros; execução no pipeline | `eslint.config.js` (ESLint 9); `documentacao/14-testes.md`. O pipeline não roda o lint | Parcial |
| RNF-004 | Implantação reprodutível em contêiner | Imagem constrói com `npm ci` e versão de Node fixa; processo roda com usuário não root | `Dockerfile` (`node:22.20-alpine`, `USER node`); `docker-compose.yml` (`api-filas`) | Atendido |
| RNF-005 | Falha cedo na configuração insegura | A aplicação não sobe sem `BETTER_AUTH_SECRET`; o Compose aborta sem a variável | `src/config/auth.js` (lança erro se o segredo faltar); `docker-compose.yml` (`BETTER_AUTH_SECRET: "${...:?...}"`) | Atendido |

## Desempenho

Tempo de resposta, volume e uso de recursos.

| ID | Requisito | Métrica verificável | Evidência no repositório | Estado |
|---|---|---|---|---|
| RNF-006 | Tempo de resposta das operações de fila | Proposta: p95 de até 300 ms em `GET /filas` e `GET /senhas/meu-atendimento` com 50 usuários simultâneos, em ambiente de teste com o mesmo volume de dados do seed | Índice `@@index([filaId, status, prioridadePeso, posicao])` em `prisma/schema.prisma`. Não há medição no repositório | Não medido |
| RNF-007 | Limite de tamanho de página | Todo parâmetro `limit` aceita de 1 a 100; valor fora da faixa responde 400 | Validadores em `src/utils/validators/schemas/zod/querys/*.js` (ex.: `FilaQuerySchema.js`, `AuditoriaQuerySchema.js`) | Atendido |
| RNF-008 | Respostas comprimidas | Respostas HTTP de texto acima do limite do middleware chegam com `Content-Encoding: gzip` quando o cliente aceita | `src/app.js` (`app.use(compression())`) | Atendido |
| RNF-009 | Atualização em tempo real para painéis e cidadão | Proposta: evento emitido após uma operação chega ao cliente conectado em até 2 s, medido em teste de integração | `src/config/socket.js` (autenticação do handshake por cookie); `src/services/EventBusService.js`; `src/tests/integracao/socket/SocketAuth.test.js`. Não há teste de latência. Clientes sem cookie não conectam ao Socket.IO | Parcial |

## Segurança

Autenticação, autorização, proteção de dados e superfície de ataque.

| ID | Requisito | Métrica verificável | Evidência no repositório | Estado |
|---|---|---|---|---|
| RNF-010 | Sessão autenticada com expiração e revogação | Sessão expira em 7 dias; é renovada no uso após 1 dia; logout remove a sessão do banco; cookie com `Secure` em produção | `src/config/auth.js` (`session.expiresIn` = 7 dias, `updateAge` = 1 dia, `advanced.useSecureCookies`); sessões na tabela `Session` (`prisma/schema.prisma`) | Atendido |
| RNF-011 | Senha forte no mínimo aceito | Cadastro com senha de menos de 8 caracteres responde erro; senha não aparece em nenhuma resposta da API | `src/config/auth.js` (`minPasswordLength: 8`); `src/controllers/UsuarioController.js` (comentário sobre remoção de `senhaHash`). Não há regra de complexidade | Parcial |
| RNF-012 | Autorização por papel em cada rota protegida | Toda rota de escrita declara `AuthMiddleware` e `authorize(...)` com os papéis permitidos; requisição de papel não permitido responde 403 | `src/middlewares/AuthMiddleware.js`; `src/middlewares/authorize.js`; `src/constants/roles.js`; exemplo em `src/routes/filaRoutes.js` | Atendido |
| RNF-013 | Limite de tentativas de login por IP | Proposta: após 10 tentativas em 15 min para o mesmo IP, a resposta é 429 em `/api/auth/sign-in/email` | `src/routes/authRoutes.js` (comentário afirma que o BetterAuth limita por padrão em produção). `src/config/auth.js` não define `rateLimit`. `express-rate-limit` está em `package.json` e não é usado em `src/` | Parcial |
| RNF-014 | Cabeçalhos de segurança HTTP | Respostas trazem `Content-Security-Policy`, `X-Content-Type-Options` e `Strict-Transport-Security`, verificável com `curl -I` | `src/app.js` (bloco do `helmet` comentado, linhas 78 a 95). Único cabeçalho ativo: `X-Robots-Tag` | Lacuna |
| RNF-015 | CORS restrito às origens confiáveis | Origem fora de `CORS_ORIGINS` não recebe `Access-Control-Allow-Origin`, verificável com requisição de origem de teste | `src/app.js` (`origin: true` com `credentials: true`, linhas 34 a 38). `CORS_ORIGINS` alimenta só `trustedOrigins` em `src/config/auth.js` | Lacuna |
| RNF-016 | Segredos fora do repositório e da imagem | `.env` ignorado pelo Git e pelo Docker; pipeline com detecção de segredos ativa | `.gitignore` (`.env`); `.dockerignore`; `.gitlab-ci.yml` (template Secret-Detection) | Atendido |
| RNF-017 | Erro sem detalhe interno em produção | Com `NODE_ENV=production`, resposta 500 não contém `stack`; o `errorId` aparece na resposta e no log | `src/utils/helpers/errorHandler.js` (`isProduction`, `errorId`); `docker-compose.yml` (`NODE_ENV` padrão `production`) | Atendido |
| RNF-018 | Trilha de auditoria das ações de negócio | 100% das operações de escrita de Fila, Instituição, Usuário e Senha geram registro em `Auditoria`; login e logout também geram registro | `src/services/SenhaService.js`, `UsuarioService.js`, `InstituicaoService.js`, `FilaService.js` (chamadas a `auditoriaService.registrar`). `AUDITORIA_ACOES.LOGIN` está definido em `src/constants/auditoria.js`, sem uso. Login e logout não são auditados | Parcial |
| RNF-019 | Conteúdo fora dos buscadores | Toda resposta da API traz `X-Robots-Tag: noindex, nofollow, noarchive, nosnippet`; `/robots.txt` responde `Disallow: /` | `src/app.js` (linhas 63 a 74) | Atendido |

## Usabilidade

Facilidade de aprendizado, uso e integração.

| ID | Requisito | Métrica verificável | Evidência no repositório | Estado |
|---|---|---|---|---|
| RNF-020 | Documentação interativa da API | `/docs` abre a interface Swagger; `/docs.json` lista 100% das rotas REST publicadas | `src/routes/index.js` (`/docs`, `/docs.json`); especificações em `src/docs/paths/*.js`. A cobertura entre rotas e especificações não é verificada | Parcial |
| RNF-021 | Mensagens em português e erro em formato único | Toda resposta de erro segue o envelope `CommonResponse`; textos de erro em português | `src/utils/helpers/CommonResponse.js`; `src/utils/helpers/messages.js`; `documentacao/09-erros.md`; `lang="pt-BR"` na página de documentação | Atendido |
| RNF-022 | Tempo para o cidadão emitir uma senha | Proposta: até 30 s do toque em "Emitir senha" até a confirmação, em teste com 5 cidadãos de primeira viagem | Fluxo de emissão em `src/routes/senhaRoutes.js` e `src/routes/publicoRoutes.js`. Não há teste de usabilidade no repositório | Não medido |

## Disponibilidade

Continuidade do serviço, recuperação de falhas e observação em operação.

| ID | Requisito | Métrica verificável | Evidência no repositório | Estado |
|---|---|---|---|---|
| RNF-023 | Disponibilidade do serviço em horário de atendimento | Proposta: 99% de disponibilidade mensal, medida por monitor externo na rota `/`. O contêiner reinicia sozinho | `docker-compose.yml` (`restart: always` em `api-filas` e `postgres`). Meta e monitor não definidos | Não medido |
| RNF-024 | Verificação de saúde da aplicação | `GET /health` responde 200 com status do banco; 503 quando o banco cai | Não há rota de saúde em `src/routes/index.js` nem healthcheck do serviço `api-filas` em `docker-compose.yml`. O healthcheck só existe para `postgres` | Lacuna |
| RNF-025 | Continuidade quando uma dependência externa falha | Falha do armazenamento de arquivos não derruba o download; falha do NPaaS não interrompe a operação de negócio | `src/app.js` (rota `/uploads/:nome` cai para disco local); `src/infra/NpaasClient.js` (não lança exceção, devolve `null`); `src/tests/unit/infra/NpaasClient.test.js` | Atendido |
| RNF-026 | Observabilidade em operação | Logs com rotação de 30 dias e limite de 50 GB; traces e métricas exportados ao Jaeger/Prometheus | `src/utils/logger.js` (`maxFiles: '30d'`, `LOG_MAX_SIZE_GB` padrão 50). Telemetria desligada: `server.js` (`import './otel.js'` comentado). `prometheus.yml` e `jaeger-spm-config.yaml` sem uso ativo | Parcial |
| RNF-027 | Backup e restauração do banco | Backup diário do PostgreSQL com retenção de 7 dias e restauração testada; RPO de 24 h e RTO de 2 h (propostos) | Não há rotina de backup no repositório. O volume `postgres-data` em `docker-compose.yml` é o único armazenamento | Lacuna |

## Organizacional

Processo de entrega, governança e registro das decisões.

| ID | Requisito | Métrica verificável | Evidência no repositório | Estado |
|---|---|---|---|---|
| RNF-028 | Pipeline com portões de qualidade antes do merge | O pipeline falha quando teste, lint, análise estática ou detecção de segredos falham | `.gitlab-ci.yml` (jobs `sast` e `secret_detection`). Não há jobs de teste nem de lint | Parcial |
| RNF-029 | Documentação do projeto versionada no repositório | Cada mudança de endpoint atualiza `documentacao/07-endpoints.md` e a coleção Postman no mesmo commit | `documentacao/` (15 arquivos, servidos em `/documentacao`); `documentacao/FilaCidada-API.postman_collection.json`; `documentacao/12-historico.md` registra decisões | Parcial |

## Externo

Exigências de lei, de clientes e de ambiente de uso.

| ID | Requisito | Métrica verificável | Evidência no repositório | Estado |
|---|---|---|---|---|
| RNF-030 | Tratamento de dados pessoais conforme a LGPD | Inventário de dados pessoais publicado; pedido de eliminação atendido em prazo definido pelo controlador (proposta: 15 dias); política de retenção de `Auditoria` e de logs | `Usuario` guarda nome, e-mail e CPF (`src/utils/validators/schemas/zod/UsuarioSchema.js`). Exclusão física existe (`UsuarioService.deletar`, com `ON DELETE CASCADE` das sessões). Não há exportação, registro de consentimento nem política de retenção | Lacuna |
| RNF-031 | Acesso por clientes web, móvel e GraphQL | Cliente sem cookie autentica por `Authorization: Bearer` em REST e GraphQL; origens permitidas listadas em `CORS_ORIGINS` | `src/config/auth.js` (plugin `bearer()`); `src/graphql/context.js`; `src/app.js` (cabeçalhos permitidos) | Atendido |
| RNF-032 | Horário de atendimento no fuso do usuário | Indicadores do dashboard seguem o `fusoHorario` do usuário, com fallback `America/Manaus` | `src/config/auth.js` (campo `fusoHorario`); `src/middlewares/AuthMiddleware.js`; `docker-compose.yml` (`TZ: America/Manaus`) | Atendido |

## Divergências

Diferenças encontradas entre o catálogo de casos de uso (UC-01 a UC-15), o briefing de requisitos e o código. A ordem segue a importância para o backlog.

1. **Escopo sem UC próprio.** Flow (`src/routes/flowRoutes.js`), Chat (`src/routes/chatRoutes.js`) e LandingPage (`src/routes/landingPageRoutes.js`) têm rotas e tabelas no schema. Os RF correspondentes estão sob UC-06, UC-10, UC-11 e UC-15, mas nenhum desses itens tem UC próprio (divergência 5 em [requisitos-funcionais.md](requisitos-funcionais.md)). Os RNF deste documento valem para eles. O escopo deve ser decidido pela equipe.
2. **Helmet desativado.** O bloco de `helmet` está comentado em `src/app.js`, e `documentacao/12-historico.md` o registra como pendência. Isto contraria RNF-014 e o checklist de `documentacao/15-deploy.md`.
3. **CORS mais aberto que a configuração.** `src/app.js` reflete qualquer origem com `credentials: true`. `CORS_ORIGINS` só alimenta `trustedOrigins` do BetterAuth. O checklist de deploy pressupõe que `CORS_ORIGINS` limite as origens.
4. **Limite de tentativas sem configuração própria.** `src/routes/authRoutes.js` atribui o limite ao BetterAuth por padrão. `express-rate-limit` está instalado e não é usado. Não há teste que comprove o limite.
5. **Login e logout não auditados.** `AUDITORIA_ACOES.LOGIN` existe e não é usado. O catálogo UC-14 pressupõe trilha de auditoria completa.
6. **Telemetria declarada e desligada.** `docker-compose.yml` define variáveis `OTEL_*`, e `prometheus.yml` e `jaeger-spm-config.yaml` existem. `server.js` não importa `./otel.js`.
7. **Pipeline sem testes.** `documentacao/14-testes.md` descreve `npm test` como rotina, mas `.gitlab-ci.yml` só executa SAST e detecção de segredos.
8. **Sem rota de saúde.** Não há `GET /health`; o único healthcheck é o do PostgreSQL.
9. **Expiração lógica.** `documentacao/15-deploy.md` pede rotina para sessões e QR Codes vencidos. Não há código que remova registros vencidos.
10. **Rotas de autenticação.** O catálogo UC-01 cita "cadastro, login, logout". No código, esses fluxos estão em `/api/auth/*` (BetterAuth). `src/routes/authRoutes.js` mantém só `GET /auth/me`. Esta documentação usa os endpoints do BetterAuth.
11. **Socket.IO só com cookie.** `src/config/socket.js` autentica pelo cabeçalho `cookie`. Clientes que se autenticam só por Bearer (por exemplo, apps nativos) não recebem eventos em tempo real.

## Veja também

- [Requisitos funcionais](requisitos-funcionais.md)
- [Histórias de usuário](historias-de-usuario.md)
- [Backlog priorizado](backlog.md)
- [Rastreabilidade de requisitos](rastreabilidade-requisitos.svg)
- [Casos de uso](../05-modelagem/casos-de-uso/README.md)
- [Modelo de classes](../05-modelagem/classes/README.md)
- [Modelo de dados](../06-banco-de-dados/README.md)
- [Monitorias de qualidade](../08-qualidade/monitorias.md)
- [Milestone 1](../09-entregas/milestone-1.md)
- [Template de requisito](../templates/requisito.md)
