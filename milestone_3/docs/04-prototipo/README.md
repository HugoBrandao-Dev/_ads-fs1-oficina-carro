# Protótipo do Bancada

Fábrica de Software I · Protótipo do sistema · Milestones 1 a 3

Este diretório reúne o protótipo de interface do Bancada, o sistema de gestão de oficina mecânica da RFP 2: o site map, os modelos IFML, os wireframes exportados do Figma e a revisão de usabilidade pelas heurísticas de Nielsen. Todas as telas foram desenhadas no arquivo do Figma "[Gestão de Oficina Mecânica](https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=3-36)", e cada uma aponta para a história de usuário do GitLab que a justifica.

## Índice

| Artefato | Conteúdo |
|---|---|
| [site-map.md](site-map.md) | Níveis, perfis de acesso, hierarquia e tabela tela → história → wireframe → IFML |
| [site-map.svg](site-map.svg) | Diagrama do site map (página "01 · Site Map" do Figma) |
| [ifml/README.md](ifml/README.md) | Notação IFML e descrição dos sete modelos (IFML-01 a IFML-07) |
| [ifml/](ifml/) | Diagramas IFML em SVG (página "02 · IFML" do Figma) |
| [wireframes/README.md](wireframes/README.md) | Organização dos wireframes por área e cobertura dos cenários de aceite |
| `wireframes/Meuprojetooficina/N - Área/README.md` | Telas de cada área, regras de comportamento e divergências (W-01 a W-33) |
| [wireframes/Meuprojetooficina/0 - Índice.md](<wireframes/Meuprojetooficina/0 - Índice.md>) | Lista das 90 telas, com o nome do quadro original no Figma |

## Protótipo navegável

O protótipo está na página "[03 · Protótipo](https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=3-36)" do arquivo do Figma. Para navegar entre as telas, abre-se a página no modo de apresentação do Figma (botão "Present").

As demais páginas do mesmo arquivo guardam os artefatos de modelagem: "01 · Site Map", "02 · IFML", "04 · Diagrama de Casos de Uso", "05 · Diagrama de Classes", "06 · Diagrama de Sequência", "07 · Modelo do Banco de Dados" e "08 - Diagrama de Atividades e Estados".

## Versões

| Versão | Milestone | Escopo |
|---|---|---|
| 0.1 | Milestone 1 (15/09/2026) | Site map inicial com perfil único (secretária) e primeiros wireframes das áreas de atendimento e de cadastros |
| 0.2 | Milestone 2 | Modelos IFML-01 a IFML-07, ligados aos wireframes e às histórias do GitLab |
| 0.3 | Milestone 3 (20/11/2026) | Site map com três perfis (secretária, estoquista e gerente); telas de peças redesenhadas, com a versão anterior preservada; telas de distribuidoras, Agenda dos boxes e Relatórios; correção dos rodapés do IFML-04 e do IFML-05 (17/11/2026); reorganização dos wireframes por área e esta documentação |

## Perfis e convenção de telas

O site map distribui as áreas entre três perfis. As telas e os modelos IFML concentram-se na secretária, que é quem mais usa o sistema.

| Perfil | Áreas | Wireframes |
|---|---|---|
| Secretária | Painel, Clientes, Carros, Orçamentos, OS e Agenda dos Box | Pastas 1 a 6 e 8 |
| Estoquista | Painel, Peças e Estoque e Distribuidora | Pasta 7 |
| Gerente | Relatórios | Pasta 9 |

**Numeração.** Cada tela recebe o número `N.NN`, em que `N` é a pasta da área e `NN` é a ordem da tela no fluxo, começando em 01. Exemplo: `5.02` é a segunda tela da pasta Clientes.

**Nome do arquivo.** `N.NN - Tela - estado (US-nnn).svg`. O estado aparece quando a mesma tela tem mais de uma situação (vazio, preenchido, erro, sucesso). A história aparece entre parênteses quando a tela tem história registrada no GitLab. Exemplo: `5.03 - Cadastro de cliente - informações conflitantes (US-003).svg`.

**Formato.** Quadros de desktop exportados do Figma em SVG, com o menu lateral agrupado em Atendimento, Cadastros e Gestão. A pasta `Rótulos/` guarda os títulos de seção usados no canvas do Figma para separar os fluxos.

## Inventário de telas

| Pasta | Área | Perfil | Telas | Histórias |
|---|---|---|---|---|
| [1 - Login](<wireframes/Meuprojetooficina/1 - Login/README.md>) | Login | Todos | 1 | US-001 |
| [2 - Painel](<wireframes/Meuprojetooficina/2 - Painel/README.md>) | Painel | Secretária | 1 | US-002 (parcial) |
| [3 - Orçamento](<wireframes/Meuprojetooficina/3 - Orçamento/README.md>) | Orçamentos | Secretária | 22 | US-016, US-017, US-018, US-026 |
| [4 - Ordens de serviço](<wireframes/Meuprojetooficina/4 - Ordens de serviço/README.md>) | OS | Secretária | 9 | US-012, US-015, US-027, US-028 |
| [5 - Clientes](<wireframes/Meuprojetooficina/5 - Clientes/README.md>) | Clientes | Secretária | 9 | US-003, US-004, US-005, US-010, US-013 |
| [6 - Veículos](<wireframes/Meuprojetooficina/6 - Veículos/README.md>) | Carros e histórico do veículo | Secretária | 11 | US-006, US-007, US-011, US-014, US-029, US-030 |
| [7 - Peças e estoque](<wireframes/Meuprojetooficina/7 - Peças e estoque/README.md>) | Peças e Estoque e Distribuidora | Estoquista | 31 (26 vigentes e 5 da versão anterior) | US-019 a US-024; distribuidoras sem história |
| [8 - Agenda dos boxes](<wireframes/Meuprojetooficina/8 - Agenda dos boxes/README.md>) | Agenda dos Box | Secretária | 5 | #42, US-028 |
| [9 - Relatórios](<wireframes/Meuprojetooficina/9 - Relatórios/README.md>) | Relatórios | Gerente | 1 | Sem história (RF-07) |
| **Total** | | | **90** | |

A ligação de cada tela com o nó do site map e com o modelo IFML está na seção [Tela, história e wireframe](site-map.md#tela-história-e-wireframe) do site map.

## Revisão de usabilidade (heurísticas de Nielsen)

Escopo: inspeção heurística dos 90 wireframes exportados em 20/11/2026. Não houve teste com usuários. A revisão deve ser repetida depois das correções da seção [Achados abertos](#achados-abertos).

Escala de severidade (Nielsen): 0 não é problema de usabilidade; 1 cosmético; 2 menor; 3 grande; 4 catástrofe.

### Avaliação por heurística

| # | Heurística | Onde o protótipo atende | Onde falha |
|---|---|---|---|
| H1 | Visibilidade do status do sistema | Etiquetas coloridas de status em orçamentos e OS; aviso "Estoque abaixo do mínimo" no detalhe da peça (7.06); telas de confirmação após cada gravação | A lista da Agenda dos boxes fica vazia sem mensagem depois que o box é liberado (8.03). Ver UX-08 |
| H2 | Correspondência com o mundo real | Vocabulário da oficina: placa, quilometragem, box, mecânico responsável, orçamento orçado e aprovado | Os nomes de status variam entre telas. Ver UX-03 |
| H3 | Controle e liberdade do usuário | "Descartar" nos formulários de cadastro e de edição; "Voltar ao estoque" e "Voltar à listagem" nas confirmações | O par "Atendimento em curso" e "Cancelar" nas telas de lista não diz o que é cancelado. Ver UX-06 |
| H4 | Consistência e padrões | Mesmo menu lateral, mesmo cabeçalho e mesmo padrão de tabela em todas as áreas | O item ativo do menu e o breadcrumb nem sempre correspondem à área; uma confirmação foi copiada de outro fluxo. Ver UX-01 e UX-02 |
| H5 | Prevenção de erros | Confirmação antes de excluir peça (7.09); erros de CPF, telefone e e-mail já cadastrados exibidos antes de gravar (5.03, 7.23) | A atualização do carro abre com os campos vazios. Ver UX-04 |
| H6 | Reconhecer em vez de lembrar | Seleção de cliente, veículo, marca e modelo por lista; campos alterados marcados como "alterado", com o valor anterior (5.07) | A área Distribuidoras não está no menu lateral. Ver UX-05 |
| H7 | Flexibilidade e eficiência de uso | Busca e filtros combináveis em orçamentos, OS e peças; consulta do histórico pela placa | Atalhos de teclado ficam como melhoria futura, não como requisito |
| H8 | Estética e design minimalista | Uma ação principal por tela, destacada em laranja ou preto; no máximo quatro indicadores no Painel | Foto genérica de cliente e de carro ocupa o espaço principal dos cartões (5.01, 6.01) sem história que a peça. Ver UX-07 |
| H9 | Ajudar a reconhecer, diagnosticar e recuperar erros | Estado "sem resultados" com as ações "Limpar filtros" e "Cadastrar peça" (7.03); "Placa não encontrada" explica a causa (6.08) | A tela 6.08 não oferece o botão para cadastrar o veículo. Ver UX-08 |
| H10 | Ajuda e documentação | Orientação inicial na tela de histórico do veículo (6.07, US-030); textos de apoio sob os campos | Ajuda contextual nas demais áreas fica como melhoria futura |

### Achados abertos

| ID | Severidade | Achado | Telas afetadas | Ação |
|---|---|---|---|---|
| UX-01 | 3 | O item ativo do menu e o breadcrumb não mostram onde a secretária está. O detalhe da OS marca "Orçamento" e mostra "Orçamento / Histórico de orçamentos"; Distribuidoras marca "Ordem de serviço" ou "Clientes"; a lista de peças filtrada mostra "Distribuidoras" no breadcrumb; os breadcrumbs de orçamento começam com um nível vazio ("/ Orçamento"). | 3.01 a 3.22, 4.05, 4.06, 7.14 a 7.17, 7.21 a 7.26 | Usar o componente de menu com a propriedade "item ativo" e montar o breadcrumb como Área › Tela, igual ao site map |
| UX-02 | 3 | A confirmação "Carro cadastrado com sucesso" foi copiada do fluxo de orçamento: mostra o código ORC-1043, o botão "Voltar ao histórico" e o breadcrumb de orçamentos. | 6.03 | Mostrar a placa do carro e os botões "Ver carro" e "Voltar à listagem" |
| UX-03 | 2 | Os status têm nomes diferentes em cada tela: "Aberta", "em aberto" e "Em aberta" no orçamento; "Concluído" no filtro de OS e "Finalizado" na etiqueta. A tela 4.08 lista OS finalizadas com o título "Ordens de serviço em execução", e o rodapé de 3.18 fala em "orçamentos em aberto". | 3.14 a 3.22, 4.02, 4.04, 4.07, 4.08 | Adotar os nomes do ciclo definido no IFML-04 (aberta → em execução → concluída) e os do orçamento (aberto, orçado, aprovado, recusado) em filtros, etiquetas e títulos |
| UX-04 | 2 | A atualização cadastral do carro abre com os campos vazios, com CPF fictício "111.111.111-11", e tem duas ações principais ("Atualizar" e "Salvar alterações"). | 6.06 | Abrir com os dados atuais, como na edição do cliente (5.07), e manter só "Salvar alterações" |
| UX-05 | 3 | A área Distribuidoras está no site map, mas não aparece no menu lateral. Não há caminho visível até as telas 7.21 a 7.26. | 7.12 a 7.26 | Incluir "Distribuidoras" no grupo Cadastros do menu do estoquista |
| UX-06 | 2 | As telas de lista exibem a etiqueta "Atendimento em curso" e um "Cancelar" solto no cabeçalho, sem indicar o que será cancelado nem para onde a tela volta. | 5.01, 5.05, 6.01, 6.04, 8.01 a 8.04 | Remover o par das telas de lista ou nomear a ação ("Encerrar atendimento") |
| UX-07 | 1 | Conteúdo de preenchimento: todos os orçamentos em aberto custam R$ 100,00; ORC-0415 aparece duas vezes; os cartões de cliente e de carro usam imagem genérica sem história que a peça. | 3.15, 3.16, 3.18, 5.01, 5.05, 6.01, 6.04 | Usar valores plausíveis e remover as imagens, ou trocar os cartões por tabela |
| UX-08 | 1 | Estados incompletos: a Agenda dos boxes fica vazia sem mensagem quando o último box é liberado; "Placa não encontrada" não oferece a ação de cadastrar o veículo. | 8.03, 6.08 | Desenhar o estado vazio da agenda e incluir o botão "Cadastrar veículo" com a placa preenchida |

Prioridade: UX-01, UX-02 e UX-05 devem ser corrigidos antes da apresentação do Milestone 3. UX-03 e UX-04 em seguida. UX-06 a UX-08 podem ficar para a revisão final.

## Pendências

| ID | Pendência | Referência |
|---|---|---|
| PN-01 | Registrar no GitLab as histórias das telas sem US: distribuidoras, peças por marca e modelo, Painel do estoquista e Relatórios. Depois, trocar "US-xxx" nos nomes dos quadros do Figma. | [SM-04](site-map.md#divergências-entre-o-site-map-e-os-wireframes) |
| PN-02 | Desenhar o Painel do estoquista e a tela "Ver informações de um relatório", e incluir no site map os nós "Designar box e mecânico" e "Ver alertas de estoque". | SM-01, SM-02, SM-03 |
| PN-03 | Desenhar o menu lateral de cada perfil com as áreas que o site map lhe atribui. | SM-05 |
| PN-04 | Modelar em IFML a Agenda dos boxes, as Distribuidoras e os Relatórios. | [Limites do modelo](ifml/README.md#limites-do-modelo) |
| PN-05 | Reexportar a 9.01 só com o quadro da tela (a exportação incluiu o título "Tela principal" do canvas) e remover a 7.17, que é cópia da 7.16. | [Índice das telas](<wireframes/Meuprojetooficina/0 - Índice.md>) |
| PN-06 | Corrigir os achados UX-01 a UX-08 no Figma e repetir a revisão heurística. | [Achados abertos](#achados-abertos) |

## Veja também

- [Site map](site-map.md) e [diagrama](site-map.svg)
- [IFML: fluxos de interação do Bancada](ifml/README.md)
- [Wireframes](wireframes/README.md)
- [Histórias de usuário](../03-requisitos/historias-de-usuario.md)
- [Requisitos funcionais](../03-requisitos/requisitos-funcionais.md)
- [Matriz de rastreabilidade](../07-rastreabilidade/matriz.md)
- [Glossário](../01-visao/glossario.md)
