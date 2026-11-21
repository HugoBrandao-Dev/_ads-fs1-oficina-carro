# Wireframes: Agenda dos boxes

Fábrica de Software I · Protótipo em alta fidelidade · Desktop 1440×900 · Perfil Secretária

Estes wireframes mostram a distribuição do trabalho entre os boxes e os mecânicos: a agenda com os boxes em execução, a designação de box e mecânico para uma OS aberta e a conclusão do serviço, que libera o box. A área ainda não tem modelo IFML.

## Telas

| Nº | Tela | Estado | US | UC |
|---|---|---|---|---|
| [8.01](<8.01 - Agenda dos boxes - tela principal (box em execução).svg>) | Agenda dos boxes | Box em execução | #42 | Nenhum |
| [8.02](<8.02 - Concluir serviço.svg>) | Concluir serviço | Padrão | #42, US-028 | UC-009, UC-010, UC-014 |
| [8.03](<8.03 - Agenda dos boxes - serviço concluído (box liberado).svg>) | Agenda dos boxes | Serviço concluído: box liberado | #42 | Nenhum |
| [8.04](<8.04 - Designar box e mecânico.svg>) | Designar box e mecânico | Padrão | #42 | Nenhum |
| [8.05](<8.05 - Confirmação - box designado.svg>) | Confirmação: box designado | Sucesso | #42 | Nenhum |

Os casos de uso (UC) reproduzem os vínculos registrados nas issues do GitLab, conforme o índice de [historias-de-usuario.md](../../../../03-requisitos/historias-de-usuario.md#índice).

## Agenda dos boxes

**8.01 · Agenda dos boxes · Box em execução**

![Agenda dos boxes com busca e o cartão do Box 2 em execução: Honda Civic, placa, OS, mecânico Renan Souza, horário de início e o botão Concluir serviço](<8.01 - Agenda dos boxes - tela principal (box em execução).svg>)

**8.03 · Agenda dos boxes · Serviço concluído: box liberado**

![Agenda dos boxes depois da conclusão, sem nenhum box em execução](<8.03 - Agenda dos boxes - serviço concluído (box liberado).svg>)

## Designar box e mecânico

**8.04 · Designar box e mecânico**

![Tela Designar box e mecânico para a OS-0190, com os dados da OS, a escolha entre seis boxes, em que só os livres podem ser selecionados, o mecânico responsável e o botão Confirmar designação](<8.04 - Designar box e mecânico.svg>)

**8.05 · Confirmação: box designado · Sucesso**

![Janela de confirmação Box designado com sucesso, Box 2 e OS-0190, com o botão Voltar à Agenda dos boxes](<8.05 - Confirmação - box designado.svg>)

## Concluir serviço

**8.02 · Concluir serviço**

![Tela Concluir serviço do Box 1, OS-0186, com veículo, placa, mecânico, horário de início, tempo no box e o botão Confirmar conclusão](<8.02 - Concluir serviço.svg>)

## Regras de comportamento

Cada linha é um cenário Gherkin das histórias da área. A coluna Situação indica se o wireframe mostra o comportamento: **Desenhado**, **Parcial** (a tela existe, mas falta parte do cenário), **Não desenhado** ou **Divergente** (a tela contradiz o cenário). Cenários marcados `@proposta` foram escritos pela equipe de documentação e ainda não estão nas issues.

| Cenário | US | Telas | Situação | Observação |
|---|---|---|---|---|
| Critério registrado na issue | #42 | 8.04 | Parcial | A designação do mecânico está desenhada do lado da secretária; não há a visão do mecânico sobre a própria agenda |
| Designar box e mecânico a uma OS `@proposta` | #42 | 8.04 → 8.05 | Desenhado |  |
| Box ocupado `@proposta` | #42 | 8.04 | Desenhado | Os boxes em execução aparecem desabilitados, com o aviso de que só boxes livres recebem uma nova OS |
| Concluir o serviço `@proposta` | US-028 | 8.02 → 8.03 | Desenhado | O box fica livre após a conclusão |

A US-028 pertence ao RF-06, mas o cenário de conclusão também é atendido por esta área.

## Divergências e achados

| ID | Divergência | Telas | Tratamento proposto |
|---|---|---|---|
| W-26 | A tela de designação (8.04, 8.05) não aparece no site map, que só tem "Lista de box" e "Finalizar serviço do box". | 8.04, 8.05 | Incluir o nó no site map (SM-02) |
| W-27 | A agenda mostra um único box em execução (8.01), enquanto a designação mostra quatro (8.04); depois da conclusão, a agenda fica vazia sem mensagem (8.03). | 8.01, 8.03, 8.04 | Usar os mesmos dados nas telas e desenhar o estado vazio (UX-08) |
| W-28 | O par "Atendimento em curso" e "Cancelar" aparece no cabeçalho da agenda. | 8.01 a 8.04 | Ver UX-06 |
| W-29 | A área não tem modelo IFML. | 8.01 a 8.05 | Modelar a Agenda dos boxes (PN-04) |

## Veja também

- [Wireframes: todas as áreas](../../README.md)
- [Índice das telas](<../0 - Índice.md>)
- [Site map](../../../site-map.md)
- [Protótipo: revisão de usabilidade e pendências](../../../README.md)
- [IFML](../../../ifml/README.md)
- [Histórias de usuário](../../../../03-requisitos/historias-de-usuario.md)
