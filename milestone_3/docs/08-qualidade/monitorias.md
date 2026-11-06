# Monitorias de qualidade

Contexto de ensino: Engenharia de Software (Fábrica de Software I), área de qualidade de software (SWEBOK v4). Milestones 2 e 3.

Monitoria, neste projeto, é uma verificação periódica com resultado registrado: comando executado, data, resultado observado e ação decorrente. O registro é cumulativo. Uma linha nova por medição; linhas antigas não são reescritas.

## Quando monitorar

- Antes de cada entrega de milestone.
- Depois de qualquer mudança em `prisma/`, `src/config/auth.js` ou `src/graphql/`.
- Ao ativar ou desativar um mecanismo de segurança ou de observabilidade.

## Verificações e comandos

| Verificação | Comando ou fonte | Exige |
|---|---|---|
| Lint | `npx eslint .` | Node 22 e dependências |
| Testes | `npm test` | PostgreSQL de pé (`docker compose up -d postgres`) |
| Cobertura | `npm run test:coverage` | PostgreSQL de pé |
| Verificações de banco e auth | `npm run verificar:auth`, `node scripts/verificar-repositorios.mjs`, `node scripts/verificar-dashboard.mjs` | PostgreSQL de pé |
| Integração contínua | `.gitlab-ci.yml` | Pipeline do GitLab |

## Registro

| Data | Verificação | Resultado | Ação |
|---|---|---|---|
| 2026-11-06 | Lint (`npx eslint .`) | 735 erros, todos em 3 arquivos: `documentacao/conteudo.js` (quotes e semi), `documentacao/vendor/marked.min.js` e `eslint.config.js` (`window` não definido). Por regra: `quotes` 451, `semi` 211, `no-cond-assign` 25, `no-var` 24, `no-use-before-define` 17, `no-undef` 4, `no-control-regex` 2, `no-invalid-this` 1. Nenhum erro em `src/`. | Excluir `documentacao/vendor` da análise e corrigir `eslint.config.js`. Ver [Retrospectiva final](retrospectiva-final.md). |
| 2026-11-06 | Testes (`npm test`) | Não executada nesta monitoria, por exigir o banco de pé. Último resultado registrado: 23 de 23 suítes e 329 testes, cerca de 47 s, em [Migração, etapa 4](../../documentacao/11-migracao.md). Essa medição não tem data. | Rodar com o banco ativo antes da próxima entrega e registrar o resultado. |
| 2026-11-06 | Integração contínua (`.gitlab-ci.yml`) | Dois jobs: SAST e detecção de segredos. Nenhum job roda testes nem build de imagem. | Abrir issue para job de testes (ver [Retrospectiva SWEBOK](retrospectiva-swebok.md), linha 6). |
| 2026-11-06 | Cabeçalhos de segurança (`src/app.js`) | Helmet comentado, sem CSP e sem HSTS. `X-Robots-Tag: noindex` ativo. | Reativar o Helmet com CSP que aceite o Swagger UI. |
| 2026-11-06 | Limitação de taxa | `express-rate-limit` está no `package.json`, mas não é importado em `src/`. O comentário em `src/routes/authRoutes.js` cita o `rateLimit` do BetterAuth. Não há limite de taxa verificado nas rotas de login. | Confirmar a configuração do `rateLimit` do BetterAuth e testar o bloqueio por tentativas. |
| 2026-11-06 | Observabilidade | Telemetria OpenTelemetry desativada; `otel.js` inexistente; sem `/metrics`. | Ver [ADR 0005](../adr/0005-observabilidade-prometheus-jaeger.md). |

## Modelo de registro

Para cada nova medição, copie a linha abaixo e preencha. Não apague as anteriores.

| Data | Verificação | Resultado | Ação |
|---|---|---|---|
| AAAA-MM-DD | Comando executado | Número e local do problema, ou "sem ocorrências" | Issue, ADR ou "nenhuma" |

## Veja também

- [Retrospectiva SWEBOK](retrospectiva-swebok.md)
- [Retrospectiva final](retrospectiva-final.md)
- [Deploy e CI (documentação)](../../documentacao/15-deploy.md)
- [Testes (documentação)](../../documentacao/14-testes.md)
- [Milestone 3](../09-entregas/milestone-3.md)
