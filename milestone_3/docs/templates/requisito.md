# Modelo de requisito

Contexto de ensino: Engenharia de Software (Fábrica de Software I), especificação de requisitos. Requisitos funcionais usam `RF-NNN`, não funcionais `RNF-NNN`. A numeração segue a ordem dos casos de uso.

| Campo | Conteúdo |
|---|---|
| ID | `RF-NNN` ou `RNF-NNN` |
| Tipo | Funcional, ou não funcional (desempenho, segurança, usabilidade, disponibilidade, manutenibilidade etc.) |
| Caso de uso | `UC-NN` |
| Prioridade | Alta, média ou baixa |
| Status | Proposto, aprovado, implementado ou verificado |

## Descrição

Enunciado único, verificável, no formato "O sistema deve <comportamento>" (funcional) ou "O sistema deve <atributo> <medida>" (não funcional).

## Critério de verificação

Como se prova que o requisito foi atendido: teste automatizado (com o arquivo ou a suíte), inspeção de código, medição ou demonstração em tela.

| Método | Evidência |
|---|---|
| Teste automatizado | Caminho do arquivo de teste |
| Inspeção | Trecho de código ou configuração |

## Rastreabilidade

- Origem: RFP, PM Canvas, entrevista ou decisão registrada (ADR)
- Histórias: US-NNN
- Classes ou telas afetadas: nomes de `docs/05-modelagem/classes/` e códigos `T-<perfil>-NN`
- Matriz: ver `docs/07-rastreabilidade/matriz.md`

## Veja também

- [Modelo de caso de uso](caso-de-uso.md)
- [Modelo de história de usuário](historia-de-usuario.md)
- [Requisitos funcionais](../03-requisitos/requisitos-funcionais.md)
- [Requisitos não funcionais](../03-requisitos/requisitos-nao-funcionais.md)
- [Matriz de rastreabilidade](../07-rastreabilidade/matriz.md)
