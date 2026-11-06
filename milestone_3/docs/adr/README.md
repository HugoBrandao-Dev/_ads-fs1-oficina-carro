# Registros de decisão de arquitetura (ADR)

Contexto de ensino: Engenharia de Software (Fábrica de Software I), arquitetura e modelagem.

Cada ADR registra uma decisão que muda a estrutura do sistema, o motivo, as alternativas e as consequências. Os cinco registros abaixo foram derivados do código e da documentação do projeto; a evidência de cada um está na seção "Evidências no código" do próprio ADR.

## Índice

| Nº | Título | Status | Data da decisão |
|---|---|---|---|
| [0001](0001-postgresql-prisma-no-lugar-do-mongodb.md) | PostgreSQL com Prisma no lugar do MongoDB | Aceita | 2026-07-29 e 2026-08-05 |
| [0002](0002-betterauth-sessao-no-lugar-de-jwt.md) | BetterAuth com sessão persistida no lugar de JWT duplo | Aceita | 2026-07-29 e 2026-09-30 |
| [0003](0003-arquitetura-em-camadas-com-di-manual.md) | Arquitetura em camadas com injeção de dependência manual | Aceita | Anterior a 2026/2 |
| [0004](0004-graphql-ao-lado-do-rest.md) | GraphQL ao lado do REST | Aceita | 2026-09-30 |
| [0005](0005-observabilidade-prometheus-jaeger.md) | Observabilidade com OpenTelemetry, Jaeger e Prometheus | Aceita, implementação pendente | Não registrada |

## Status possíveis

- Proposta: em discussão, sem implementação.
- Aceita: decisão vigente. Pode estar com implementação pendente, e a seção "Estado atual" diz o que falta.
- Substituída: mantém o registro e aponta o ADR que a substituiu.

## Como criar um ADR

Use o modelo em [docs/templates/adr.md](../templates/adr.md). O arquivo recebe o próximo número livre (`0006-...md`) e entra no índice acima na mesma alteração. Não se reescreve um ADR aceito: uma mudança de decisão gera um ADR novo que substitui o antigo.

## Divergências

Divergências entre a documentação antiga e o código, encontradas ao escrever estes ADRs:

| Onde | Documento diz | Código tem | Tratamento |
|---|---|---|---|
| Observabilidade | Telemetria e Jaeger citados como parte da arquitetura | Import de `otel.js` comentado, `otel.js` inexistente, sem serviços jaeger ou prometheus no Compose | Registrado como "implementação pendente" no ADR 0005 |
| Modelo de dados | `documentacao/12-historico.md` diz 21 tabelas | `prisma/schema.prisma` tem 20 modelos (tabelas) | Código seguido. O número deve ser corrigido no documento de histórico |
| Localização dos testes | `documentacao/14-testes.md` cita `tests/graphql/` | Arquivo está em `src/tests/graphql/graphql.spec.js` | Código seguido |

## Veja também

- [Modelo de dados](../06-banco-de-dados/README.md)
- [Arquitetura em camadas (documentação)](../../documentacao/04-arquitetura.md)
- [Migração MongoDB para PostgreSQL](../../documentacao/11-migracao.md)
- [Modelo de ADR](../templates/adr.md)
- [Retrospectiva final](../08-qualidade/retrospectiva-final.md)
