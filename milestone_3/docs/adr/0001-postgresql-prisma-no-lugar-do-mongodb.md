# ADR 0001: PostgreSQL com Prisma no lugar do MongoDB

Contexto de ensino: Engenharia de Software (Fábrica de Software I), arquitetura e modelagem de dados.

| Campo | Valor |
|---|---|
| Status | Aceita |
| Data da decisão | 2026-07-29 (troca para MySQL 8 + Prisma); 2026-08-05 (troca para PostgreSQL 17, migration `init_uuid`) |
| Data do registro | 2026-11-06 |
| Decisor | Gilberto, mantenedor do repositório |

## Contexto

Na versão de 2026/1 a API usava MongoDB com Mongoose. O modelo era documental e o banco não impunha as regras do domínio:

- `instituicaoId` era só um campo; nada garantia que a instituição existia.
- Papéis eram um array de strings no usuário, sem integridade nem índice por papel.
- `mesas` e `tiposEtapa` eram subdocumentos. Têm identidade própria, mas não eram alvo de chave estrangeira.
- A numeração de senhas lia e gravava sem transação: duas senhas simultâneas podiam receber o mesmo número. O defeito já existia antes da migração e foi encontrado durante a tradução das consultas.

O sistema precisava de integridade referencial, unicidade composta (por exemplo, código de tipo de etapa por instituição) e um índice que sustentasse a fila por status e prioridade.

## Decisão

Usar PostgreSQL 17 com Prisma 6 como ORM. Regras adotadas:

- Chave primária `String @id @default(uuid()) @db.Uuid`, opaca, sem expor contagem.
- Enums do domínio viram enums do banco.
- Subdocumentos com identidade viram tabela (`mesas`, `tipos_etapa`, `usuario_papeis`).
- JSON só para configuração lida inteira (`configuracoes` da instituição, landing page).
- Política de exclusão explícita por relação: `Cascade`, `SetNull` ou `Restrict`. Por exemplo, `flow_steps.filaId` usa `Restrict`.
- Tabelas em `snake_case` no plural, via `@@map`.

## Alternativas consideradas

| Alternativa | Situação |
|---|---|
| Manter MongoDB + Mongoose | Rejeitada: o banco não garante FK, unicidade composta nem enum. |
| MySQL 8 + Prisma | Adotada na primeira etapa de migração e substituída em 2026-08-05. Os documentos lidos não registram o motivo da troca. |
| PostgreSQL 17 + Prisma | Adotada. |

## Consequências

Positivas:

- O SGBD rejeita papel fora do enum e FK inexistente. A verificação `npm run verificar:auth` testa isso.
- Os testes passam a rodar contra banco real, o que só faz sentido com um SGBD que impõe estrutura (ver [ADR 0003](0003-arquitetura-em-camadas-com-di-manual.md) e [Testes](../../documentacao/14-testes.md)).
- Filtro por campo inexistente vira erro na hora, em vez de devolver vazio em silêncio.

Negativas:

- O contrato HTTP mudou. O `populate` do Mongoose trocava o id pelo documento; no Prisma o id fica e a relação vem em chave separada (`instituicaoId` e `instituicao`). Clientes precisaram ajustar leitura.
- Os testes exigem o PostgreSQL de pé (`docker compose up -d postgres`).
- O custo da migração foi de cinco etapas e uma troca de SGBD. Detalhes em [Migração](../../documentacao/11-migracao.md).

## Evidências no código

- `prisma/schema.prisma`: convenções no cabeçalho, 20 modelos, 9 enums.
- `prisma/migrations/20260805220051_init_uuid/`: migration da troca de ids e do SGBD.
- `src/repositories/base/BaseRepository.js` e `src/repositories/filters/`: consultas Prisma.
- `documentacao/11-migracao.md` (etapas 1 e 3) e `documentacao/12-historico.md`.

## Veja também

- [ADR 0002: BetterAuth com sessão no lugar de JWT duplo](0002-betterauth-sessao-no-lugar-de-jwt.md)
- [ADR 0003: Arquitetura em camadas com DI manual](0003-arquitetura-em-camadas-com-di-manual.md)
- [Modelo de dados](../06-banco-de-dados/README.md)
- [Dicionário de dados](../06-banco-de-dados/dicionario-de-dados.md)
- [Índice de ADRs](README.md)
