# Wireframes: Clientes

Fábrica de Software I · Protótipo em alta fidelidade · Desktop 1440×900 · Perfil Secretária

Estes wireframes mostram o cadastro de clientes: a lista com busca, o cadastro com validação dos dados, o perfil com os veículos vinculados e a atualização cadastral. A navegação está modelada no [IFML-02](../../../ifml/README.md#ifml-02-clientes).

## Telas

| Nº | Tela | Estado | US | UC |
|---|---|---|---|---|
| [5.01](<5.01 - Lista de clientes.svg>) | Lista de clientes | Padrão | US-010, US-005 | UC-003 |
| [5.02](<5.02 - Cadastro de cliente (US-003).svg>) | Cadastro de cliente | Padrão | US-003 | UC-001 |
| [5.03](<5.03 - Cadastro de cliente - informações conflitantes (US-003).svg>) | Cadastro de cliente | Informações conflitantes | US-003 | UC-001 |
| [5.04](<5.04 - Cliente cadastrado com sucesso (US-003).svg>) | Cliente cadastrado com sucesso | Sucesso | US-003 | UC-001 |
| [5.05](<5.05 - Lista de clientes - com novo cliente.svg>) | Lista de clientes | Com o novo cliente | US-010 | UC-003 |
| [5.06](<5.06 - Perfil do cliente.svg>) | Perfil do cliente | Padrão | US-013 | UC-011 |
| [5.07](<5.07 - Editar cadastro do cliente (US-004).svg>) | Editar cadastro do cliente | Padrão | US-004 | UC-002 |
| [5.08](<5.08 - Editar cadastro do cliente - variante (US-004).svg>) | Editar cadastro do cliente | Variante | US-004 | UC-002 |
| [5.09](<5.09 - Cadastro atualizado com sucesso (US-004).svg>) | Cadastro atualizado com sucesso | Sucesso | US-004 | UC-002 |

Os casos de uso (UC) reproduzem os vínculos registrados nas issues do GitLab, conforme o índice de [historias-de-usuario.md](../../../../03-requisitos/historias-de-usuario.md#índice).

## Lista de clientes

**5.01 · Lista de clientes**

![Lista de clientes em cartões com nome, CPF, telefone, veículos cadastrados, última visita, situação e botão Acessar perfil, com busca por nome ou CPF e botão Novo cliente](<5.01 - Lista de clientes.svg>)

**5.05 · Lista de clientes · Com o novo cliente**

![Lista de clientes com Antônio Ribeiro Sales no topo](<5.05 - Lista de clientes - com novo cliente.svg>)

## Cadastrar cliente

**5.02 · Cadastro de cliente**

![Formulário de cadastro de cliente com identificação e contato (nome, CPF, nascimento, telefone, e-mail, contato preferido) e endereço com CEP, número, logradouro, complemento, bairro e observações](<5.02 - Cadastro de cliente (US-003).svg>)

**5.03 · Cadastro de cliente · Informações conflitantes**

![Formulário de cadastro com mensagens de erro sob os campos: CPF já cadastrado, usuário menor de idade, telefone já cadastrado e e-mail já cadastrado](<5.03 - Cadastro de cliente - informações conflitantes (US-003).svg>)

**5.04 · Cliente cadastrado com sucesso · Sucesso**

![Confirmação Cliente cadastrado com sucesso, com os botões Voltar à listagem e Ver perfil do cliente](<5.04 - Cliente cadastrado com sucesso (US-003).svg>)

## Perfil do cliente

**5.06 · Perfil do cliente**

![Perfil de Antônio Ribeiro Sales com abas, dados cadastrais, endereço, veículos do cliente e últimas ordens de serviço, e os botões Abrir atendimento e Editar cadastro](<5.06 - Perfil do cliente.svg>)

## Atualizar o cadastro

Nome e CPF exigem justificativa; o CPF fica bloqueado porque identifica o cliente. Cada campo alterado recebe a marca "alterado" e mostra o valor anterior.

**5.07 · Editar cadastro do cliente**

![Edição do cadastro com os dados atuais preenchidos, CPF bloqueado e os campos alterados marcados, com o valor anterior do telefone](<5.07 - Editar cadastro do cliente (US-004).svg>)

**5.08 · Editar cadastro do cliente · Variante**

![Variante da edição do cadastro, com o breadcrumb Clientes, Cliente, Antônio Ribeiro Sales, Editando](<5.08 - Editar cadastro do cliente - variante (US-004).svg>)

**5.09 · Cadastro atualizado com sucesso · Sucesso**

![Confirmação Cadastro atualizado com sucesso, com os botões Voltar à listagem e Ver perfil do cliente](<5.09 - Cadastro atualizado com sucesso (US-004).svg>)

## Regras de comportamento

Cada linha é um cenário Gherkin das histórias da área. A coluna Situação indica se o wireframe mostra o comportamento: **Desenhado**, **Parcial** (a tela existe, mas falta parte do cenário), **Não desenhado** ou **Divergente** (a tela contradiz o cenário). Cenários marcados `@proposta` foram escritos pela equipe de documentação e ainda não estão nas issues.

| Cenário | US | Telas | Situação | Observação |
|---|---|---|---|---|
| Cadastro com dados válidos | US-003 | 5.02 → 5.04 → 5.05 | Desenhado |  |
| CPF já cadastrado | US-003 | 5.03 | Desenhado | A tela também valida telefone, e-mail e idade mínima |
| Atualização de dados desatualizados | US-004 | 5.07 → 5.09 | Desenhado |  |
| CPF já cadastrado para outro cliente | US-004 | 5.07, 5.08 | Divergente | O CPF fica bloqueado na edição, então o conflito não pode ocorrer |
| Busca pelo nome do cliente | US-005 | 5.01 | Parcial | Há o campo de busca, mas não o resultado de uma busca |
| Abrir a lista de clientes | US-010 | 5.01 | Desenhado | O perfil dá acesso à atualização |
| Abrir o perfil de um cliente | US-013 | 5.06 | Desenhado | Mostra os veículos vinculados e o botão "Editar cadastro" |

## Divergências e achados

| ID | Divergência | Telas | Tratamento proposto |
|---|---|---|---|
| W-13 | O nome original do quadro 5.08 ("CPF já cadastrado") não corresponde ao conteúdo, que repete a edição com outro breadcrumb. | 5.08 | Desenhar o aviso de conflito ou registrar na US-004 que o CPF não é editável |
| W-14 | Os cartões da lista usam uma foto genérica, sem história que a peça. | 5.01, 5.05 | Remover a imagem ou trocar os cartões por tabela (UX-07) |
| W-15 | O par "Atendimento em curso" e "Cancelar" no cabeçalho da lista não diz o que é cancelado. | 5.01, 5.05 | Ver UX-06 |
| W-16 | O botão "Abrir atendimento" do perfil não tem história de usuário. | 5.06 | Registrar a história ou retirar o botão |

## Veja também

- [Wireframes: todas as áreas](../../README.md)
- [Índice das telas](<../0 - Índice.md>)
- [Site map](../../../site-map.md)
- [Protótipo: revisão de usabilidade e pendências](../../../README.md)
- [IFML](../../../ifml/README.md)
- [Histórias de usuário](../../../../03-requisitos/historias-de-usuario.md)
