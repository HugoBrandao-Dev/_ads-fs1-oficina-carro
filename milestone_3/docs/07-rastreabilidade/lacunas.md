# Lacunas e órfãos de rastreabilidade

Milestone 3 · Fábrica de Software I · Unidade de rastreabilidade

Responde às quatro perguntas da revisão cruzada (UML × protótipo × requisitos), lista os órfãos nos dois sentidos e registra cada lacuna com ação e prazo. A tabela base está em [matriz.md](matriz.md). As fontes conferidas em 15/11/2026 foram as issues do GitLab ([projeto2](https://gitlab.fslab.dev/fabrica-de-software-i-2026/projeto2)), o arquivo do Figma "Gestão de Oficina Mecânica" e o banco do Milestone 2 (`milestone_2/ddl.sql`). As lacunas ainda não têm issue aberta; os prazos são sugeridos para antes da monitoria do Milestone 3 (01/12/2026).

## Resumo das quatro perguntas

| Pergunta | Resposta | Situação |
|---|---|---|
| Toda US tem UC? | Não. 14 das 30 histórias têm caso de uso; três vínculos do GitLab apontam para a história errada. | Não |
| Todo dado do wireframe existe em classe? | Quase todos. Seis dados de tela não têm atributo, e duas telas contradizem o requisito. | Parcial |
| Todo cenário principal tem sequência? | Não. 16 dos 23 casos de uso têm diagrama; os de peças, distribuidoras e relatórios, não. RF-03 e RF-04 não têm caso de uso nem sequência. | Não |
| Toda classe com status tem máquina de estados? | Em parte. OrdemServico tem DE-001; Orcamento tem DE-003, mas o DE-002 está vazio; Box não tem diagrama. | Parcial |

## 1. Órfãos

### 1.1 Histórias sem elo

| Elo ausente | Histórias | Qtde |
|---|---|---|
| Caso de uso | US-001, US-005, US-008, US-009, US-012, US-015, US-017, US-018, US-022, US-023, US-024, US-026, US-027, US-029, US-030, #42 | 16 |
| Sequência | US-001, US-005, US-008, US-009, US-018, US-019 a US-024, US-026, US-027, US-029, US-030, #42 | 16 |
| Atividade ou estado | US-001, US-005, US-008, US-009, US-015, US-016, US-018, US-019 a US-024, US-026, US-027, US-029, US-030, #42 | 18 |
| Tela | US-002, US-008, US-009, US-027 | 4 |
| Teste | Todas | 30 |

A RF-07 também não tem sequência nem atividade. Ela entra na contagem da [matriz](matriz.md#cobertura-da-cadeia), que tem 31 linhas.

### 1.2 Itens sem requisito (sentido inverso)

| Item | Onde está | Situação |
|---|---|---|
| Distribuidoras | Classes `Distribuidora` e `PecaDistribuidora`; UC-015, UC-016, UC-018, UC-019; DS-010, DS-011, DA-009, DA-010; seis telas "US-xxx"; tabelas `distribuidora` e `peca_distribuidora` | Lacuna L-17: modelado de ponta a ponta, sem história |
| Atualizar informações do orçamento | DS-007 (`UC-000`) e DA-007 | Lacuna L-17: nenhuma história pede a edição do orçamento |
| Pagamento | Tabelas `pagamento` e `pagamento_parcelas`; card "Relatório de Faturamento" | Lacuna L-16: sem requisito e sem classe |
| Filtros como casos de uso | `<<extend>>` "Filtrar por nome do cliente", "por CPF", "por placa", "por modelo", "por data de criação do orçamento", "por fornecedor da peça" | Aceito: estendem casos de uso existentes. Só os filtros de orçamento por status (US-026) e de peças (US-023) têm história |
| Sete relatórios além da RF-07 | Tela "Relatórios - tela principal" (ocupação dos boxes, faturamento, peças, clientes, mecânicos, veículos, orçamentos) | Lacuna L-16: a RF-07 trata só do relatório de OS |
| "Esqueci a senha" e "Manter conectada" | Tela de login | Lacuna L-16: sem requisito |
| Classe `Endereco` e `Funcao` | Diagrama de classes | Aceito: aparecem nas telas de cliente e no cabeçalho (cargo do usuário) |

Todas as 19 classes do diagrama aparecem em pelo menos uma linha da matriz.

## 2. As quatro perguntas em detalhe

### 2.1 Toda US tem UC?

- Não: 14 das 30 histórias têm caso de uso registrado no GitLab.
- As 16 sem caso de uso estão na tabela 1.1. Entre elas estão a autenticação (US-001), o histórico do veículo (US-029, US-030), a agenda dos boxes (#42) e três histórias de estoque (US-022 a US-024). Lacuna L-01.
- Três vínculos apontam para a história errada: UC-009 e UC-010 (recusar e aprovar orçamento) e UC-014 (criar OS) citam a US-028, que trata do status da OS. UC-007 e UC-020 citam `US-000`, embora a US-026 e a US-023 tratem dessas listas. Lacuna L-02.
- Toda US tem RF? Sim: o título de cada história cita o RF de origem.

### 2.2 Todo dado do wireframe existe em classe?

Foram lidos os textos de 16 telas principais do protótipo: login, cadastro e detalhe de cliente e de veículo, montagem e visualização de orçamento, lista e detalhe de OS, agenda dos boxes (principal, designar e concluir), histórico do veículo, cadastro e detalhe de peça e relatórios. Botões, menu e textos de ajuda foram descartados. Cada dado foi procurado nas classes do diagrama de domínio.

Dados que existem nas classes: identificação e contato do cliente (`Pessoa`, `Cliente`, `Endereco`), placa, marca, modelo, cor, ano e quilometragem (`Veiculo`, `CarroModelo`, `CarroMarca`), valor e status do orçamento (`Orcamento`), status, mecânico e box da OS (`OrdemServico`, `Box`), código, preço, estoque e estoque mínimo da peça (`Peca`), compatibilidade com modelos (`Compatibilidade`), preço de compra (`PecaDistribuidora`) e matrícula do funcionário (`Funcionario`).

Dados de tela sem atributo de classe:

- **Formato do orçamento** ("Formato: Valor fixo", tela "Montar o orçamento"). `Orcamento` não tem o atributo; o banco tem `orca_formato`. O meio da resposta do cliente, exigido pela RF-02, também não tem atributo. Lacuna L-07.
- **Início da execução e tempo no box** ("Iniciado às 08:20 · 3h 05min no box", agenda dos boxes). `OrdemServico` tem `dataAbertura` e `dataConclusao`, mas não o início da execução; o banco tem `os_inicio`. Lacuna L-07.
- **Retirada do veículo** ("Retirado em", "Retirado por", detalhe do carro). Nenhuma classe guarda a retirada. Lacuna L-07.
- **Histórico de alterações** (aba do detalhe do cliente; pedido também na US-020 e na US-021 para a peça). Não há classe de histórico de cliente nem de peça. Lacuna L-07.
- **Situação ativa da peça** (exclusão lógica da US-022). `Peca` não tem `ativo`; o banco tem `peca_ativo`. Lacuna L-07.
- **Histórico de status do orçamento** (tela inicial de Orçamentos, US-018). Existe `HistoricoStatusOS`, mas não há classe equivalente para o orçamento; o banco tem `orcamento_historico`. Lacuna L-06.

Divergências entre tela e requisito:

- **Orçamento sem itens.** A tela "Montar o orçamento" registra um valor fixo. A RF-02, a US-016 e as classes `ItemOrcamentoPeca` e `ItemOrcamentoServico` pedem o orçamento item a item, com peças e mão de obra separadas. Lacuna L-10.
- **OS com status "Aprovada".** A lista de OS ("Status: em aprovada") e o componente "Badge (aprovada)" usam "Aprovada" para a OS. O ciclo decidido pelo grupo é `aberta → em execução → concluída`. Lacuna L-11.

Diferenças de nome: a tela e o banco usam "Categoria" da peça (`peca_categoria`), e a classe usa `tipo`; a tela e a classe usam "Matrícula", e o banco usa `func_login`. Lacuna L-15.

Resposta: parcial.

### 2.3 Todo cenário principal tem sequência?

| Casos de uso | Diagramas | Situação |
|---|---|---|
| UC-001 a UC-005, UC-008, UC-011, UC-012 (clientes e veículos) | DS-001, DS-005, DS-009, DS-002, DS-006, DS-014, DS-018, DS-015 | Sim |
| UC-006, UC-007, UC-009, UC-010 (orçamento) | DS-003, DS-016, DS-013, DS-012 | Sim. A issue DS-016 (#92) segue aberta, embora o diagrama exista no Figma |
| UC-013, UC-014 (OS) | DS-008, DS-004 | Sim |
| UC-015, UC-016 (distribuidora) | DS-010, DS-011 | Sim |
| UC-017, UC-020, UC-021, UC-022 (peças) | Nenhum | Não |
| UC-018, UC-019 (distribuidora) | Nenhum | Não |
| UC-023 (relatórios) | Nenhum | Não |
| RF-03 agenda dos boxes, RF-04 histórico do veículo | Nenhum, e sem caso de uso | Não |

Resultado: 16 dos 23 casos de uso têm diagrama. Há ainda quatro diagramas sem caso de uso no catálogo (DS-007, DS-017, DS-019 e DS-020). O DS-020 está desenhado no Figma sem título ("secr-fina-os"). Lacunas L-03 e L-04.

### 2.4 Toda classe com status tem máquina de estados?

| Classe | Atributo | Diagrama | Situação |
|---|---|---|---|
| OrdemServico | `status : StatusOS` | DE-001 · DS-008 Mudar status de uma OS | Coberta |
| Orcamento | `status : StatusOrcamento` | DE-003 (recusado), com conteúdo; DE-002 (aprovado), só com o título | Parcial. Lacuna L-05 |
| Box | `status : StatusBox` | Nenhum | Não. Lacuna L-13 |

`HistoricoStatusOS` guarda `statusAnterior` e `statusNovo`, mas é um registro de transição, não um objeto com ciclo de vida. Aceito sem diagrama.

Resposta: parcial.

## 3. Lacunas e ações

| ID | Elo | Lacuna | Ação | Prazo |
|---|---|---|---|---|
| L-01 | UC | 16 histórias sem caso de uso (tabela 1.1) | Criar casos de uso para autenticação, histórico do veículo, agenda dos boxes, exclusão e alerta de peças, ou registrar a história no UC existente mais próximo | 24/11/2026 |
| L-02 | UC | Vínculos UC → US incorretos (UC-007, UC-009, UC-010, UC-014, UC-020) | Corrigir o título das issues de caso de uso no GitLab | 20/11/2026 |
| L-03 | Sequência | UC-017 a UC-023 sem diagrama; RF-03 e RF-04 sem diagrama | Desenhar ao menos o cadastro de peça (UC-017), a designação de box (RF-03) e a consulta por placa (RF-04), que têm decisões no fluxo | 28/11/2026 |
| L-04 | Sequência | DS-020 sem título no Figma; issues DS-016 e DS-020 abertas | Dar o título `DS-020 \| UC-000 - Visualização das informações da OS` ao quadro e fechar as issues | 20/11/2026 |
| L-05 | Atividade e estado | DA-009 vazio e DE-002 só com título, com as issues fechadas; DA-004, DA-005 e DA-007 em branco | Desenhar os cinco diagramas; reabrir as issues #109 e #111 até a conclusão | 28/11/2026 |
| L-06 | Classe | Sem classe de histórico do orçamento (RF-02, US-018) | Incluir `HistoricoStatusOrcamento` no diagrama de classes, espelhando `HistoricoStatusOS` | 24/11/2026 |
| L-07 | Classe | Dados de tela sem atributo: formato e meio da resposta do orçamento, início da execução da OS, retirada do veículo, histórico de alterações de cliente e peça, peça ativa | Acrescentar os atributos às classes ou retirar os dados das telas | 24/11/2026 |
| L-08 | Tela | Telas sem identificador; "US-012" no quadro de relatórios; "US-xxx - RF-xx" em distribuidoras e na versão anterior de peças | Corrigir os nomes dos quadros conforme o RF e a história; avaliar um código `T-NN` por tela | 24/11/2026 |
| L-09 | Tela | US-002, US-008, US-009 e US-027 sem tela | Desenhar a retirada e o histórico de status da OS; decidir se US-008 e US-009 continuam válidas (D-07 de historias-de-usuario.md) | 28/11/2026 |
| L-10 | Regra | Tela de orçamento com valor fixo, sem itens de peças e mão de obra | Alinhar a tela à RF-02 ou registrar com o cliente que o orçamento é por valor fixo | 24/11/2026 |
| L-11 | Regra | Status "Aprovada" na lista de OS e no componente de badge | Trocar por `aberta` nas telas e no componente | 24/11/2026 |
| L-12 | Teste | Não há código nem testes; nenhum critério de aceite é verificado automaticamente | Registrar no backlog; quando houver aplicação, um teste por cenário Gherkin | Fora do Milestone 3 |
| L-13 | Estado | `Box` tem `status` sem máquina de estados | Desenhar o DE do box (livre ↔ ocupado) ou trocar o atributo por booleano | 28/11/2026 |
| L-14 | Ator | Telas com login de Almoxarifado e de Gerente; casos de uso com Estoquista e Gerente; premissa de um só perfil | Decidir com o cliente os perfis de login (pergunta 8 da RFP) e alinhar telas, atores e histórias | 24/11/2026 |
| L-15 | Nome | `Peca.tipo` × "Categoria"; `matricula` × `func_login` | Escolher um termo para cada caso e corrigir classe, tela ou banco | 24/11/2026 |
| L-16 | Escopo | Pagamento, sete relatórios e funções do login sem requisito | Criar requisito ou retirar do protótipo e do banco | 24/11/2026 |
| L-17 | Requisito | Distribuidoras e edição de orçamento modeladas sem história | Criar histórias na RF-05 e na RF-02 | 24/11/2026 |

## 4. Itens aceitos, sem ação

- Filtros modelados como `<<extend>>` de casos de uso existentes.
- Classes `Endereco` e `Funcao`, que aparecem nas telas.
- `HistoricoStatusOS` sem máquina de estados, por ser registro de transição.
- Colunas de auditoria do banco (`*_CRIADO_EM`, `*_ATUALIZADO_EM`), que ficam fora do modelo de domínio.

## Veja também

- [Matriz de rastreabilidade](matriz.md)
- [Malha de rastreabilidade (diagrama)](malha-rastreabilidade.svg)
- [Requisitos funcionais](../03-requisitos/requisitos-funcionais.md)
- [Histórias de usuário](../03-requisitos/historias-de-usuario.md)
- [Backlog](../03-requisitos/backlog.md)
- [Casos de uso](../05-modelagem/casos-de-uso/README.md)
- [Classes](../05-modelagem/classes/README.md)
