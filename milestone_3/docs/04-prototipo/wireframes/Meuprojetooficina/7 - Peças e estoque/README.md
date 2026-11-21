# Wireframes: Peças e estoque e distribuidoras

Fábrica de Software I · Protótipo em alta fidelidade · Desktop 1440×900 · Perfil Estoquista

Esta pasta reúne as telas do estoque em quatro grupos: as telas de peças ligadas às histórias US-019 a US-024, as telas de peças organizadas por marca e modelo de carro, as telas de distribuidoras e a versão anterior das telas de peças, mantida como registro do redesenho. A navegação das telas de peças está modelada no [IFML-07](../../../ifml/README.md#ifml-07-peças-e-estoque); as distribuidoras ainda não têm modelo.

## Telas

| Nº | Tela | Estado | US | UC |
|---|---|---|---|---|
| [7.01](<7.01 - Peças e estoque - listagem (US-023).svg>) | Peças e estoque | Listagem | US-023, US-024 | Nenhum |
| [7.02](<7.02 - Peças e estoque - filtro aplicado (US-023).svg>) | Peças e estoque | Filtro aplicado | US-023 | Nenhum |
| [7.03](<7.03 - Peças e estoque - sem resultados (US-023).svg>) | Peças e estoque | Sem resultados | US-023 | Nenhum |
| [7.04](<7.04 - Cadastrar peça (US-019).svg>) | Cadastrar peça | Padrão | US-019 | UC-017 |
| [7.05](<7.05 - Peça cadastrada com sucesso (US-019).svg>) | Peça cadastrada com sucesso | Sucesso | US-019 | UC-017 |
| [7.06](<7.06 - Detalhes da peça (US-020).svg>) | Detalhes da peça | Padrão | US-020, US-024 | UC-021 |
| [7.07](<7.07 - Editar peça (US-021).svg>) | Editar peça | Padrão | US-021 | UC-022 |
| [7.08](<7.08 - Peça atualizada com sucesso (US-021).svg>) | Peça atualizada com sucesso | Sucesso | US-021 | UC-022 |
| [7.09](<7.09 - Excluir peça - confirmação (US-022).svg>) | Excluir peça | Confirmação | US-022 | Nenhum |
| [7.10](<7.10 - Peça excluída com sucesso (US-022).svg>) | Peça excluída com sucesso | Sucesso | US-022 | Nenhum |
| [7.11](<7.11 - Alerta de estoque baixo (US-024).svg>) | Alertas de estoque | Padrão | US-024 | Nenhum |
| [7.12](<7.12 - Listagem de peças por marca e modelo - tela principal.svg>) | Peças por marca e modelo | Tela principal | Sem US | — |
| [7.13](<7.13 - Filtro por marca - menu aberto.svg>) | Filtro por marca | Menu aberto | Sem US | — |
| [7.14](<7.14 - Filtrado para Chevrolet.svg>) | Filtrado para Chevrolet | Resultado | Sem US | — |
| [7.15](<7.15 - Filtro por modelo - menu aberto.svg>) | Filtro por modelo | Menu aberto | Sem US | — |
| [7.16](<7.16 - Filtrado para Onix.svg>) | Filtrado para Onix | Resultado | Sem US | — |
| [7.17](<7.17 - Filtrado para Onix - cópia.svg>) | Filtrado para Onix | Cópia | Sem US | — |
| [7.18](<7.18 - Cadastro de peça com distribuidora.svg>) | Cadastro de peça com distribuidora | Padrão | Sem US | — |
| [7.19](<7.19 - Informações da peça com distribuidoras.svg>) | Informações da peça com distribuidoras | Padrão | Sem US | — |
| [7.20](<7.20 - Atualização cadastral da peça.svg>) | Atualização cadastral da peça | Padrão | Sem US | — |
| [7.21](<7.21 - Distribuidoras - listagem.svg>) | Distribuidoras | Listagem | Sem US | — |
| [7.22](<7.22 - Distribuidoras - cadastro.svg>) | Distribuidoras | Cadastro | Sem US | — |
| [7.23](<7.23 - Distribuidoras - cadastro com informações conflitantes.svg>) | Distribuidoras | Informações conflitantes | Sem US | — |
| [7.24](<7.24 - Distribuidoras - cadastrada com sucesso.svg>) | Distribuidoras | Cadastrada com sucesso | Sem US | — |
| [7.25](<7.25 - Distribuidoras - ver informações.svg>) | Distribuidoras | Ver informações | Sem US | — |
| [7.26](<7.26 - Distribuidoras - atualização cadastral.svg>) | Distribuidoras | Atualização cadastral | Sem US | — |
| [7.27](<7.27 - Versão anterior - Peças e estoque listagem.svg>) | Versão anterior: Peças e estoque | Listagem | US-023 | Nenhum |
| [7.28](<7.28 - Versão anterior - Cadastrar peça (US-019).svg>) | Versão anterior: Cadastrar peça | Padrão | US-019 | UC-017 |
| [7.29](<7.29 - Versão anterior - Detalhes da peça (US-020).svg>) | Versão anterior: Detalhes da peça | Padrão | US-020 | UC-021 |
| [7.30](<7.30 - Versão anterior - Editar peça (US-021).svg>) | Versão anterior: Editar peça | Padrão | US-021 | UC-022 |
| [7.31](<7.31 - Versão anterior - Excluir peça (US-022).svg>) | Versão anterior: Excluir peça | Confirmação | US-022 | Nenhum |

Os casos de uso (UC) reproduzem os vínculos registrados nas issues do GitLab, conforme o índice de [historias-de-usuario.md](../../../../03-requisitos/historias-de-usuario.md#índice).

## Peças: lista, cadastro, detalhe, edição, exclusão e alertas

Telas ligadas às histórias US-019 a US-024. A lista mostra a situação de cada peça em relação ao estoque mínimo.

**7.01 · Peças e estoque · Listagem**

![Lista de peças com código, nome, categoria, fornecedor, quantidade, mínimo, valor unitário e situação (disponível, estoque baixo, esgotado), busca e filtros por categoria, fornecedor e situação](<7.01 - Peças e estoque - listagem (US-023).svg>)

**7.02 · Peças e estoque · Filtro aplicado**

![Lista filtrada pela busca pastilha e pela categoria Freios, com duas peças encontradas e os filtros ativos](<7.02 - Peças e estoque - filtro aplicado (US-023).svg>)

**7.03 · Peças e estoque · Sem resultados**

![Lista sem resultados com a mensagem Nenhuma peça encontrada e os botões Limpar filtros e Cadastrar peça](<7.03 - Peças e estoque - sem resultados (US-023).svg>)

**7.04 · Cadastrar peça**

![Formulário de cadastro de peça com nome, tipo, marca e modelo do carro e a seção distribuidora com quantidade, preço de compra e preço de venda](<7.04 - Cadastrar peça (US-019).svg>)

**7.05 · Peça cadastrada com sucesso · Sucesso**

![Confirmação Peça cadastrada com sucesso para a peça YZ-123, com tipo, distribuidora e quantidade, e os botões Voltar ao estoque e Cadastrar outra peça](<7.05 - Peça cadastrada com sucesso (US-019).svg>)

**7.06 · Detalhes da peça**

![Detalhes da Pastilha de freio traseira com aviso de estoque abaixo do mínimo, informações da peça e nível de estoque, e os botões Voltar ao estoque, Editar peça e Excluir peça](<7.06 - Detalhes da peça (US-020).svg>)

**7.07 · Editar peça**

![Formulário de edição da peça PF-2264 com dados preenchidos, resumo da peça e explicação do alerta de estoque baixo](<7.07 - Editar peça (US-021).svg>)

**7.08 · Peça atualizada com sucesso · Sucesso**

![Confirmação Peça atualizada com sucesso, com os botões Ver detalhes da peça e Voltar ao estoque](<7.08 - Peça atualizada com sucesso (US-021).svg>)

**7.09 · Excluir peça · Confirmação**

![Diálogo Excluir esta peça sobre o detalhe da peça, com os botões Cancelar e Excluir peça](<7.09 - Excluir peça - confirmação (US-022).svg>)

**7.10 · Peça excluída com sucesso · Sucesso**

![Confirmação Peça excluída com sucesso, com o botão Voltar ao estoque](<7.10 - Peça excluída com sucesso (US-022).svg>)

**7.11 · Alertas de estoque**

![Tela Alertas de estoque com os indicadores esgotadas, abaixo do mínimo e total em alerta, e a lista de peças com nível de estoque e o botão Repor estoque](<7.11 - Alerta de estoque baixo (US-024).svg>)

## Peças por marca e modelo, com distribuidoras

Telas sem história registrada. Cada peça indica a marca e o modelo do carro e pode ter mais de uma distribuidora, com preço de compra e de venda.

**7.12 · Peças por marca e modelo · Tela principal**

![Lista de peças com nome, tipo, distribuidora e quantidade em estoque, com filtros por marca e por modelo e botão Nova peça](<7.12 - Listagem de peças por marca e modelo - tela principal.svg>)

**7.13 · Filtro por marca · Menu aberto**

![Lista de peças com o menu de marcas aberto: Chevrolet, Ford, Fiat e Volkswagen](<7.13 - Filtro por marca - menu aberto.svg>)

**7.14 · Filtrado para Chevrolet · Resultado**

![Lista de peças filtrada pela marca Chevrolet](<7.14 - Filtrado para Chevrolet.svg>)

**7.15 · Filtro por modelo · Menu aberto**

![Lista de peças com o menu de modelos aberto: Onix, Spin, Tracker e Montana](<7.15 - Filtro por modelo - menu aberto.svg>)

**7.16 · Filtrado para Onix · Resultado**

![Lista de peças filtrada pela marca Chevrolet e pelo modelo Onix](<7.16 - Filtrado para Onix.svg>)

**7.17 · Filtrado para Onix · Cópia**

![Cópia da tela 7.16](<7.17 - Filtrado para Onix - cópia.svg>)

**7.18 · Cadastro de peça com distribuidora**

![Formulário de cadastro de peça com a seção distribuidora e o botão para adicionar outra distribuidora](<7.18 - Cadastro de peça com distribuidora.svg>)

**7.19 · Informações da peça com distribuidoras**

![Informações da peça YZ-123 com a tabela de distribuidoras, preços de compra e de venda e datas](<7.19 - Informações da peça com distribuidoras.svg>)

**7.20 · Atualização cadastral da peça**

![Formulário de atualização da peça com a tabela de distribuidoras vinculadas e a ação de remover](<7.20 - Atualização cadastral da peça.svg>)

## Distribuidoras

Telas sem história registrada.

**7.21 · Distribuidoras · Listagem**

![Lista de distribuidoras com contato e data do último pedido, busca e botão Nova distribuidora](<7.21 - Distribuidoras - listagem.svg>)

**7.22 · Distribuidoras · Cadastro**

![Formulário de cadastro de distribuidora com identificação e contato e endereço](<7.22 - Distribuidoras - cadastro.svg>)

**7.23 · Distribuidoras · Informações conflitantes**

![Formulário de cadastro de distribuidora com os erros CNPJ já cadastrado, telefone já cadastrado e e-mail já cadastrado](<7.23 - Distribuidoras - cadastro com informações conflitantes.svg>)

**7.24 · Distribuidoras · Cadastrada com sucesso**

![Confirmação Distribuidora cadastrada com sucesso, com os botões Voltar à listagem e Ver distribuidora](<7.24 - Distribuidoras - cadastrada com sucesso.svg>)

**7.25 · Distribuidoras · Ver informações**

![Informações da Distribuidora Nez com identificação, contato e endereço, e os botões Contatar e Editar cadastro](<7.25 - Distribuidoras - ver informações.svg>)

**7.26 · Distribuidoras · Atualização cadastral**

![Formulário de atualização da distribuidora com os dados atuais preenchidos](<7.26 - Distribuidoras - atualização cadastral.svg>)

## Versão anterior

Telas substituídas pelo redesenho. Ficam na pasta como registro e não fazem parte do site map.

**7.27 · Versão anterior: Peças e estoque · Listagem**

![Versão anterior da lista de peças, com filtros laterais, ações rápidas e movimentações das últimas 24 horas](<7.27 - Versão anterior - Peças e estoque listagem.svg>)

**7.28 · Versão anterior: Cadastrar peça**

![Versão anterior do cadastro de peça, com foto da peça e resumo](<7.28 - Versão anterior - Cadastrar peça (US-019).svg>)

**7.29 · Versão anterior: Detalhes da peça**

![Versão anterior dos detalhes da peça, com as movimentações recentes](<7.29 - Versão anterior - Detalhes da peça (US-020).svg>)

**7.30 · Versão anterior: Editar peça**

![Versão anterior da edição da peça, com as últimas alterações](<7.30 - Versão anterior - Editar peça (US-021).svg>)

**7.31 · Versão anterior: Excluir peça · Confirmação**

![Versão anterior do diálogo de exclusão, com o aviso de que o histórico da peça é mantido](<7.31 - Versão anterior - Excluir peça (US-022).svg>)

## Regras de comportamento

Cada linha é um cenário Gherkin das histórias da área. A coluna Situação indica se o wireframe mostra o comportamento: **Desenhado**, **Parcial** (a tela existe, mas falta parte do cenário), **Não desenhado** ou **Divergente** (a tela contradiz o cenário). Cenários marcados `@proposta` foram escritos pela equipe de documentação e ainda não estão nas issues.

| Cenário | US | Telas | Situação | Observação |
|---|---|---|---|---|
| Cadastro com dados válidos `@proposta` | US-019 | 7.04 → 7.05 | Parcial | O formulário não tem código, categoria nem estoque mínimo; o fornecedor aparece como distribuidora |
| Código já cadastrado `@proposta` | US-019 | — | Não desenhado |  |
| Quantidade negativa `@proposta` | US-019 | — | Não desenhado |  |
| Abrir os detalhes de uma peça `@proposta` | US-020 | 7.06 | Parcial | Todos os campos aparecem, mas o histórico de alterações não; a versão anterior (7.29) o mostrava |
| Reajuste de preço `@proposta` | US-021 | 7.07 → 7.08 | Parcial | A edição não mostra o valor anterior nem registra quem alterou |
| Código de outra peça `@proposta` | US-021 | — | Não desenhado |  |
| Excluir peça já usada em OS antiga `@proposta` | US-022 | 7.09 → 7.10 | Parcial | O diálogo diz que a ação não pode ser desfeita, mas não informa que as OS antigas continuam mostrando a peça; a versão anterior (7.31) informava |
| Combinar categoria e nome `@proposta` | US-023 | 7.02 | Desenhado | Busca "pastilha" com a categoria Freios |
| Filtro sem resultado `@proposta` | US-023 | 7.03 | Desenhado |  |
| Quantidade chega ao mínimo `@proposta` | US-024 | 7.01, 7.06, 7.11 | Desenhado | Etiqueta "Estoque baixo", aviso no detalhe e tela de alertas |
| Quantidade acima do mínimo `@proposta` | US-024 | 7.01 | Desenhado | Etiqueta "Disponível" |

## Divergências e achados

| ID | Divergência | Telas | Tratamento proposto |
|---|---|---|---|
| W-20 | Há dois modelos de peça em uso ao mesmo tempo. As telas 7.01 a 7.11 usam código, categoria, um fornecedor e estoque mínimo; as telas 7.04 e 7.12 a 7.20 usam tipo, marca e modelo do carro e várias distribuidoras, sem código nem mínimo. | 7.01 a 7.20 | Decidir qual modelo vale e alinhar as telas, as histórias e o banco de dados |
| W-21 | As telas de peças por marca e modelo e as de distribuidoras não têm história de usuário. | 7.12 a 7.26 | Registrar as histórias e substituir "US-xxx" nos quadros do Figma (SM-04) |
| W-22 | A área Distribuidoras não aparece no menu lateral; nas suas telas, o item ativo do menu é "Ordem de serviço" ou "Clientes", e a lista de peças filtrada mostra "Distribuidoras" no breadcrumb. | 7.14 a 7.17, 7.21 a 7.26 | Incluir "Distribuidoras" no menu do estoquista e corrigir o item ativo e o breadcrumb (UX-01, UX-05) |
| W-23 | O detalhe da distribuidora usa os rótulos "Nome completo" e "CPF", copiados do cliente, para a razão social e o CNPJ; o telefone está como "(00) 00000-0000". | 7.25 | Trocar por "Razão social" e "CNPJ" e usar um telefone plausível |
| W-24 | A tela 7.17 é cópia da 7.16. | 7.17 | Remover da pasta e do Figma (PN-05) |
| W-25 | As telas novas de peças mostram o usuário do almoxarifado com o menu completo da secretária. | 7.04, 7.12 a 7.20 | Desenhar o menu do estoquista (SM-05) |

## Veja também

- [Wireframes: todas as áreas](../../README.md)
- [Índice das telas](<../0 - Índice.md>)
- [Site map](../../../site-map.md)
- [Protótipo: revisão de usabilidade e pendências](../../../README.md)
- [IFML](../../../ifml/README.md)
- [Histórias de usuário](../../../../03-requisitos/historias-de-usuario.md)
