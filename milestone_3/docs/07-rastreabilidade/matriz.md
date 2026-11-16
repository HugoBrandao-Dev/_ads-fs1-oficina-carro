# Matriz de rastreabilidade

Milestone 3 · Fábrica de Software I · Unidade de rastreabilidade (cadeia requisito, história, caso de uso, classe, sequência, atividade ou estado, tela e tabela)

Uma linha por história de usuário (30 histórias), mais uma linha para a RF-07, que não tem história. Os RF do Bancada são grupos de histórias (ver [requisitos-funcionais.md](../03-requisitos/requisitos-funcionais.md)); por isso a linha da matriz é a história, e não o RF. As colunas seguem a cadeia da [malha](malha-rastreabilidade.svg). Situação em 15/11/2026, conferida nas issues do GitLab e no arquivo do Figma "Gestão de Oficina Mecânica".

## Como ler

- **UC**: vínculo registrado no título da issue de caso de uso (`UC-0YY - US-0XX - <nome>`). "—" indica história sem caso de uso no catálogo. Os vínculos que parecem incorretos estão na divergência 8 de [requisitos-funcionais.md](../03-requisitos/requisitos-funcionais.md#divergências).
- **Classes**: nomes do diagrama de classes de domínio (página "05 · Diagrama de Classes" do Figma).
- **Sequência**: diagramas da página "06 · Diagrama de Sequência", ligados pelo caso de uso. Quando a história não tem caso de uso, o diagrama foi ligado pelo assunto e a célula diz isso. `UC-000` é o código usado no GitLab para diagrama sem caso de uso no catálogo.
- **Atividade ou estado**: diagramas da página "08 - Diagrama de Atividades e Estados", ligados pelo diagrama de sequência (padrão `DA-0XX | DS-0YY`). "(em branco)" indica quadro criado sem diagrama; "(vazio)" indica quadro sem nenhum elemento.
- **Tela no Figma**: quadro principal da página "03 · Protótipo", com link. "(+n)" indica quantos quadros a mais (estados de erro, sucesso ou filtro) existem para a mesma história.
- **Tabela**: tabelas de `milestone_2/ddl.sql`.
- **Teste**: a coluna do modelo não foi incluída, porque o repositório não tem código da aplicação nem testes. A ausência está registrada em [lacunas.md](lacunas.md) (L-12).

## Matriz

| RF | US | UC | Classes | Sequência | Atividade ou estado | Tela no Figma | Tabela |
|---|---|---|---|---|---|---|---|
| RF-01 | US-001 | (incluído em todos) | Funcionario, Funcao | — | — | [Autenticação da secretária][t-3-37] | funcionario, funcao |
| RF-01 | US-002 | UC-013 | OrdemServico, Veiculo | DS-008 | DE-001 | — | ordem_servico |
| RF-01 | US-003 | UC-001 | Pessoa, Cliente, Endereco | DS-001 | DA-001 | [Cadastro do cliente][t-277-839] (+2) | pessoa |
| RF-01 | US-004 | UC-002 | Pessoa, Cliente, Endereco | DS-005 | DA-002 | [Atualização cadastral do cliente][t-277-663] (+2) | pessoa |
| RF-01 | US-005 | — | Cliente | — | — | [Lista de clientes (busca)][t-95-2193] | pessoa |
| RF-01 | US-006 | UC-004 | Veiculo, CarroModelo, CarroMarca | DS-002 | DA-003 | [Cadastro de carros][t-106-325] (+1) | veiculo, carro_modelo, carro_marca |
| RF-01 | US-007 | UC-005 | Veiculo | DS-006 | DA-006 | [Atualização cadastral do carro][t-188-508] | veiculo |
| RF-01 | US-008 | — | OrdemServico | — | — | — | ordem_servico |
| RF-01 | US-009 | — | OrdemServico | — | — | — | ordem_servico |
| RF-01 | US-010 | UC-003 | Cliente | DS-009 | DA-008 | [Lista de clientes][t-95-2193] (+1) | pessoa |
| RF-01 | US-011 | UC-008 | Veiculo | DS-014 | DA-011 | [Listagem de carros cadastrados][t-96-2869] (+1) | veiculo |
| RF-01 | US-012 | — | OrdemServico | DS-017 (UC-000) | DA-014 | [Ordens de serviço · primeira tela][t-399-808] (+2) | ordem_servico |
| RF-01 | US-013 | UC-011 | Cliente, Veiculo | DS-018 | DA-015 | [Detalhe do cliente][t-3-1047] | pessoa, veiculo |
| RF-01 | US-014 | UC-012 | Veiculo | DS-015 | DA-012 | [Visualização informações do carro][t-167-1072] | veiculo |
| RF-01 | US-015 | — | OrdemServico | DS-020 (UC-000, aberto) | — | [OS em execução — detalhe][t-789-3286] | ordem_servico |
| RF-02 | US-016 | UC-006 | Orcamento, ItemOrcamentoPeca, ItemOrcamentoServico, Servico | DS-003 | DA-004 (em branco) | [Montar o orçamento da OS][t-201-500] (+4) | orcamento, orcamento_peca, orcamento_servico |
| RF-02 | US-017 | — (sugerido: UC-009, UC-010) | Orcamento | DS-012, DS-013 (pelo UC sugerido) | DE-002 (vazio), DE-003 | [confirmacao-orcamento-aprovado][t-770-3127] | orcamento, orcamento_historico |
| RF-02 | US-018 | — | Orcamento | — | — | [Histórico de status (tela inicial de Orçamentos)][t-205-510] (+1) | orcamento_historico |
| RF-02 | US-026 | — | Orcamento | — | — | [Filtro de status: aberto][t-127-245] (+7) | orcamento |
| RF-03 | #42 | — | OrdemServico, Box, Funcionario | — | — | [Agenda dos boxes - tela principal][t-582-3028] (+4) | box, ordem_servico |
| RF-04 | US-029 | — | Veiculo, OrdemServico, Orcamento | — | — | [Consultar histórico do veículo por placa][t-367-293] (+3) | veiculo, orcamento, ordem_servico |
| RF-04 | US-030 | — | Veiculo | — | — | [Histórico do veículo — estado inicial][t-372-293] | — |
| RF-05 | US-019 | UC-017 | Peca, PecaDistribuidora, Compatibilidade | — | — | [Cadastrar peça][t-9798-4460] (+1) | peca, peca_distribuidora, peca_modelo |
| RF-05 | US-020 | UC-021 | Peca | — | — | [Detalhes da peça][t-9810-4387] | peca |
| RF-05 | US-021 | UC-022 | Peca | — | — | [Editar peça][t-9810-4498] (+1) | peca |
| RF-05 | US-022 | — | Peca | — | — | [Excluir peça (confirmação)][t-9810-4710] (+1) | peca |
| RF-05 | US-023 | — | Peca | — | — | [Peças e estoque (listagem)][t-9809-4179] (+2) | peca |
| RF-05 | US-024 | — | Peca | — | — | [Alerta de estoque baixo][t-9809-4661] | peca |
| RF-06 | US-027 | — | HistoricoStatusOS | — | — | — | ordem_servico_historico |
| RF-06 | US-028 | UC-009, UC-010, UC-014 (GitLab) | OrdemServico, HistoricoStatusOS | DS-008 (pelo assunto) | DE-001 | [OS finalizada][t-958-3272] (+2) | ordem_servico, ordem_servico_historico |
| RF-07 | — | UC-023 | OrdemServico, Orcamento, Cliente, Funcionario | — | — | [Relatórios - tela principal][t-399-1207] | ordem_servico, orcamento, pessoa |

[t-3-37]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=3-37
[t-277-839]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=277-839
[t-277-663]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=277-663
[t-95-2193]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=95-2193
[t-106-325]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=106-325
[t-188-508]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=188-508
[t-96-2869]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=96-2869
[t-399-808]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=399-808
[t-3-1047]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=3-1047
[t-167-1072]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=167-1072
[t-789-3286]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=789-3286
[t-201-500]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=201-500
[t-770-3127]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=770-3127
[t-205-510]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=205-510
[t-127-245]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=127-245
[t-582-3028]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=582-3028
[t-367-293]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=367-293
[t-372-293]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=372-293
[t-9798-4460]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=9798-4460
[t-9810-4387]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=9810-4387
[t-9810-4498]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=9810-4498
[t-9810-4710]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=9810-4710
[t-9809-4179]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=9809-4179
[t-9809-4661]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=9809-4661
[t-958-3272]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=958-3272
[t-399-1207]: https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=399-1207

## Cobertura da cadeia

| Elo da cadeia | Linhas com vínculo | Total | Sem vínculo |
|---|---|---|---|
| Caso de uso | 15 | 31 | 16 |
| Classe | 31 | 31 | 0 |
| Sequência | 14 | 31 | 17 |
| Atividade ou estado (com conteúdo) | 12 | 31 | 19 |
| Tela | 27 | 31 | 4 |
| Tabela | 30 | 31 | 1 |
| Teste | 0 | 31 | 31 |

A US-001 conta como "sem caso de uso" porque a autenticação só aparece como `<<include>>` nos outros casos de uso. A US-030 não tem tabela por ser apenas orientação de tela. A lista das linhas sem cada elo está em [lacunas.md](lacunas.md).

## Divergências

1. **Linha por história, e não por RF.** O modelo tem uma linha por RF. No Bancada, cada RF agrupa até 15 histórias; uma linha por RF esconderia as lacunas. A matriz usa a história como linha e mantém o RF na primeira coluna.
2. **Telas sem identificador.** As telas do Figma não têm código próprio (o modelo usa `T-<perfil>-NN`). A matriz cita o nome do quadro e o link. Lacuna L-08.
3. **Telas com número de história errado.** O quadro "US-012 - RF-01 - Relatórios - tela principal" pertence à RF-07; a US-012 é a listagem de OS. Os quadros de distribuidora e a versão anterior de peças usam "US-xxx - RF-xx". Lacuna L-08.
4. **Diagramas fechados no GitLab e vazios no Figma.** As issues DA-009 (#109) e DE-002 (#111) estão fechadas, mas o quadro DA-009 não tem elementos e o DE-002 tem só o título. Lacuna L-05.
5. **Quadro de sequência sem título.** A página de sequência tem um diagrama de visualização da OS ("secr-fina-os") sem o título `DS-020 | UC-000`. A issue DS-020 (#97) está em andamento. Lacuna L-04.

## Veja também

- [Lacunas e órfãos](lacunas.md)
- [Malha de rastreabilidade (diagrama)](malha-rastreabilidade.svg)
- [Requisitos funcionais](../03-requisitos/requisitos-funcionais.md)
- [Histórias de usuário](../03-requisitos/historias-de-usuario.md)
- [Backlog e cobertura por artefato](../03-requisitos/backlog.md#cobertura-por-artefato)
- [Casos de uso](../05-modelagem/casos-de-uso/README.md)
- [Classes](../05-modelagem/classes/README.md)
- [Dicionário de dados](../06-banco-de-dados/dicionario-de-dados.md)
