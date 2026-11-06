# Milestone 3: entrega final, documentação e apresentação

Contexto de ensino: Engenharia de Software (Fábrica de Software I), Milestone 3 do projeto FilaCidadã. Prazo: definido pelo professor (não consta nos arquivos do repositório).

Esta página é o checklist da entrega final e o roteiro da apresentação de 10 a 15 minutos. Marque cada item depois da verificação indicada.

## Checklist

| Feito | Entrega | Artefato | Verificação antes de marcar |
|---|---|---|---|
| [ ] | UML consolidado: casos de uso | [casos-de-uso.svg](../05-modelagem/casos-de-uso/casos-de-uso.svg) | Versão final, com as correções do M2 |
| [ ] | UML consolidado: classes | [classes.svg](../05-modelagem/classes/classes.svg) | Nomes iguais aos do dicionário de dados |
| [ ] | UML consolidado: sequência, atividades e estados | [sequência](../05-modelagem/sequencia/README.md), [atividades](../05-modelagem/atividades/README.md), [estados](../05-modelagem/estados/README.md) | Cada diagrama citado no índice de modelagem |
| [ ] | Banco de dados final | [README do banco](../06-banco-de-dados/README.md), [modelo-logico.svg](../06-banco-de-dados/modelo-logico.svg), [dicionario-de-dados.md](../06-banco-de-dados/dicionario-de-dados.md), [schema.sql](../06-banco-de-dados/schema.sql) | Conferido contra `prisma/schema.prisma` |
| [ ] | Documentação do sistema | [README da documentação](../README.md), [CHANGELOG.md](../CHANGELOG.md), [CONTRIBUTING.md](../CONTRIBUTING.md) | Instruções de execução testadas do zero |
| [ ] | Decisões de arquitetura | [índice de ADRs](../adr/README.md) | Cinco ADRs com status atualizado |
| [ ] | OCL | [ocl/README.md](../05-modelagem/ocl/README.md), [divergencias-m2.md](../05-modelagem/ocl/divergencias-m2.md) | Restrições verificadas no código e divergências do M2 resolvidas ou listadas |
| [ ] | BPMN do processo as-is | [processo-as-is.bpmn](../02-processo/bpmn/processo-as-is.bpmn), [processo-as-is.svg](../02-processo/bpmn/processo-as-is.svg), [README do BPMN](../02-processo/bpmn/README.md) | Abre no editor BPMN e corresponde ao processo descrito |
| [ ] | Rastreabilidade: matriz | [matriz.md](../07-rastreabilidade/matriz.md) | Toda UC, RF, RNF e US aparece na matriz |
| [ ] | Rastreabilidade: lacunas | [lacunas.md](../07-rastreabilidade/lacunas.md) | Cada lacuna tem responsável e ação |
| [ ] | Rastreabilidade: malha | [malha-rastreabilidade.svg](../07-rastreabilidade/malha-rastreabilidade.svg), [rastreabilidade-requisitos.svg](../03-requisitos/rastreabilidade-requisitos.svg) | Os dois diagramas coincidem com a matriz |
| [ ] | Qualidade: monitorias e retrospectivas | [monitorias.md](../08-qualidade/monitorias.md), [retrospectiva SWEBOK](../08-qualidade/retrospectiva-swebok.md), [retrospectiva final](../08-qualidade/retrospectiva-final.md) | Monitoria executada na data da entrega |
| [ ] | Métricas: exportação do GitLab (M3) | [export-gitlab-m3.csv](../02-processo/metricas/export-gitlab-m3.csv) | Período cobre todo o projeto |
| [ ] | Apresentação de 10 a 15 minutos | Roteiro abaixo | Ensaiada no tempo, com os artefatos abertos |

## Roteiro da apresentação (14 minutos)

Perguntas ficam fora do tempo. Cada bloco indica o que mostrar na tela.

| Minutos | Bloco | O que dizer | O que mostrar |
|---|---|---|---|
| 0 a 1 | Abertura | Problema: filas presenciais e online para atendimento público. Quem usa o sistema (ACT-01 a ACT-04) | [PM Canvas](../01-visao/pm-canvas.svg) |
| 1 a 2 | Visão e escopo | Objetivos e escopo do RFP; o que ficou fora | [RFP](../01-visao/rfp.md) |
| 2 a 4 | Requisitos | Requisitos funcionais por caso de uso (UC-01 a UC-15), não funcionais e histórias | [Requisitos funcionais](../03-requisitos/requisitos-funcionais.md), [Histórias](../03-requisitos/historias-de-usuario.md) |
| 4 a 6 | Protótipo | Site Map, um wireframe por perfil e o fluxo do cidadão, da senha ao atendimento | [Site Map](../04-prototipo/site-map.svg), wireframes do cidadão |
| 6 a 8 | Modelagem UML | Casos de uso, classes e uma sequência (emissão de senha) | [Casos de uso](../05-modelagem/casos-de-uso/casos-de-uso.svg), [Classes](../05-modelagem/classes/classes.svg) |
| 8 a 10 | Banco e OCL | Modelo lógico, uma restrição OCL e uma divergência resolvida | [Modelo lógico](../06-banco-de-dados/modelo-logico.svg), [OCL](../05-modelagem/ocl/README.md) |
| 10 a 11 | Processo e métricas | Processo as-is em BPMN e o que o GitLab mostrou | [BPMN](../02-processo/bpmn/processo-as-is.svg), [Métricas](../02-processo/metricas/README.md) |
| 11 a 12 | Rastreabilidade | Como um requisito chega ao código e ao teste; lacunas abertas | [Matriz](../07-rastreabilidade/matriz.md), [Malha](../07-rastreabilidade/malha-rastreabilidade.svg) |
| 12 a 13 | Arquitetura e decisões | Três decisões (ADR 0001 banco, ADR 0002 sessão, ADR 0004 GraphQL) e a demonstração de uma rota ou do GraphQL | [ADRs](../adr/README.md), `/graphql` |
| 13 a 14 | Qualidade e retrospectiva | O que manter, mudar e parar; o que falta | [Retrospectiva final](../08-qualidade/retrospectiva-final.md) |

## Critério de conclusão

O checklist está completo, cada item foi conferido contra o artefato, e a apresentação foi ensaiada dentro de 10 a 15 minutos.

## Veja também

- [Milestone 1](milestone-1.md)
- [Milestone 2](milestone-2.md)
- [Retrospectiva final](../08-qualidade/retrospectiva-final.md)
- [Índice de ADRs](../adr/README.md)
- [Rastreabilidade](../07-rastreabilidade/matriz.md)
