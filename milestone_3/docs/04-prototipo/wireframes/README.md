# Wireframes

Fábrica de Software I · Protótipo em alta fidelidade · Desktop 1440×900 · Milestones 1 a 3

Esta pasta reúne as telas do Bancada exportadas em SVG da página "[03 · Protótipo](https://www.figma.com/design/EHj0Js5KtOJ88TRQd5fTJI/Gest%C3%A3o-de-Oficina-Mec%C3%A2nica?node-id=3-36)" do Figma. As telas estão em `Meuprojetooficina/`, em uma pasta por área do menu lateral. Cada pasta tem um README com a tabela tela → história → caso de uso, as telas na ordem do fluxo, as regras de comportamento tiradas dos cenários Gherkin e as divergências encontradas. O [índice das telas](<Meuprojetooficina/0 - Índice.md>) relaciona cada arquivo ao nome do quadro original no Figma.

| Pasta | Área | Perfil | Telas | Histórias | IFML |
|---|---|---|---|---|---|
| [1 - Login](<Meuprojetooficina/1 - Login/README.md>) | Login | Todos | 1 | US-001 | IFML-01 |
| [2 - Painel](<Meuprojetooficina/2 - Painel/README.md>) | Painel | Secretária | 1 | US-002 (parcial) | IFML-01 |
| [3 - Orçamento](<Meuprojetooficina/3 - Orçamento/README.md>) | Orçamentos | Secretária | 22 | US-016, US-017, US-018, US-026 | IFML-05 |
| [4 - Ordens de serviço](<Meuprojetooficina/4 - Ordens de serviço/README.md>) | OS | Secretária | 9 | US-012, US-015, US-027, US-028 | IFML-04 |
| [5 - Clientes](<Meuprojetooficina/5 - Clientes/README.md>) | Clientes | Secretária | 9 | US-003, US-004, US-005, US-010, US-013 | IFML-02 |
| [6 - Veículos](<Meuprojetooficina/6 - Veículos/README.md>) | Carros e histórico do veículo | Secretária | 11 | US-006, US-007, US-011, US-014, US-029, US-030 | IFML-03, IFML-06 |
| [7 - Peças e estoque](<Meuprojetooficina/7 - Peças e estoque/README.md>) | Peças e Estoque e Distribuidora | Estoquista | 31 | US-019 a US-024; marca e modelo e distribuidoras sem história | IFML-07 |
| [8 - Agenda dos boxes](<Meuprojetooficina/8 - Agenda dos boxes/README.md>) | Agenda dos Box | Secretária | 5 | #42, US-028 | Sem modelo |
| [9 - Relatórios](<Meuprojetooficina/9 - Relatórios/README.md>) | Relatórios | Gerente | 1 | Sem história (RF-07) | Sem modelo |
| [Rótulos](<Meuprojetooficina/Rótulos/>) | Títulos de seção do canvas | — | 26 | — | — |

Total: 90 telas. Na pasta 7, as telas 7.27 a 7.31 são a versão anterior das telas de peças, mantida como registro do redesenho.

## Convenção

- **Numeração.** `N.NN`: `N` é a pasta da área e `NN` é a ordem da tela no fluxo, começando em 01.
- **Nome do arquivo.** `N.NN - Tela - estado (US-nnn).svg`. O estado aparece quando a mesma tela tem mais de uma situação (vazio, preenchido, erro, sucesso). A história aparece entre parênteses quando está registrada no GitLab.
- **Formato.** Quadros de desktop de 1440×900 exportados em SVG (alguns arquivos ficam maiores por causa da sombra do quadro), com o menu lateral agrupado em Atendimento, Cadastros e Gestão.
- **Conteúdo.** Dados plausíveis da oficina, com as exceções registradas no achado UX-07; o mesmo caso atravessa várias áreas (cliente Antônio Ribeiro Sales, orçamento ORC-1043, OS-0184, Box 2, mecânico Renan Souza).

## Cobertura dos cenários de aceite

Os READMEs das pastas conferem cada cenário Gherkin das histórias contra as telas. Resultado em 20/11/2026:

| Pasta | Desenhado | Parcial | Não desenhado | Divergente |
|---|---|---|---|---|
| 1 - Login | 1 | 1 | 1 | 0 |
| 2 - Painel | 0 | 1 | 2 | 0 |
| 3 - Orçamento | 4 | 5 | 1 | 0 |
| 4 - Ordens de serviço | 5 | 2 | 5 | 1 |
| 5 - Clientes | 5 | 1 | 0 | 1 |
| 6 - Veículos | 7 | 1 | 3 | 0 |
| 7 - Peças e estoque | 4 | 4 | 3 | 0 |
| 8 - Agenda dos boxes | 3 | 1 | 0 | 0 |
| 9 - Relatórios | 0 | 1 | 0 | 0 |
| **Total** | **29** | **17** | **15** | **2** |

O cenário de conclusão da US-028 é contado nas pastas 4 e 8, porque as duas áreas o atendem. A maior parte dos cenários não desenhados são estados de erro (placa duplicada, código duplicado, campo obrigatório em branco). As duas divergências são a OS sem formulário próprio (US-008) e o CPF bloqueado na edição do cliente (US-004).

## Veja também

- [Índice do protótipo e revisão de usabilidade](../README.md)
- [Site map](../site-map.md)
- [IFML](../ifml/README.md)
- [Histórias de usuário](../../03-requisitos/historias-de-usuario.md)
