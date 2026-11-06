# Milestone 2: protótipo, UML, banco de dados e métricas

Contexto de ensino: Engenharia de Software (Fábrica de Software I), Milestone 2 do projeto FilaCidadã. Prazo: definido pelo professor (não consta nos arquivos do repositório).

Esta página é o checklist de entrega. Cada item aponta para o artefato na árvore de `docs/`. Marque o item só depois da verificação indicada.

## Checklist

| Feito | Entrega | Artefato | Verificação antes de marcar |
|---|---|---|---|
| [ ] | Protótipo: navegação | [README do protótipo](../04-prototipo/README.md), [site-map.svg](../04-prototipo/site-map.svg) | Mapa atualizado com as telas revisadas |
| [ ] | Protótipo: IFML | [ifml/README.md](../04-prototipo/ifml/README.md) | Um diagrama IFML por perfil, com as ações ligadas aos UC |
| [ ] | Wireframes revisados | [wireframes/](../04-prototipo/wireframes/) | Mudanças do M1 registradas no README de cada perfil |
| [ ] | UML: visão geral de modelagem | [modelagem/README.md](../05-modelagem/README.md) | Índice aponta para todos os diagramas abaixo |
| [ ] | UML: casos de uso | [casos-de-uso.svg](../05-modelagem/casos-de-uso/casos-de-uso.svg) | UC-01 a UC-15 e os quatro atores ACT-01 a ACT-04 |
| [ ] | UML: classes | [classes.svg](../05-modelagem/classes/classes.svg) | Classes em português, singular, derivadas do schema |
| [ ] | UML: sequência | [sequência](../05-modelagem/sequencia/README.md) | Ao menos uma sequência por caso de uso crítico (UC-08, UC-10) |
| [ ] | UML: atividades | [atividades](../05-modelagem/atividades/README.md) | Fluxos principais e alternativos de cada UC escolhido |
| [ ] | UML: estados | [estados](../05-modelagem/estados/README.md) | Estados da senha e da fila, com transições que existem no código |
| [ ] | Banco: modelo conceitual | [modelo-conceitual.svg](../06-banco-de-dados/modelo-conceitual.svg) | Entidades coincidem com as classes do diagrama de classes |
| [ ] | Banco: modelo lógico | [modelo-logico.svg](../06-banco-de-dados/modelo-logico.svg) | Chaves e FKs coincidem com `prisma/schema.prisma` |
| [ ] | Banco: dicionário de dados | [dicionario-de-dados.md](../06-banco-de-dados/dicionario-de-dados.md) | Uma linha por coluna do schema |
| [ ] | Banco: script SQL | [schema.sql](../06-banco-de-dados/schema.sql) | Gerado ou conferido contra as migrations |
| [ ] | Métricas: exportação do GitLab (M2) | [export-gitlab-m2.csv](../02-processo/metricas/export-gitlab-m2.csv) | Período do export cobre o intervalo do milestone |

## Critério de conclusão

Todos os itens marcados e cada diagrama conferido contra o código ou contra o modelo de dados. Divergências entre diagrama e código entram em `docs/05-modelagem/ocl/divergencias-m2.md`, não são corrigidas em silêncio.

## Veja também

- [Milestone 1](milestone-1.md)
- [Milestone 3](milestone-3.md)
- [Modelagem](../05-modelagem/README.md)
- [Banco de dados](../06-banco-de-dados/README.md)
- [Índice de ADRs](../adr/README.md)
