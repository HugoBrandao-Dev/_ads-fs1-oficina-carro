# Wireframes: Painel

Fábrica de Software I · Protótipo em alta fidelidade · Desktop 1440×900 · Perfil Secretária

O Painel é a primeira tela depois do login. Reúne o que a secretária precisa acompanhar no turno: quatro indicadores, as ordens de serviço em andamento, os veículos prontos para retirada e a agenda do dia nos boxes. A navegação está modelada no [IFML-01](../../../ifml/README.md#ifml-01-acesso-e-painel).

## Telas

| Nº | Tela | Estado | US | UC |
|---|---|---|---|---|
| [2.01](<2.01 - Painel - visão geral do atendimento.svg>) | Painel: visão geral do atendimento | Padrão | US-002 (parcial) | UC-013 |

Os casos de uso (UC) reproduzem os vínculos registrados nas issues do GitLab, conforme o índice de [historias-de-usuario.md](../../../../03-requisitos/historias-de-usuario.md#índice).

## Visão geral do atendimento

**2.01 · Painel: visão geral do atendimento**

![Painel com saudação à secretária, quatro indicadores (veículos na oficina, aguardando aprovação, prontos para retirada, atendimentos hoje), tabela de ordens de serviço em andamento com status, valor e tempo parado, lista de prontos para retirada com o botão Chamar e agenda de hoje dos boxes](<2.01 - Painel - visão geral do atendimento.svg>)

## Regras de comportamento

Cada linha é um cenário Gherkin das histórias da área. A coluna Situação indica se o wireframe mostra o comportamento: **Desenhado**, **Parcial** (a tela existe, mas falta parte do cenário), **Não desenhado** ou **Divergente** (a tela contradiz o cenário). Cenários marcados `@proposta` foram escritos pela equipe de documentação e ainda não estão nas issues.

| Cenário | US | Telas | Situação | Observação |
|---|---|---|---|---|
| Retirada com dados corretos | US-002 | 2.01 | Parcial | A lista "Prontos para retirada" mostra os veículos e o botão "Chamar", mas não há ação para registrar a retirada |
| Dados do veículo incorretos | US-002 | — | Não desenhado |  |
| Retirada por pessoa diferente da que entregou o veículo `@proposta` | US-002 | — | Não desenhado |  |

O Painel não tem história própria. Ele reúne informações de outras áreas (OS, retirada e agenda dos boxes).

## Divergências e achados

| ID | Divergência | Telas | Tratamento proposto |
|---|---|---|---|
| W-03 | O Painel não tem história de usuário que o justifique. | 2.01 | Registrar a história do Painel (ver PN-01 do README do protótipo) |
| W-04 | A retirada do veículo (US-002) não tem tela própria nem ação no Painel. | 2.01 | Desenhar a ação "Registrar retirada" a partir da lista de prontos para retirada |

## Veja também

- [Wireframes: todas as áreas](../../README.md)
- [Índice das telas](<../0 - Índice.md>)
- [Site map](../../../site-map.md)
- [Protótipo: revisão de usabilidade e pendências](../../../README.md)
- [IFML](../../../ifml/README.md)
- [Histórias de usuário](../../../../03-requisitos/historias-de-usuario.md)
