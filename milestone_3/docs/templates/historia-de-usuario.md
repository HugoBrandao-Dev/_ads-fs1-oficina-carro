# Modelo de história de usuário

Contexto de ensino: Engenharia de Software (Fábrica de Software I), backlog e requisitos. Cada história pertence a um caso de uso e recebe um ID `US-NNN` na ordem dos UC.

| Campo | Conteúdo |
|---|---|
| ID | `US-NNN` |
| Caso de uso | `UC-NN` |
| Ator | ACT-NN (nome do papel conforme `src/constants/roles.js`) |
| Prioridade | Alta, média ou baixa, com justificativa curta |
| Tamanho | Estimativa em pontos ou camisetas, conforme o time |

## História

Como **<ator>**, quero **<ação>**, para **<benefício>**.

## Critérios de aceitação

- Dado **<contexto>**, quando **<ação>**, então **<resultado observável>**.
- Dado **<contexto de erro>**, quando **<ação>**, então **<mensagem ou código de erro>**.

## Requisitos relacionados

- RF-NNN, RNF-NNN

## Observações

- Restrições de papel, de instituição ou de estado da senha que valem para a história.

## Veja também

- [Modelo de caso de uso](caso-de-uso.md)
- [Modelo de requisito](requisito.md)
- [Histórias de usuário (lista)](../03-requisitos/historias-de-usuario.md)
- [Backlog](../03-requisitos/backlog.md)
