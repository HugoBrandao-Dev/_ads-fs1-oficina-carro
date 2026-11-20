# Wireframes: Orçamentos

Fábrica de Software I · Protótipo em alta fidelidade · Desktop 1440×900 · Perfil Secretária

Estes wireframes mostram o ciclo do orçamento, do registro do problema relatado à autorização do serviço: o histórico de orçamentos, a criação, a montagem com serviços e mecânico, a decisão do cliente e os filtros por status. O orçamento aprovado é o ponto de partida da ordem de serviço. A navegação está modelada no [IFML-05](../../../ifml/README.md#ifml-05-orçamentos). O fluxo completo, de ponta a ponta, usa o orçamento ORC-1043 do cliente Antônio Ribeiro Sales.

## Telas

| Nº | Tela | Estado | US | UC |
|---|---|---|---|---|
| [3.01](<3.01 - Histórico de orçamentos - vazio (US-018).svg>) | Histórico de orçamentos | Vazio | US-018 | Nenhum |
| [3.02](<3.02 - Histórico de orçamentos - listagem.svg>) | Histórico de orçamentos | Listagem | US-018 | Nenhum |
| [3.03](<3.03 - Novo orçamento - formulário vazio (US-016).svg>) | Novo orçamento | Formulário vazio | US-016 | UC-006 |
| [3.04](<3.04 - Novo orçamento - formulário preenchido (US-016).svg>) | Novo orçamento | Formulário preenchido | US-016 | UC-006 |
| [3.05](<3.05 - Orçamento criado com sucesso (US-016).svg>) | Orçamento criado com sucesso | Sucesso | US-016 | UC-006 |
| [3.06](<3.06 - Histórico de orçamentos - com novo orçamento (US-018).svg>) | Histórico de orçamentos | Com o novo orçamento | US-018 | Nenhum |
| [3.07](<3.07 - Orçamento ORC-1043 - em aberto.svg>) | Orçamento ORC-1043 | Em aberto | US-016 | UC-006 |
| [3.08](<3.08 - Orçamento ORC-1043 - adicionar serviços e mecânico.svg>) | Orçamento ORC-1043 | Adicionar serviços e mecânico | US-016 | UC-006 |
| [3.09](<3.09 - Confirmação - orçada criada.svg>) | Confirmação: orçada criada | Sucesso | US-016 | UC-006 |
| [3.10](<3.10 - Orçamento ORC-1043 - orçada (aprovar ou recusar).svg>) | Orçamento ORC-1043 | Orçado: aprovar ou recusar | US-017 | Nenhum |
| [3.11](<3.11 - Confirmação - orçamento aprovado.svg>) | Confirmação: orçamento aprovado | Sucesso | US-017 | Nenhum |
| [3.12](<3.12 - Orçamento ORC-1043 - aprovado (iniciar execução).svg>) | Orçamento ORC-1043 | Aprovado: iniciar execução | US-017, US-028 | UC-009, UC-010, UC-014 |
| [3.13](<3.13 - Histórico de orçamentos - após aprovação.svg>) | Histórico de orçamentos | Após a aprovação | US-018 | Nenhum |
| [3.14](<3.14 - Filtro por status - menu aberto.svg>) | Filtro por status | Menu aberto | US-026 | Nenhum |
| [3.15](<3.15 - Filtro em aberto - menu aberto.svg>) | Filtro em aberto | Menu aberto | US-026 | Nenhum |
| [3.16](<3.16 - Filtro em aberto - resultado.svg>) | Filtro em aberto | Resultado | US-026 | Nenhum |
| [3.17](<3.17 - Filtro orçados - menu aberto.svg>) | Filtro orçados | Menu aberto | US-026 | Nenhum |
| [3.18](<3.18 - Filtro orçados - resultado.svg>) | Filtro orçados | Resultado | US-026 | Nenhum |
| [3.19](<3.19 - Filtro aprovados - menu aberto.svg>) | Filtro aprovados | Menu aberto | US-026 | Nenhum |
| [3.20](<3.20 - Filtro aprovados - resultado.svg>) | Filtro aprovados | Resultado | US-026 | Nenhum |
| [3.21](<3.21 - Filtro recusados - menu aberto.svg>) | Filtro recusados | Menu aberto | US-026 | Nenhum |
| [3.22](<3.22 - Filtro recusados - resultado.svg>) | Filtro recusados | Resultado | US-026 | Nenhum |

Os casos de uso (UC) reproduzem os vínculos registrados nas issues do GitLab, conforme o índice de [historias-de-usuario.md](../../../../03-requisitos/historias-de-usuario.md#índice).

## Histórico de orçamentos

Tela principal da área. A lista mostra o status atual de cada orçamento e abre o detalhe pela linha.

**3.01 · Histórico de orçamentos · Vazio**

![Histórico de orçamentos sem registros: mensagem Nenhum orçamento registrado ainda e botão Novo orçamento](<3.01 - Histórico de orçamentos - vazio (US-018).svg>)

**3.02 · Histórico de orçamentos · Listagem**

![Tabela de orçamentos com número, cliente, veículo, data, valor total e etiqueta de status, busca, filtros de status e de data e paginação](<3.02 - Histórico de orçamentos - listagem.svg>)

**3.06 · Histórico de orçamentos · Com o novo orçamento**

![Histórico de orçamentos com o ORC-1043 de Antônio Ribeiro Sales incluído na lista, com status aberta](<3.06 - Histórico de orçamentos - com novo orçamento (US-018).svg>)

**3.13 · Histórico de orçamentos · Após a aprovação**

![Histórico de orçamentos com o ORC-1043 na lista após a aprovação](<3.13 - Histórico de orçamentos - após aprovação.svg>)

## Criar orçamento

**3.03 · Novo orçamento · Formulário vazio**

![Formulário Criar orçamento com cliente, veículo, placa, quilometragem, contato preferencial, observações internas e valor do orçamento, e botão Criar Orçamento](<3.03 - Novo orçamento - formulário vazio (US-016).svg>)

**3.04 · Novo orçamento · Formulário preenchido**

![Formulário Criar orçamento preenchido para Antônio Ribeiro Sales, Honda Civic placa ABC-1234, com o problema relatado e valor de R$ 545,00](<3.04 - Novo orçamento - formulário preenchido (US-016).svg>)

**3.05 · Orçamento criado com sucesso · Sucesso**

![Confirmação Orçamento criado com sucesso, ORC-1043 aguardando aprovação, com os botões Ver orçamento, Novo orçamento e Ver históricos de orçamentos](<3.05 - Orçamento criado com sucesso (US-016).svg>)

## Montar o orçamento

A secretária lança os serviços e o mecânico responsável; ao concluir, o orçamento passa a "orçado".

**3.07 · Orçamento ORC-1043 · Em aberto**

![Detalhe do orçamento ORC-1043 com status aberta, dados do cliente e do veículo, valor do orçamento e os botões Adicionar Orçamento e Salvar](<3.07 - Orçamento ORC-1043 - em aberto.svg>)

**3.08 · Orçamento ORC-1043 · Adicionar serviços e mecânico**

![Detalhe do ORC-1043 com a tabela de serviços realizados e valores, total de R$ 545,00 e os botões Voltar, Adicionar Mecânico e Criar orçada](<3.08 - Orçamento ORC-1043 - adicionar serviços e mecânico.svg>)

**3.09 · Confirmação: orçada criada · Sucesso**

![Janela de confirmação Orçada criada com sucesso para o ORC-1043, com o botão Voltar ao histórico](<3.09 - Confirmação - orçada criada.svg>)

## Decisão do cliente

Com o orçamento orçado, a secretária registra a aprovação ou a recusa. O orçamento aprovado oferece "Iniciar Execução", que abre a OS (ver a pasta [4 - Ordens de serviço](<../4 - Ordens de serviço/README.md>)).

**3.10 · Orçamento ORC-1043 · Orçado: aprovar ou recusar**

![Detalhe do ORC-1043 com status orçada, observações internas, valor de R$ 545,00 e os botões Consultar o Orçamento, Aprovado e Recusar](<3.10 - Orçamento ORC-1043 - orçada (aprovar ou recusar).svg>)

**3.11 · Confirmação: orçamento aprovado · Sucesso**

![Janela de confirmação Orçamento aprovado com sucesso para o ORC-1043, com o botão Voltar ao histórico](<3.11 - Confirmação - orçamento aprovado.svg>)

**3.12 · Orçamento ORC-1043 · Aprovado: iniciar execução**

![Detalhe do ORC-1043 com status aprovado, mecânico responsável Renan Souza e os botões Consultar o Orçamento e Iniciar Execução](<3.12 - Orçamento ORC-1043 - aprovado (iniciar execução).svg>)

## Filtro por status

Cada status tem dois quadros: o menu aberto e o resultado.

**3.14 · Filtro por status · Menu aberto**

![Histórico de orçamentos com o menu de status aberto: em aberta, orçada, aprovada e recusado](<3.14 - Filtro por status - menu aberto.svg>)

**3.15 · Filtro em aberto · Menu aberto**

![Lista de orçamentos em aberto com o menu de status aberto](<3.15 - Filtro em aberto - menu aberto.svg>)

**3.16 · Filtro em aberto · Resultado**

![Lista filtrada de orçamentos em aberto, todos com etiqueta aberta](<3.16 - Filtro em aberto - resultado.svg>)

**3.17 · Filtro orçados · Menu aberto**

![Lista de orçamentos orçados com o menu de status aberto](<3.17 - Filtro orçados - menu aberto.svg>)

**3.18 · Filtro orçados · Resultado**

![Lista filtrada de orçamentos orçados, todos com etiqueta orçada](<3.18 - Filtro orçados - resultado.svg>)

**3.19 · Filtro aprovados · Menu aberto**

![Lista de orçamentos aprovados com o menu de status aberto](<3.19 - Filtro aprovados - menu aberto.svg>)

**3.20 · Filtro aprovados · Resultado**

![Lista filtrada de orçamentos aprovados, todos com etiqueta aprovado](<3.20 - Filtro aprovados - resultado.svg>)

**3.21 · Filtro recusados · Menu aberto**

![Lista de orçamentos recusados com o menu de status aberto](<3.21 - Filtro recusados - menu aberto.svg>)

**3.22 · Filtro recusados · Resultado**

![Lista filtrada de orçamentos recusados, todos com etiqueta recusado](<3.22 - Filtro recusados - resultado.svg>)

## Regras de comportamento

Cada linha é um cenário Gherkin das histórias da área. A coluna Situação indica se o wireframe mostra o comportamento: **Desenhado**, **Parcial** (a tela existe, mas falta parte do cenário), **Não desenhado** ou **Divergente** (a tela contradiz o cenário). Cenários marcados `@proposta` foram escritos pela equipe de documentação e ainda não estão nas issues.

| Cenário | US | Telas | Situação | Observação |
|---|---|---|---|---|
| Lançar serviços e peças | US-016 | 3.07 → 3.08 → 3.09 | Parcial | Os serviços aparecem com valor e total; não há lançamento de peças nem divisão entre peças e mão de obra |
| Recusa do cliente | US-017 | 3.10 | Parcial | Há o botão "Recusar", mas não há campo para o motivo nem a tela seguinte à recusa |
| Aprovação sem orçamento | US-017 | 3.07 | Desenhado | O orçamento em aberto não oferece a ação de aprovar |
| Aprovação do cliente `@proposta` | US-017 | 3.10 → 3.11 → 3.12 | Parcial | A aprovação está desenhada, mas não há campo para o meio da resposta (presencial, telefone ou mensagem) |
| Orçamento que já passou por vários status | US-018 | 3.02, 3.13 | Parcial | A lista mostra só o status atual; as transições com autor e data/hora não aparecem |
| Orçamento recém-aberto | US-018 | 3.01, 3.06 | Parcial | Há o estado vazio da lista, que é outro caso; o histórico de um único orçamento não foi desenhado |
| Tentativa de alterar o histórico | US-018 | 3.02 | Desenhado | A lista não oferece ação de editar nem de remover registros |
| Filtro registrado na issue | US-026 | 3.14 a 3.20 | Desenhado | Filtros por aberto, orçado e aprovado |
| Filtrar por um status `@proposta` | US-026 | 3.14 a 3.22 | Desenhado | Inclui o status recusado |
| Status sem orçamentos `@proposta` | US-026 | — | Não desenhado | Todos os filtros desenhados têm resultado |

## Divergências e achados

| ID | Divergência | Telas | Tratamento proposto |
|---|---|---|---|
| W-05 | O breadcrumb começa com um nível vazio ("/ Orçamento / Histórico de orçamentos"). | 3.01 a 3.22 | Corrigir para "Atendimento › Orçamentos" (UX-01) |
| W-06 | Os nomes de status variam: "Aberta", "em aberto" e "Em aberta"; o rodapé de 3.18 fala em "orçamentos em aberto". | 3.14 a 3.22 | Padronizar aberto, orçado, aprovado e recusado (UX-03) |
| W-07 | Conteúdo de preenchimento: todos os orçamentos em aberto custam R$ 100,00 e o ORC-0415 aparece duas vezes. | 3.15, 3.16, 3.18 | Usar valores plausíveis (UX-07) |
| W-08 | Pela US-016, quem monta o orçamento é o mecânico; nos wireframes, é a secretária. | 3.07, 3.08 | Confirmar com o grupo quem lança os serviços e ajustar a história ou a tela |

## Veja também

- [Wireframes: todas as áreas](../../README.md)
- [Índice das telas](<../0 - Índice.md>)
- [Site map](../../../site-map.md)
- [Protótipo: revisão de usabilidade e pendências](../../../README.md)
- [IFML](../../../ifml/README.md)
- [Histórias de usuário](../../../../03-requisitos/historias-de-usuario.md)
