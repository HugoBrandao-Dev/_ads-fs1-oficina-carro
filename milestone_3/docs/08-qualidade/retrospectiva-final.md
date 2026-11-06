# Retrospectiva final: manter, mudar e parar

Contexto de ensino: Engenharia de Software (Fábrica de Software I), fechamento do projeto FilaCidadã. Cada item tem uma ação verificável e um responsável. O responsável indicado é o mantenedor do repositório, Gilberto; a equipe deve confirmar ou redistribuir.

## Manter

| Prática | Evidência | Ação | Responsável |
|---|---|---|---|
| Banco real nos testes, sem simulador | `documentacao/14-testes.md`; ADR 0001 | Manter como regra: integridade é testada contra o SGBD, não contra mock | Gilberto |
| Camadas com containers para trocar infraestrutura | Troca de Mongoose por Prisma sem mudança em controller (ADR 0003) | Ao trocar uma infraestrutura, registrar um ADR novo antes da mudança | Gilberto |
| Linha de base medida antes de mudar | Suíte antiga reexecutada antes da migração (139 testes para 329) | Anotar a medição de referência antes de cada refatoração grande | Gilberto |
| Fonte da verdade no código | Documentação legada corrigida pelo código (`12-historico.md`) | Manter a seção "Divergências" em cada documento novo | Gilberto |

## Mudar

| Prática atual | Problema | Ação | Responsável |
|---|---|---|---|
| CI sem testes | `.gitlab-ci.yml` tem só SAST e detecção de segredos | Acrescentar job com `postgres:17-alpine` e `npm test`, com `BETTER_AUTH_SECRET` em variável protegida | Gilberto |
| Observabilidade configurada mas inativa | `server.js` com import comentado; `otel.js` inexistente; Jaeger e Prometheus fora do Compose (ADR 0005) | Implementar a cadeia ou remover arquivos e variáveis OTEL; escolher uma das duas até a próxima entrega | Gilberto |
| Helmet desligado | `src/app.js` com Helmet comentado, sem CSP | Reativar com CSP que aceite o Swagger UI | Gilberto |
| Lint com 735 erros | Concentrados em `documentacao/conteudo.js`, `documentacao/vendor/marked.min.js` e `eslint.config.js` (ver [Monitorias](monitorias.md)) | Excluir o diretório `vendor` da análise e corrigir `eslint.config.js` | Gilberto |
| Documentação legada contraditória | Onze pontos em `legado-html/` (ver `12-historico.md`); 21 tabelas no histórico contra 20 no schema | Marcar `legado-html/` como histórico e corrigir a contagem | Gilberto |

## Parar

| Prática | Por que parar | Ação no lugar | Responsável |
|---|---|---|---|
| Desativar código de segurança ou telemetria com comentário e sem registro | `import './otel.js'` e Helmet comentados há meses sem issue | Toda desativação temporária leva issue com data de reativação | Gilberto |
| Declarar uma entrega pronta sem conferir item a item | Checklists de milestone sem evidência dão falsa sensação de conclusão | Marcar cada item a partir de um comando ou arquivo verificado | Gilberto |
| Deixar credencial padrão de seed como parte do ambiente | `15-deploy.md` documenta o usuário administrador padrão do seed | Seed só em ambiente de aula, com instrução de troca de senha antes de qualquer uso fora dele | Gilberto |

## Veja também

- [Retrospectiva por área do SWEBOK](retrospectiva-swebok.md)
- [Monitorias de qualidade](monitorias.md)
- [Milestone 3](../09-entregas/milestone-3.md)
- [Índice de ADRs](../adr/README.md)
- [Deploy e CI (documentação)](../../documentacao/15-deploy.md)
