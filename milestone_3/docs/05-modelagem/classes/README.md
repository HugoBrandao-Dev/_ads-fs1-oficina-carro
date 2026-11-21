# Diagrama de classes de domínio

Milestone 2 · Modelagem do domínio (Fábrica de Software I)

O diagrama modela o domínio da Gestão de Oficina Mecânica de Carros: as classes que o negócio reconhece, seus atributos, operações e associações. Não é diagrama de tabelas, controllers ou DAO. O mapeamento para o banco está em [dicionário de dados](../../06-banco-de-dados/dicionario-de-dados.md).

## Arquivos

- [classes.svg](classes.svg): núcleo do domínio (Cliente, Funcionario, Veiculo, Orcamento, OrdemServico, etc.) e enumerações.

![Diagrama de classes do núcleo do domínio](classes.svg)

## Lista oficial de classes

| Classe | Responsabilidade | Telas (perfil) | Tabela |
|---|---|---|---|
| Pessoa | Pessoa com ou sem acesso ao sistema. Pode estar vinculada a um Cliente ou Funcionário. | Secretária login, cadastros, listagens, atualizações, visualiações. Estoquista: login, cadastros, listagens, atualizações, visualiações, Gerente: visualizações | `pessoa` (papéis em `funcionario`) |
| Endereço | Informação de localização do cliente | Secretária (cadastro, listagem, atualização e visualização) | papéis em `pessoa` |
| Cliente | Pessoa que traz o veículo para fazer o orçamento. |  ||
| Veiculo | Veículo do cliente. Se víncula ao Orçamento | Secretária (cadastro, listagem, atualização e visualização) | `veiculo` |
| Orcamento | Orçamento feito para o Veículo. Passa pelo ciclo EM ABERTA, ORÇADA, APROVADA e RECUSADO | Secretária (cadastro, listagem, atualização e visualização) | `orcamento ` |
| OrdemServico | Valor e detalhes do serviço a ser executado no veículo. Possa pelo ciclo APROVADO, EM EXECUÇÃO e CONCLUÍDO | Secretária (cadastro, listagem, atualização e visualização) | `ordem_servico` |
| Box | Local onde será executada a Ordem de Serviço. Passa pelo ciclo LIVRE e EM EXECUÇÃO | Secretária: (seleção) | `box` |
| Servico | Tipo de servico a ser realizado no veículo. | Secretária (seleção) | `servico ` |
| Funcao | Função desemplenhada pelo funcionário e é, também, o __NÍVEL DE ACESSO__ ao sistema. | DBA | `funcao` |
| Peca | Peças presentes no estoque e que podem compor o Orçamento do veículo. | Estoquista (cadastro, listagem, atualização e visualização), Secretária (seleção) | `peca` |
| CarroMarca | Marca do veículo do cliente, mas é vínculado ao Modelo. | Secretária (seleção) | `carro_marca` |
| CarroModelo | Modelo do carro do cliente. | Secretária (seleção) | `carro_modelo` |
| ItemOrcamentoPeca | Classe associativa que vincula Peça ao Orçamento. | Secretária (orçamento) | `orcamento_peca` |
| Distribuidora | Reponsável pela venda da peça à oficina. | Estoquista (cadastro, listagem, atualização e visualização) | `distribuidora ` |
| PecaDistribuidora | Classe associativa que vincula Peça a Distribuidora | Estoquista (seleção) | `peca_distribuidora` |
| Compatibilidade | Classe associativa entre Peça e Modelo do carro | Estoquista (visualização), Secretária (seleção) | `peca_modelo` |
| HistoricoStatusOS | Guarda as informações do histórico de status da Ordem de Serviço | Gerente (relatório ) | `ordem_servico_historico` |

## Associações e multiplicidades

Leitura: o número junto a uma classe indica quantas instâncias dela se ligam a uma instância da outra. Losango preenchido indica composição.

| Associação | Multiplicidade (A e B) | Tipo | Observação |
|---|---|---|---|
| Cliente e Pessoa | -- | Herança | |
| Cliente e Veiculo | 1 e * | Agregação | Cliente deve ser cadastrado antes do veículo |
| ItemOrcamentoPeca e Orcamento | * e 1 | Composição | |
| ItemOrcamentoServico e Orcamento | * e 1 | Composição | |
| Funcionario e HistoricoStatusOS | 1 e * | Associação | |
| Funcionario e Orcamento | 1 e * | Associação | |
| Funcionario e Funcao | * e 1 | Associação | As funções devem estar previamente cadastradas no sistema |
| Funcionario e Pessoa | -- | Herança | Informações pessoais, ficam em Pessoa |
| OrdemServico e Box | * e 0..1 | Associação | |
| OrdemServico e Funcionario | * e 0..1 | Associação | |
| CarroMarca e CarroModelo | 1 e * | Associação | Marca deve existir antes do modelo |
| CarroModelo e Veiculo | 1 e * | Associação | Modelo deve existir antes do veículo |
| CarroModelo e Compatibilidade | 1 e * | Associação | |
| Peca e Compatibilidade | 1 e * | Associação | |
| Peca e ItemOrcamentoPeca | 1 e * | Associação | |
| Peca e PecaDistribuidora | 1 e * | Associação | |
| Distribuidora e PecaDistribuidora | 1 e * | Associação | |
| Endereco e Distribuidora | 1 e 0..1 | Composição | |
| Endereco e Pessoa | 1 e 0..1 | Composição | |
| Servico e ItemOrcamentoServico| 1 e * | Associação | |
| HistoricoStatusOS e OrdemServico | * e 1 | Composição | |
| Veiculo e Orcamento | 1 e * | Associação | |
| Orcamento e OrdemServico | 1 e 0..1 | Associação | OS só pode ser aberta para orçamento `APROVADO` |

## Enumerações

| Enumeração | Literais | Usada em |
|---|---|---|
| Papel | Secretária, Estoquista, Gerente | Funcionario.funcao |
| status(OS) | Aprovado, Em Execução e Concluído | OrdemServico.status |
| statusAnterior | Aprovado, Em Execução e Concluído | HistoricoStatusOS.statusAnterior |
| statusNovo | Aprovado, Em Execução e Concluído | HistoricoStatusOS.statusNovo |
| status(Box) | Livre e Em Execução | Box.status |
| status(Orcamento) | Em Aberta, Orçada, Aprovada e Recusado | Orcamento.status |

## Decisões de modelagem

- **Papel como enumeração, não classe.** `Funcionario.funcao` é um conjunto de `Funcao`.
- **Composição onde a parte não tem sentido sozinha.** Endereço de cliente, funcinonário ou distribuidora fica em Endereco e não podem existir sem dono; O serviço de um orçamento esta em ItemOrcamentoServico e não pode existir sem o orçamento; As peças para o orçamento ficam em ItemOrcamentoPeca e não pode existir sem o orçamento; Todas as vezes que o status de uma OS muda, tal mudança é registrada em HistoricoStatusOS e não pode existir sem um OS.
- **Operações de domínio, não endpoints.** Os nomes seguem as regras (ex.: `OrdemServico.iniciar()`, `Orcamento.aprovar()`, `Peca.cadastrarEstoque()`), não as rotas HTTP. Cada operação corresponde a uma transição ou regra do service.
- **Estados ficam em `estados/`.** Os enums `HistoricoStatusOS.statusAnterior`, `HistoricoStatusOS.statusNovo`, `OrdemServico.status`, `Orcamento.status`, `Box.status` aparece como atributo; as transições são do diagrama de estados.

## Divergências

Divergências identificadas entre o diagrama relacional (DER) e o diagrama de classes de domínio. Quando divergem, as regras de domínio/negócio modeladas nas classes são tomadas como referência.

1. **Entidade Cliente ausente no DER**. O diagrama de classes modela explicitamente `Cliente` como subclasse/especialização de `Pessoa` (com atributos próprios como `dataCadastro` e `ativo`, além de vínculo com `Veiculo`). No DER, há apenas a tabela `pessoa`, sem tabela `cliente`. O modelo de classes reflete a especialização do domínio; o banco concentra os dados apenas em `pessoa`.
2. **Entidade Endereco modelada como classe no domínio e embutida em pessoa no DER**. No diagrama de classes, `Endereco` é uma classe própria associada a `Distribuidora` e `Pessoa`. No DER, os campos de endereço (`pess_en_logradouro`, `pess_en_numero`, `pess_en_bairro`, `pess_en_complemento`, `pess_cep`) aparecem diretamente na tabela `pessoa`, enquanto distribuidora possui colunas próprias de endereço (`dist_en_logradouro`, `dist_en_numero`, `dist_en_bairro`, `dist_en_complemento`, `dist_cep`) sem tabela endereco separada.
3. **Relacionamento de peças e fornecedores** (`Compatibilidade` e `PecaDistribuidora` vs. `peca_modelo` e `peca_distribuidora`). No diagrama de classes, existe a classe `Compatibilidade` ligando `Peca` e `CarroModelo`, além de `PecaDistribuidora` com atributos como `precoCusto` e `dataCotacao`. No DER, a relação entre peça e modelo de carro aparece como a tabela associativa `peca_modelo` (ligando `peca` e `carro_modelo`), e `peca_distribuidora` registra `pedi_custo_unitario` e `pedi_quantidade`.
5. **Vínculos de OrdemServico com Box e Funcionario**. No diagrama de classes, `OrdemServico` possui associações distintas para `Box` e `Funcionario`. No DER, `ordem_servico` traz colunas como `orca_id`, `box_id`, `meca_id`, `func_id` e `os_box_ativo`, além de `ordem_servico_historico` com `os_id` e `func_id`. A nomenclatura e a separação de papéis (`meca_id` e `func_id`) divergem na forma como são representadas entre os diagramas.
6. **Entidades Pagamento e PagamentoParcelas presentes no DER e ausentes no diagrama de classes**. O DER contém as tabelas `pagamento` e `pagamento_parcelas`. O diagrama de classes do domínio não apresenta classes equivalentes para pagamento ou parcelamento

## Veja também

- [Casos de uso](../casos-de-uso/README.md)
- [Sequência](../sequencia/README.md)
- [Atividades](../atividades/README.md)
- [Estados](../estados/README.md)
- [OCL e divergências](../ocl/README.md)
- [Modelo conceitual](../../06-banco-de-dados/modelo-conceitual.svg) e [modelo lógico](../../06-banco-de-dados/modelo-logico.svg)
- [Dicionário de dados](../../06-banco-de-dados/dicionario-de-dados.md)
- [Modelagem (índice)](../README.md)
