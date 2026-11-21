# Wireframes: Relatórios

Fábrica de Software I · Protótipo em alta fidelidade · Desktop 1440×900 · Perfil Gerente

A área de Relatórios reúne os relatórios disponíveis da oficina em cartões, com busca e filtros por frequência e data. Pelo site map, é a área do gerente. A área ainda não tem modelo IFML.

## Telas

| Nº | Tela | Estado | US | UC |
|---|---|---|---|---|
| [9.01](<9.01 - Relatórios - tela principal.svg>) | Relatórios | Tela principal | Sem US | — |

Os casos de uso (UC) reproduzem os vínculos registrados nas issues do GitLab, conforme o índice de [historias-de-usuario.md](../../../../03-requisitos/historias-de-usuario.md#índice).

## Lista de relatórios

**9.01 · Relatórios · Tela principal**

![Tela Relatórios com busca, filtros de frequência e de data e oito cartões de relatório: ordens de serviço, orçamentos, faturamento, ocupação dos boxes, peças e estoque, clientes atendidos, desempenho dos mecânicos e veículos atendidos](<9.01 - Relatórios - tela principal.svg>)

## Regras de comportamento

Cada linha é um cenário Gherkin das histórias da área. A coluna Situação indica se o wireframe mostra o comportamento: **Desenhado**, **Parcial** (a tela existe, mas falta parte do cenário), **Não desenhado** ou **Divergente** (a tela contradiz o cenário). Cenários marcados `@proposta` foram escritos pela equipe de documentação e ainda não estão nas issues.

| Cenário | US | Telas | Situação | Observação |
|---|---|---|---|---|
| Relatório da ordem de serviço (RF-07) | Sem US | 9.01 | Parcial | O cartão "Relatório de Ordens de Serviço" existe; a tela do relatório, com cliente, funcionário, mecânico, valor total, abertura e fechamento, não foi desenhada |

O RF-07 (relatório da ordem de serviço) e o UC-023 não têm história de usuário; a regra acima vem do texto do requisito.

## Divergências e achados

| ID | Divergência | Telas | Tratamento proposto |
|---|---|---|---|
| W-30 | A tela "Ver informações de um relatório" está no site map, mas não foi desenhada. | — | Desenhar a tela do relatório da OS (SM-01) |
| W-31 | A área de Relatórios não tem história de usuário. | 9.01 | Registrar a história a partir do RF-07 (PN-01) |
| W-32 | A tela mostra o menu completo da secretária, embora o site map reserve a área ao gerente. | 9.01 | Desenhar o menu do gerente (SM-05) |
| W-33 | A exportação incluiu o título "Tela principal" do canvas do Figma. | 9.01 | Reexportar só o quadro da tela (PN-05) |

## Veja também

- [Wireframes: todas as áreas](../../README.md)
- [Índice das telas](<../0 - Índice.md>)
- [Site map](../../../site-map.md)
- [Protótipo: revisão de usabilidade e pendências](../../../README.md)
- [IFML](../../../ifml/README.md)
- [Histórias de usuário](../../../../03-requisitos/historias-de-usuario.md)
