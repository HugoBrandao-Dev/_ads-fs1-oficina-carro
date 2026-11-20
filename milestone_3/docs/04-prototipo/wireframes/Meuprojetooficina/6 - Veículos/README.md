# Wireframes: Veículos e histórico do veículo

Fábrica de Software I · Protótipo em alta fidelidade · Desktop 1440×900 · Perfil Secretária

Estes wireframes cobrem duas áreas do site map ligadas ao veículo: o cadastro de carros (lista, cadastro, informações e atualização) e a consulta do histórico pela placa. A navegação está modelada no [IFML-03](../../../ifml/README.md#ifml-03-veículos) e no [IFML-06](../../../ifml/README.md#ifml-06-histórico-do-veículo).

## Telas

| Nº | Tela | Estado | US | UC |
|---|---|---|---|---|
| [6.01](<6.01 - Lista de carros (US-011).svg>) | Lista de carros | Padrão | US-011 | UC-008 |
| [6.02](<6.02 - Cadastro de carro (US-006).svg>) | Cadastro de carro | Padrão | US-006 | UC-004 |
| [6.03](<6.03 - Confirmação - carro cadastrado.svg>) | Confirmação: carro cadastrado | Sucesso | US-006 | UC-004 |
| [6.04](<6.04 - Lista de carros - com novo carro.svg>) | Lista de carros | Com o novo carro | US-011 | UC-008 |
| [6.05](<6.05 - Informações do carro (US-014).svg>) | Informações do carro | Padrão | US-014 | UC-012 |
| [6.06](<6.06 - Atualização cadastral do carro (US-007).svg>) | Atualização cadastral do carro | Padrão | US-007 | UC-005 |
| [6.07](<6.07 - Histórico do veículo - estado inicial (US-029).svg>) | Histórico do veículo | Estado inicial | US-029, US-030 | Nenhum |
| [6.08](<6.08 - Histórico do veículo - placa não encontrada (US-029).svg>) | Histórico do veículo | Placa não encontrada | US-029 | Nenhum |
| [6.09](<6.09 - Histórico do veículo - sem histórico (US-029).svg>) | Histórico do veículo | Sem histórico | US-029 | Nenhum |
| [6.10](<6.10 - Histórico do veículo - veículo encontrado (US-029).svg>) | Histórico do veículo | Veículo encontrado | US-029 | Nenhum |
| [6.11](<6.11 - Histórico do veículo - detalhe da OS (US-029).svg>) | Histórico do veículo | Detalhe da OS | US-029 | Nenhum |

Os casos de uso (UC) reproduzem os vínculos registrados nas issues do GitLab, conforme o índice de [historias-de-usuario.md](../../../../03-requisitos/historias-de-usuario.md#índice).

## Lista de carros

**6.01 · Lista de carros**

![Lista de carros em cartões com placa, marca e modelo e o botão Acessar perfil, com busca por placa ou modelo e botão Novo veículo](<6.01 - Lista de carros (US-011).svg>)

**6.04 · Lista de carros · Com o novo carro**

![Lista de carros com o Honda Civic placa ABC-1234 no topo](<6.04 - Lista de carros - com novo carro.svg>)

## Cadastrar carro

**6.02 · Cadastro de carro**

![Formulário de cadastro de carro com marca, modelo, cor, ano, placa e CPF do cliente](<6.02 - Cadastro de carro (US-006).svg>)

**6.03 · Confirmação: carro cadastrado · Sucesso**

![Janela de confirmação Carro cadastrado com sucesso, com o código ORC-1043 e o botão Voltar ao histórico](<6.03 - Confirmação - carro cadastrado.svg>)

## Informações e atualização do carro

**6.05 · Informações do carro**

![Informações do carro com marca, modelo, cor, ano, placa e clientes vinculados, botão Editar informações e tabela de atendimentos com valor, retirada e status](<6.05 - Informações do carro (US-014).svg>)

**6.06 · Atualização cadastral do carro**

![Formulário de atualização do carro com marca, modelo, cor, ano, placa e CPF do cliente, e os botões Atualizar e Salvar alterações](<6.06 - Atualização cadastral do carro (US-007).svg>)

## Histórico do veículo

A consulta tem quatro estados: inicial, placa não encontrada, veículo sem histórico e veículo encontrado. A última tela expande uma OS da lista.

**6.07 · Histórico do veículo · Estado inicial**

![Histórico do veículo com o campo de placa vazio, exemplo de formato e a mensagem Nenhuma consulta realizada](<6.07 - Histórico do veículo - estado inicial (US-029).svg>)

**6.08 · Histórico do veículo · Placa não encontrada**

![Consulta pela placa RTA9Z99 com o aviso Placa não encontrada e a orientação de conferir o número ou cadastrar o veículo](<6.08 - Histórico do veículo - placa não encontrada (US-029).svg>)

**6.09 · Histórico do veículo · Sem histórico**

![Consulta pela placa QNY7A42 com o veículo encontrado e a mensagem Nenhum atendimento registrado](<6.09 - Histórico do veículo - sem histórico (US-029).svg>)

**6.10 · Histórico do veículo · Veículo encontrado**

![Consulta pela placa RTA4C21 com o Fiat Strada Freedom 1.3, última quilometragem, total de atendimentos, último atendimento e a lista de ordens de serviço vinculadas](<6.10 - Histórico do veículo - veículo encontrado (US-029).svg>)

**6.11 · Histórico do veículo · Detalhe da OS**

![Histórico do veículo com a OS-2026-0418 expandida: problema relatado, serviços executados, peças utilizadas e mecânico responsável](<6.11 - Histórico do veículo - detalhe da OS (US-029).svg>)

## Regras de comportamento

Cada linha é um cenário Gherkin das histórias da área. A coluna Situação indica se o wireframe mostra o comportamento: **Desenhado**, **Parcial** (a tela existe, mas falta parte do cenário), **Não desenhado** ou **Divergente** (a tela contradiz o cenário). Cenários marcados `@proposta` foram escritos pela equipe de documentação e ainda não estão nas issues.

| Cenário | US | Telas | Situação | Observação |
|---|---|---|---|---|
| Cadastro com placa nova | US-006 | 6.02 → 6.03 → 6.04 | Desenhado | A confirmação 6.03 tem conteúdo copiado do orçamento (W-17) |
| Placa já cadastrada | US-006 | — | Não desenhado |  |
| Atualização com dados válidos | US-007 | 6.06 | Parcial | O formulário abre vazio e não há confirmação (W-18) |
| Placa já cadastrada em outro veículo | US-007 | — | Não desenhado |  |
| Abrir a lista de carros | US-011 | 6.01 | Desenhado | O perfil do carro dá acesso à atualização |
| Abrir as informações de um carro | US-014 | 6.05 | Desenhado | Botão "Editar informações" |
| Placa cadastrada | US-029 | 6.10, 6.11 | Desenhado | Modelo, proprietário, cliente desde, quilometragem, total de atendimentos, último atendimento e OS da mais recente para a mais antiga |
| Placa não cadastrada | US-029 | 6.08 | Desenhado | A orientação aparece em texto, sem botão para cadastrar (UX-08) |
| Placa em branco | US-029 | — | Não desenhado |  |
| Primeira abertura da tela | US-030 | 6.07 | Desenhado | Exemplo "Ex.: ABC1D23" e mensagem "Nenhuma consulta realizada" |
| Limpar a placa após uma consulta | US-030 | 6.07 | Desenhado | A tela volta ao estado inicial |

O estado "sem histórico" (6.09) não tem cenário na US-029, mas completa os estados da consulta.

## Divergências e achados

| ID | Divergência | Telas | Tratamento proposto |
|---|---|---|---|
| W-17 | A confirmação de carro cadastrado mostra o código ORC-1043, o botão "Voltar ao histórico" e o breadcrumb de orçamentos. | 6.03 | Mostrar a placa e os botões "Ver carro" e "Voltar à listagem" (UX-02) |
| W-18 | A atualização do carro abre com os campos vazios, usa o CPF fictício "111.111.111-11" e tem duas ações principais. | 6.06 | Abrir com os dados atuais e manter só "Salvar alterações" (UX-04) |
| W-19 | O site map chama a área de "Carros"; o menu lateral e a pasta usam "Veículos". | 6.01 a 6.11 | Adotar um único nome no site map, no menu e na documentação |

## Veja também

- [Wireframes: todas as áreas](../../README.md)
- [Índice das telas](<../0 - Índice.md>)
- [Site map](../../../site-map.md)
- [Protótipo: revisão de usabilidade e pendências](../../../README.md)
- [IFML](../../../ifml/README.md)
- [Histórias de usuário](../../../../03-requisitos/historias-de-usuario.md)
