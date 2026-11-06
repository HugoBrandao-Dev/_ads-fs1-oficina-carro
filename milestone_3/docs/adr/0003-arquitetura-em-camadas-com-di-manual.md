# ADR 0003: Arquitetura em camadas com injeção de dependência manual

Contexto de ensino: Engenharia de Software (Fábrica de Software I), arquitetura de software.

| Campo | Valor |
|---|---|
| Status | Aceita |
| Data da decisão | Anterior à migração (2026/1); reforçada na migração para Prisma e BetterAuth (2026/2) |
| Data do registro | 2026-11-06 |
| Decisor | Gilberto, mantenedor do repositório |

## Contexto

A API precisa de regras de negócio (filas, senhas, papéis, auditoria, eventos) expostas por REST e, desde 2026/2, por GraphQL. Também precisa trocar infraestrutura (Mongoose por Prisma, JWT por sessão) sem reescrever a aplicação. Os testes de unidade precisam substituir integrações externas (BetterAuth, e-mail, storage) por dublês.

## Decisão

Separar o código em camadas, cada uma com uma responsabilidade:

| Camada | Pasta | Regra |
|---|---|---|
| Rotas | `src/routes/` | Só caminho, verbo e cadeia de middlewares. |
| Middlewares | `src/middlewares/` | Autenticação (`AuthMiddleware`) separada de autorização (`authorize`, `ensureInstituicao`). |
| Controllers | `src/controllers/` | Traduzem a requisição em chamada de service. Sem `try/catch`, por causa do `asyncWrapper`. Importam services só de `containers/services.index.js`. |
| Services | `src/services/` | Regras de negócio. Recebem dependências pelo construtor. |
| Repositories | `src/repositories/` | Único lugar que usa Prisma, além de `config/prisma.js`. |
| Containers | `src/containers/` | Único lugar que faz `new`. Montam repositórios, services e infraestrutura. |
| Infra | `src/infra/` | Adaptadores de sistemas externos, trocáveis por dublês. |

## Alternativas consideradas

| Alternativa | Situação |
|---|---|
| Controllers chamando o ORM diretamente | Rejeitada: a troca de ORM atingiria rotas e controllers. |
| Container de DI por biblioteca | Não avaliada nos documentos lidos. A instanciação manual foi mantida. |
| Camadas com containers manuais (decisão) | Adotada. |

## Consequências

Positivas:

- A troca de Mongoose por Prisma atingiu só `repositories/` e `filters/`. Os controllers tinham zero referências ao Mongoose. Ver [Migração, etapa 3](../../documentacao/11-migracao.md).
- Services são testados com dublês, como o `ContasBetterAuth` falso em `src/tests/unit/`.
- A regra de negócio fica num lugar, e o REST e o GraphQL a consomem da mesma forma (ver [ADR 0004](0004-graphql-ao-lado-do-rest.md)).

Negativas:

- Os containers são uma lista manual. Uma dependência esquecida só aparece em tempo de execução ou nos testes.
- As guardas de autorização existem duas vezes: `authorize()` no REST e `exigirPapel()` no GraphQL. Mudança de regra precisa ser feita nos dois lugares.
- A camada de serviço cresce com o número de domínios. Hoje há services de fila, senha, flow, chat, notificação, auditoria e dashboard.

## Evidências no código

- `documentacao/04-arquitetura.md`: tabela de camadas e o caminho de uma requisição.
- `src/containers/`: montagem manual das dependências.
- `src/controllers/` e `src/services/`: construtores com dependências injetadas.
- `src/graphql/context.js`: guardas do GraphQL.
- `documentacao/diagramas/camadas.svg`.

## Veja também

- [ADR 0001: PostgreSQL com Prisma no lugar do MongoDB](0001-postgresql-prisma-no-lugar-do-mongodb.md)
- [ADR 0004: GraphQL ao lado do REST](0004-graphql-ao-lado-do-rest.md)
- [Diagrama de classes](../05-modelagem/classes/classes.svg)
- [Índice de ADRs](README.md)
