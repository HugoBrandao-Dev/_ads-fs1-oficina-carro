# Divergências de nomes: OCL, código e diagrama de classes (M2)

Milestone 2 · Unidade: Engenharia de Software (Fábrica de Software I) · Analista de modelagem

Esta tabela compara os nomes usados nas [restrições OCL](README.md) com os nomes do schema Prisma (fonte da verdade do código) e com o catálogo de classes do M2 definido em [docs/README.md](../../README.md): classes em português, no singular. O diagrama de classes ([classes/README.md](../classes/README.md)) ainda não existe neste repositório. Quando for publicado, esta tabela deve ser conferida contra ele item a item, porque a coluna "Catálogo M2" foi preenchida pela convenção, não pelo diagrama.

| # | Nome no OCL | Nome no schema e código | Nome no catálogo M2 | Razão |
|---|---|---|---|---|
| N-01 | `Usuario` | `User` (model; tabela `users`) | `Usuario` | O BetterAuth exige o model `User`. O domínio usa português. Mantido o nome do catálogo, e o mapeamento está na OCL |
| N-02 | `Papel` (enumeração) | enum `Papel` e model `UsuarioPapel` (tabela `usuario_papeis`) | `Papel` como classe | No schema, `Papel` é enum, e a relação N:N com o usuário é a tabela de junção. Na OCL, `Usuario.papeis : Set(Papel)`. Registrado também em [docs/README.md](../../README.md), item 3 das divergências. No diagrama, desenhar como enumeração (estereótipo «enumeration») |
| N-03 | `Fluxo` | `Flow` | não listado | O catálogo não cobre fluxos. Nome em português, pela convenção do domínio |
| N-04 | `PassoFluxo` | `FlowStep` | não listado | Evita confusão com `TipoEtapa`, que é configuração por instituição e não tem vínculo com o grafo do fluxo |
| N-05 | `TransicaoFluxo` | `FlowTransition` | não listado | Mesmo critério de N-03. Os atributos `fromStep` e `toStep` mantêm os nomes do schema, para que a OCL seja conferida campo a campo |
| N-06 | `AcompanhamentoFluxo` | `SenhaFlowTracking` | não listado | O nome do schema mistura senha e fluxo. "Acompanhamento" descreve o rastro de uma senha dentro de um fluxo |
| N-07 | `HistoricoFluxo` | `SenhaFlowHistorico` | não listado | Mesmo critério de N-06. É o registro append-only de cada passo |
| N-08 | `MensagemChat` | `ChatMensagem` | não listado | Português, com "chat" mantido por ser o termo usado na interface |
| N-09 | `Mesa` sem associação com `Senha` (`Senha.mesa` é texto) | `Senha.mesa` é `String?`, sem chave estrangeira para `mesas` | `Mesa` ligada a `Fila` | No código, a senha guarda o número da estação como texto (`mesa`, `mesaNome`). Um diagrama que ligue `Senha` a `Mesa` por associação diverge do código |
| N-10 | Relação `operador` (de `Senha` para `Usuario`) | relação `operador` (`Senha.operadorId`) | ator ACT-02 "Operador" | "Operador" é papel (`Papel::OPERADOR`) e ator, não classe. No diagrama, a relação se chama `operador`, sem criar classe `Operador` |
| N-11 | Fora do modelo: `Session`, `Account`, `Verification` | models do BetterAuth | não listado | São tabelas de autenticação, geridas pelo BetterAuth (`src/config/auth.js`). A OCL não as usa. Sugestão: omiti-las do diagrama de classes de domínio |
| N-12 | Enumerações `StatusSenha`, `PrioridadeSenha`, `StatusInstituicao`, `TipoAtendimento`, `ModoQrCode`, `Papel` | mesmos nomes de enum no schema | não listado | Nomes iguais aos do schema. Mostrar no diagrama como «enumeration», sem atributos de classe |

Sem divergência de nome: `Instituicao`, `TipoEtapa`, `Fila`, `Senha`, `QrCode`, `Auditoria`, `Notificacao` e `LandingPage` têm o mesmo nome no schema, na OCL e no catálogo.

Veja também: [Restrições OCL](README.md) · [Modelo de classes](../classes/README.md) · [Convenções de IDs e nomes](../../README.md) · [Dicionário de dados](../../06-banco-de-dados/dicionario-de-dados.md)
