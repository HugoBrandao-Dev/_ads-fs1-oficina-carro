# ADR 0004: GraphQL ao lado do REST

Contexto de ensino: Engenharia de Software (Fábrica de Software I), arquitetura de APIs.

| Campo | Valor |
|---|---|
| Status | Aceita |
| Data da decisão | 2026-09-30 (commit de adição do GraphQL, com login/logout e plugin bearer no mesmo dia) |
| Data do registro | 2026-11-06 |
| Decisor | Gilberto, mantenedor do repositório |

## Contexto

Clientes web e mobile montam telas que, no REST, exigem várias chamadas: usuário, instituição e papéis; fila, mesas e contagem. O cliente precisa pedir só os campos de que necessita, numa requisição. O projeto também é material de aula: expor as duas abordagens sobre a mesma base de services é um objetivo declarado (`documentacao/10-graphql.md`).

## Decisão

Adicionar `POST /graphql` com Apollo Server 5 e `@as-integrations/express5`, sem substituir o REST. Regras adotadas:

- Resolvers chamam os services, nunca o Prisma.
- O contexto (`buildContext`) resolve a sessão com o mesmo `auth.api.getSession()` do REST e entrega `usuario` no mesmo formato de `req.user`.
- Guardas: `exigirAutenticado`, `exigirPapel`, `exigirInstituicao`, espelhadas do REST.
- Mesmos schemas Zod do REST para validação, como em `fila.resolvers.js`.
- Enums do schema espelham os enums do Prisma.
- Introspecção ligada em todos os ambientes, porque o schema é a documentação.
- Erros mapeados para `extensions.code` em `src/graphql/erros.js`.

## Alternativas consideradas

| Alternativa | Situação |
|---|---|
| Manter só REST | Descartada pelo objetivo didático e pelo caso de telas que pedem muitas chamadas. |
| Substituir o REST pelo GraphQL | Descartada: os clientes existentes continuam em REST. |
| GraphQL ao lado do REST | Adotada. |

## Consequências

Positivas:

- Uma única regra de negócio atende as duas superfícies, pelos mesmos services.
- Os testes do contrato ficam em `src/tests/graphql/graphql.spec.js`, contra PostgreSQL real.

Negativas e pendências:

- Guardas duplicadas entre REST e GraphQL (ver [ADR 0003](0003-arquitetura-em-camadas-com-di-manual.md)).
- DataLoader não implementado. O resolver de usuário cita o material do Tópico 4 mas não o usa, então há risco de N+1 em listagens aninhadas.
- Sem diretiva `@auth` e sem subscriptions. Tempo real fica no Socket.IO.
- Introspecção ligada em produção. Documentada em `documentacao/10-graphql.md` como decisão de aula; antes de uso real precisa ser revista.

## Evidências no código

- `src/graphql/server.js` (`introspection: true`), `context.js`, `erros.js`, `typeDefs/`, `resolvers/`.
- `src/tests/graphql/graphql.spec.js`.
- Commits `8676b5a` (GraphQL e Apollo 5), `b2524d9` (bearer), `e70022b` (login e logout).
- `documentacao/10-graphql.md`.

## Veja também

- [ADR 0002: BetterAuth com sessão no lugar de JWT duplo](0002-betterauth-sessao-no-lugar-de-jwt.md)
- [ADR 0003: Arquitetura em camadas com DI manual](0003-arquitetura-em-camadas-com-di-manual.md)
- [Casos de uso](../05-modelagem/casos-de-uso/casos-de-uso.svg)
- [Índice de ADRs](README.md)
