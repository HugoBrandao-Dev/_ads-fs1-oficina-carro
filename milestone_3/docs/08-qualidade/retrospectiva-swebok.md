# Retrospectiva por área do SWEBOK

Contexto de ensino: Engenharia de Software (Fábrica de Software I), milestone 3. Cada artefato do projeto é associado a uma área de conhecimento do SWEBOK v4 e avaliado pelo que foi feito, pelo que faltou e pela issue que trata a falta.

Como ler a tabela: "Feito" cita evidência no repositório (arquivo, commit ou medição). "Faltou" é lacuna verificada, não opinião. A coluna "Issue" traz o título sugerido para abrir no GitLab. Os arquivos lidos não têm lista de issues, então o número ainda não existe e deve ser preenchido ao abrir.

## Artefatos

| # | Artefato | Área SWEBOK v4 | Feito | Faltou | Issue |
|---|---|---|---|---|---|
| 1 | Modelo de dados relacional (`prisma/schema.prisma`) | Projeto de software | 20 modelos e 9 enums. FKs com política explícita (`Cascade`, `SetNull`, `Restrict`) e unicidade composta, como `tipos_etapa` por instituição. | O dicionário de dados e o modelo lógico precisam ser conferidos contra o schema. O documento de histórico diz 21 tabelas; o schema tem 20. | A abrir: "Sincronizar dicionário de dados com o schema.prisma" |
| 2 | Migração de MongoDB para PostgreSQL (`documentacao/11-migracao.md`) | Manutenção de software | Cinco etapas e troca de SGBD. Defeitos antigos corrigidos na tradução: filtro de período da auditoria, filtros por campos inexistentes e numeração de senha sem transação. | O motivo da troca de MySQL para PostgreSQL não está registrado (ver ADR 0001). | A abrir: "Registrar motivo da troca de MySQL para PostgreSQL" |
| 3 | Autenticação por sessão (`src/config/auth.js`, ADR 0002) | Qualidade de software (segurança) | Sessão em tabela com revogação imediata. Hash de senha fora da tabela de usuários. Cookie seguro em produção. | Linhas de sessão vencidas não são removidas. Não há teste automatizado da expiração. | A abrir: "Rotina de expurgo de sessões vencidas" |
| 4 | Arquitetura em camadas e containers (ADR 0003) | Arquitetura de software | Controllers sem referência ao Mongoose. A troca de repositório não tocou em rota nem em controller. | As guardas de autorização existem em dois lugares (`authorize` no REST e `exigirPapel` no GraphQL). | A abrir: "Unificar guardas de autorização entre REST e GraphQL" |
| 5 | API GraphQL (`src/graphql/`, ADR 0004) | Construção de software | Apollo Server 5, guardas, erros com `extensions.code` e testes do contrato em `src/tests/graphql/`. | Sem DataLoader, o que abre risco de consultas repetidas em listagens aninhadas. Sem subscriptions. Introspecção ligada em produção. | A abrir: "Implementar DataLoader nas listagens aninhadas" e "Revisar introspecção do GraphQL em produção" |
| 6 | Testes com PostgreSQL real (`src/tests/`, `documentacao/14-testes.md`) | Teste de software | 23 de 23 suítes e 329 testes registrados. Limpeza do banco por `TRUNCATE` antes de cada suíte. | Nenhum job do CI roda testes. Não há limite de cobertura. | A abrir: "Job de testes no GitLab CI com PostgreSQL 17" |
| 7 | Observabilidade (ADR 0005) | Operação de software | Logs com winston, rotação diária e `errorId` em toda resposta 500. | Telemetria OpenTelemetry desativada. `otel.js` não existe. Jaeger e Prometheus não estão no Compose. Não há `/metrics`. | A abrir: "Implementar ou remover a configuração OpenTelemetry" |
| 8 | Configuração e segredos (`Dockerfile`, `docker-compose.yml`) | Gestão de configuração de software | Node fixado em 22.20. `.env` fora da imagem (`.dockerignore`). `BETTER_AUTH_SECRET` obrigatório: sem ele o `up` aborta. | Credencial padrão de seed documentada no deploy. Variável `DB_URL` do Mongo ainda sem rotação. | A abrir: "Rotacionar e remover DB_URL e variáveis JWT_*" |
| 9 | Documentação do sistema (`documentacao/`, `README.md`) | Processo de engenharia de software | 15 capítulos e leitor. O histórico registra as decisões e onde os HTMLs antigos divergem do código. | Os HTMLs de `documentacao/legado-html/` ainda contradizem o código em 11 pontos (ver `documentacao/12-historico.md`). | A abrir: "Marcar legado-html como histórico" |
| 10 | Segurança de borda (`src/app.js`) | Qualidade de software (segurança) | CORS por lista em `CORS_ORIGINS`. Handler do BetterAuth antes do `express.json()`. `X-Robots-Tag: noindex`. | Helmet comentado, sem CSP e sem HSTS. O CSP padrão do Helmet 8 bloqueava o Swagger UI. | A abrir: "Reativar Helmet com CSP compatível com o Swagger UI" |

## Resumo por área

| Área SWEBOK v4 | Artefatos | Situação |
|---|---|---|
| Projeto de software | 1 | Sólido na integridade do banco; falta conferir a documentação. |
| Manutenção | 2 | Migração completa, com linha de base medida. |
| Qualidade de software | 3, 10 | Segurança com lacunas conhecidas: expurgo de sessões e Helmet. |
| Arquitetura | 4 | Camadas claras; duplicação de guardas. |
| Construção | 5 | Funcional; faltam DataLoader e revisão de introspecção. |
| Teste | 6 | Teste real, mas fora do CI. |
| Operação | 7 | Logs ativos; telemetria inexistente na prática. |
| Gestão de configuração | 8 | Boas práticas de imagem; credenciais legadas pendentes. |
| Processo | 9 | Documentação extensa; legado contraditório. |

## Veja também

- [Monitorias de qualidade](monitorias.md)
- [Retrospectiva final](retrospectiva-final.md)
- [Índice de ADRs](../adr/README.md)
- [Migração (documentação)](../../documentacao/11-migracao.md)
- [Milestone 3](../09-entregas/milestone-3.md)
