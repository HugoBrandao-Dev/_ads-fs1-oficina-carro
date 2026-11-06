# ADR 0002: BetterAuth com sessão persistida no lugar de JWT duplo

Contexto de ensino: Engenharia de Software (Fábrica de Software I), segurança e autenticação.

| Campo | Valor |
|---|---|
| Status | Aceita |
| Data da decisão | 2026-07-29 (BetterAuth na migração); 2026-09-30 (plugin bearer para o GraphQL) |
| Data do registro | 2026-11-06 |
| Decisor | Gilberto, mantenedor do repositório |

## Contexto

A autenticação de 2026/1 emitia um access token e um refresh token em JWT. Os problemas que motivaram a troca estão em [Migração, etapa 2](../../documentacao/11-migracao.md):

- Um token válido vale até expirar. Para revogar, era preciso manter uma lista de bloqueio.
- Os papéis ficavam dentro do token, na emissão. Um operador rebaixado continuava operador até o token expirar, por horas.
- O hash de senha era gerado pelo próprio projeto (`usuarios.senhaHash`, bcrypt manual). O login social dependia de um campo `googleId` por usuário, sem suporte a mais de um provedor.

## Decisão

Usar o BetterAuth 1.6 com sessão persistida na tabela `sessions` e cookie assinado. Regras adotadas:

- Sessão de 7 dias, renovada sozinha após 1 dia de uso (`session.updateAge`).
- `cookieCache` de 5 minutos, para evitar ida ao banco a cada requisição.
- Papéis lidos de `usuario_papeis` a cada requisição, com cache de 30 segundos em memória. Ao alterar papéis, o cache do usuário é invalidado.
- O contrato interno `req.user = { id, papeis, instituicaoId, fusoHorario }` foi preservado. Por isso controllers e services não mudaram.
- Plugin `bearer` ativado para o GraphQL, que aceita `Authorization: Bearer`.
- Com credencial errada, a API responde 401, o único 401 do sistema. A sessão expirada continua respondendo 498, porque clientes existentes tratam 498 como fim de sessão.

## Alternativas consideradas

| Alternativa | Situação |
|---|---|
| JWT duplo com lista de bloqueio | Rejeitada: revogação dependia de lista externa e papel embutido no token atrasava a revogação. |
| Sessão própria, sem framework | Não avaliada nos documentos lidos. |
| BetterAuth com sessão em tabela | Adotada. |

## Consequências

Positivas:

- Revogação imediata: o logout apaga a linha em `sessions`.
- A revogação de papel é lida do banco. Como o cache de 30 segundos pode segurar a leitura antiga por esse intervalo, o atraso máximo é de 30 segundos, salvo quando a invalidação explícita é chamada.
- Hash de senha e contas ficam com o framework (`accounts.password`). A tabela `users` não tem coluna de senha.

Negativas e custos:

- Cada requisição não cacheada consulta o banco. Os dois caches reduzem esse custo, com o preço consciente de 30 segundos para papéis.
- O cookie de sessão exige `trustedOrigins` correto. Sem `CORS_ORIGINS` com o domínio do front, o login responde 403 `INVALID_ORIGIN`.
- `BETTER_AUTH_SECRET` é obrigatório. Sem ele o módulo lança erro e a API não sobe.
- Linhas de sessão vencidas não são removidas. A expiração é lógica; falta uma rotina de limpeza (ver [Retrospectiva final](../08-qualidade/retrospectiva-final.md)).

## Evidências no código

- `src/config/auth.js`: `session.expiresIn`, `session.updateAge`, `cookieCache`, `trustedOrigins`, `BETTER_AUTH_SECRET`.
- `src/middlewares/AuthMiddleware.js`: cache de papéis de 30 segundos e função de invalidação.
- `src/graphql/context.js`: o mesmo `auth.api.getSession()` e o mesmo carregamento de papéis do REST.
- `documentacao/06-autenticacao.md` e `documentacao/12-historico.md`.

## Veja também

- [ADR 0001: PostgreSQL com Prisma no lugar do MongoDB](0001-postgresql-prisma-no-lugar-do-mongodb.md)
- [ADR 0004: GraphQL ao lado do REST](0004-graphql-ao-lado-do-rest.md)
- [Requisitos não funcionais](../03-requisitos/requisitos-nao-funcionais.md)
- [Índice de ADRs](README.md)
