# Wireframes: Ordens de serviço

Fábrica de Software I · Protótipo em alta fidelidade · Desktop 1440×900 · Perfil Secretária

Estes wireframes mostram a ordem de serviço depois que o orçamento é aprovado: as listas por status, a finalização do serviço e o detalhe com o histórico do atendimento. Pela regra do grupo, a OS não tem formulário de cadastro próprio: ela nasce do orçamento aprovado, pela ação "Iniciar Execução" (3.12). A navegação está modelada no [IFML-04](../../../ifml/README.md#ifml-04-ordens-de-serviço).

## Telas

| Nº | Tela | Estado | US | UC |
|---|---|---|---|---|
| [4.01](<4.01 - OS aprovadas - tela inicial.svg>) | Ordens de serviço aprovadas | Tela inicial | US-012 | Nenhum |
| [4.02](<4.02 - Filtro por status - aprovadas (menu aberto).svg>) | Filtro por status: aprovadas | Menu aberto | US-012 | Nenhum |
| [4.03](<4.03 - OS em execução - listagem.svg>) | OS em execução | Listagem | US-012 | Nenhum |
| [4.04](<4.04 - Filtro por status - em execução (menu aberto).svg>) | Filtro por status: em execução | Menu aberto | US-012 | Nenhum |
| [4.05](<4.05 - OS em execução - detalhe (finalizar).svg>) | OS em execução | Detalhe: finalizar | US-015, US-028 | UC-009, UC-010, UC-014 |
| [4.06](<4.06 - Confirmação - OS finalizada.svg>) | Confirmação: OS finalizada | Sucesso | US-028 | UC-009, UC-010, UC-014 |
| [4.07](<4.07 - OS finalizadas - listagem.svg>) | OS finalizadas | Listagem | US-012 | Nenhum |
| [4.08](<4.08 - Filtro por status - finalizadas (menu aberto).svg>) | Filtro por status: finalizadas | Menu aberto | US-012 | Nenhum |
| [4.09](<4.09 - OS finalizada - detalhe e histórico (OS-0184 Carlos Eduardo).svg>) | OS finalizada | Detalhe e histórico | US-015, US-027 | Nenhum |

Os casos de uso (UC) reproduzem os vínculos registrados nas issues do GitLab, conforme o índice de [historias-de-usuario.md](../../../../03-requisitos/historias-de-usuario.md#índice).

## Listagens por status

Cada status tem a lista e o menu de filtro aberto.

**4.01 · Ordens de serviço aprovadas · Tela inicial**

![Lista de ordens de serviço aprovadas com número, cliente, veículo, placa, abertura, total e etiqueta de status, busca, filtros e Exportar Relatório](<4.01 - OS aprovadas - tela inicial.svg>)

**4.02 · Filtro por status: aprovadas · Menu aberto**

![Lista de OS com o menu de status aberto: aprovado, em execução e concluído](<4.02 - Filtro por status - aprovadas (menu aberto).svg>)

**4.03 · OS em execução · Listagem**

![Lista de ordens de serviço em execução, com etiqueta em execução](<4.03 - OS em execução - listagem.svg>)

**4.04 · Filtro por status: em execução · Menu aberto**

![Lista de OS em execução com o menu de status aberto](<4.04 - Filtro por status - em execução (menu aberto).svg>)

**4.07 · OS finalizadas · Listagem**

![Lista de ordens de serviço finalizadas, com etiqueta finalizado](<4.07 - OS finalizadas - listagem.svg>)

**4.08 · Filtro por status: finalizadas · Menu aberto**

![Lista de OS finalizadas com o menu de status aberto](<4.08 - Filtro por status - finalizadas (menu aberto).svg>)

## Execução e finalização

**4.05 · OS em execução · Detalhe: finalizar**

![Detalhe da OS-0184 em execução com cliente, veículo, observações internas, valor de R$ 545,00, mecânico Renan Souza e os botões Consultar a OS e Finalizar](<4.05 - OS em execução - detalhe (finalizar).svg>)

**4.06 · Confirmação: OS finalizada · Sucesso**

![Janela de confirmação Ordem de serviço finalizada com sucesso para a OS-0184, com o botão Voltar ao histórico](<4.06 - Confirmação - OS finalizada.svg>)

## Detalhe e histórico do atendimento

**4.09 · OS finalizada · Detalhe e histórico**

![Detalhe da OS-0184 finalizada com dados do cliente e do veículo e o histórico do atendimento: orçamento criado, aprovado, OS aberta, designada ao Box 2 e finalizada](<4.09 - OS finalizada - detalhe e histórico (OS-0184 Carlos Eduardo).svg>)

## Regras de comportamento

Cada linha é um cenário Gherkin das histórias da área. A coluna Situação indica se o wireframe mostra o comportamento: **Desenhado**, **Parcial** (a tela existe, mas falta parte do cenário), **Não desenhado** ou **Divergente** (a tela contradiz o cenário). Cenários marcados `@proposta` foram escritos pela equipe de documentação e ainda não estão nas issues.

| Cenário | US | Telas | Situação | Observação |
|---|---|---|---|---|
| Cadastro com a descrição do problema | US-008 | 3.12 | Divergente | Não há formulário de OS: ela é aberta pelo orçamento aprovado, e o problema relatado vem das observações do orçamento (D-07 das histórias) |
| Descrição do problema em branco | US-008 | — | Não desenhado |  |
| Atualização com campos obrigatórios preenchidos | US-009 | — | Não desenhado | O detalhe da OS (4.05, 4.09) é somente leitura |
| Carro que já tem OS registrada | US-009 | — | Não desenhado |  |
| Descrição da OS em branco | US-009 | — | Não desenhado |  |
| Abrir a lista de OS | US-012 | 4.01, 4.03, 4.07 | Desenhado | A linha abre o detalhe da OS |
| Abrir as informações de uma OS | US-015 | 4.05, 4.09 | Parcial | As informações aparecem, mas não há acesso à atualização |
| Critério registrado na issue | US-027 | 4.09 | Desenhado | O histórico mostra a situação da OS |
| Transições em ordem `@proposta` | US-027 | 4.09 | Parcial | As transições aparecem em ordem, sem autor e sem data/hora; a passagem para "em execução" não aparece |
| Critério registrado na issue | US-028 | 3.12, 4.05 | Desenhado |  |
| Iniciar a execução `@proposta` | US-028 | 3.12 | Desenhado | O botão "Iniciar Execução" aparece com o mecânico responsável já definido |
| Iniciar a execução sem box ou mecânico `@proposta` | US-028 | — | Não desenhado |  |
| Concluir o serviço `@proposta` | US-028 | 4.05 → 4.06; 8.02 → 8.03 | Desenhado | A conclusão aparece em dois lugares: "Finalizar" na OS e "Concluir serviço" na Agenda dos boxes |

## Divergências e achados

| ID | Divergência | Telas | Tratamento proposto |
|---|---|---|---|
| W-09 | O detalhe e a confirmação da OS marcam "Orçamento" no menu e usam o breadcrumb "Orçamento / Histórico de orçamentos". | 4.05, 4.06 | Marcar "Ordens de serviço" e usar "Atendimento › Ordens de serviço › OS-0184" (UX-01) |
| W-10 | Os status não seguem o ciclo do IFML-04 (aberta → em execução → concluída): as telas usam "aprovado", "em execução", "concluído" no filtro e "finalizado" na etiqueta. A tela 4.08 mostra OS finalizadas com o título "Ordens de serviço em execução". | 4.01 a 4.08 | Padronizar os nomes e corrigir o título de 4.08 (UX-03) |
| W-11 | A lista 4.02 mostra números de orçamento (ORC-…) no lugar de números de OS. | 4.02 | Trocar pelos números de OS |
| W-12 | Finalizar a OS (4.05) e concluir o serviço do box (8.02) são duas ações para o mesmo evento. | 4.05, 8.02 | Decidir se as duas telas executam a mesma ação e registrar isso no IFML |

## Veja também

- [Wireframes: todas as áreas](../../README.md)
- [Índice das telas](<../0 - Índice.md>)
- [Site map](../../../site-map.md)
- [Protótipo: revisão de usabilidade e pendências](../../../README.md)
- [IFML](../../../ifml/README.md)
- [Histórias de usuário](../../../../03-requisitos/historias-de-usuario.md)
