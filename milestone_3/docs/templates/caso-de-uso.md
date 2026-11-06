# Modelo de caso de uso

Contexto de ensino: Engenharia de Software (Fábrica de Software I), modelagem de requisitos. Use este modelo para cada UC do catálogo (UC-01 a UC-15).

| Campo | Conteúdo |
|---|---|
| ID | `UC-NN` (catálogo fixo, não se renumera) |
| Nome | Verbo no infinitivo e objeto, por exemplo "Emitir senha online" |
| Ator principal | ACT-01 Cidadão, ACT-02 Operador, ACT-03 Administrador da Instituição ou ACT-04 Administrador da Plataforma |
| Atores secundários | Sistema, NPaaS (e-mail e push), Garage (armazenamento) |
| Pré-condições | Estado que precisa existir antes do início |
| Gatilho | Evento que inicia o caso de uso |
| Pós-condições | Estado após o sucesso, e após a falha quando relevante |

## Fluxo principal

1. Ator faz a ação.
2. Sistema responde.
3. Continua até o fim do caso de uso.

## Fluxos alternativos e de exceção

| Passo | Condição | Tratamento |
|---|---|---|
| 2a | Descrever a condição | Resposta ou erro esperado, com o código HTTP ou `extensions.code` |

## Regras de negócio

- Regra com origem no código ou em decisão registrada, citando o arquivo ou o ADR.

## Relacionamentos

- Requisitos funcionais: RF-NNN (mapeamento em `docs/03-requisitos/requisitos-funcionais.md`)
- Histórias de usuário: US-NNN (ver `docs/03-requisitos/historias-de-usuario.md`)
- Telas: T-<perfil>-NN (ver `docs/04-prototipo/`)
- Papéis do código: `ADMIN_PLATAFORMA`, `ADMIN_INSTITUICAO`, `OPERADOR`, `USUARIO_FINAL` (`src/constants/roles.js`)

## Veja também

- [Modelo de história de usuário](historia-de-usuario.md)
- [Modelo de requisito](requisito.md)
- [Casos de uso (diagrama)](../05-modelagem/casos-de-uso/casos-de-uso.svg)
- [Índice de ADRs](../adr/README.md)
