# Requisitos

Milestone 1 · Fábrica de Software I · Unidade de requisitos

Esta pasta registra o levantamento de requisitos do FilaCidadã, a API de filas de atendimento. Os requisitos funcionais foram derivados do código real do repositório (commit `38b55c7`), das regras de negócio documentadas em `documentacao/` e de entrevistas. As entrevistas deste projeto são **fictícias**: servem de exemplo didático do método, não registram conversas reais.

## Técnicas de elicitação

| Técnica | Fonte | O que produziu |
|---|---|---|
| Análise documental | `README.md`, `documentacao/03-papeis-e-regras.md`, `06-autenticacao.md`, `08-tempo-real.md` | Papéis, regras de estado, códigos de erro, eventos de tempo real |
| Engenharia reversa do código | `src/routes/`, `src/middlewares/`, `src/services/`, `prisma/schema.prisma`, `src/graphql/` | Inventário das rotas REST e operações GraphQL, guardas de acesso, mensagens de negócio |
| Entrevistas (fictícias) | Quatro perfis, uma sessão cada, roteiro semiestruturado | Necessidades por ator e prioridades percebidas |
| Oficina de priorização | Sessão com os quatro atores | Classificação MoSCoW das funcionalidades |
| Validação com o cliente (fictícia) | Sessão de revisão por caso de uso | Aceites, ajustes e decisões registradas |

## Entrevistas (fictícias)

| Data | Entrevistado (fictício) | Ator | Principais achados |
|---|---|---|---|
| 2026-08-11 | Coordenadora de atendimento de uma prefeitura | ACT-03 Administrador da Instituição | Precisa cadastrar operadores, abrir filas e acompanhar senhas por período; quer assumir um atendimento quando o operador se ausenta |
| 2026-08-13 | Operador de guichê | ACT-02 Operador | Emite senha para quem não tem celular; chama, rechama e finaliza; precisa encaminhar o cidadão para outra etapa |
| 2026-08-18 | Cidadã que usa a fila semanalmente | ACT-01 Cidadão | Quer retirar senha pelo QR Code da fila, acompanhar a posição, receber aviso quando for chamada e cancelar se desistir |
| 2026-08-20 | Administradora da plataforma | ACT-04 Administrador da Plataforma | Aprova ou rejeita instituições com motivo, pode reconsiderar uma rejeição, precisa de dashboard geral e de auditoria |

## Oficina de priorização

Data: 2026-08-25 (fictícia). Participaram os quatro atores representados nas entrevistas. Cada funcionalidade recebeu uma classe MoSCoW:

- **Must**: sem ela o fluxo principal (cadastrar, emitir senha, chamar, finalizar) não funciona.
- **Should**: agrega valor forte, mas o fluxo principal funciona sem ela.
- **Could**: desejável, entra se houver tempo.
- **Won't**: fora desta entrega (não há itens nesta classe no levantamento atual).

## Validação com o cliente

Data: 2026-09-08 (fictícia). Método: revisão, caso de uso a caso de uso (UC-01 a UC-15), do texto de cada requisito, com o cliente lendo a tabela de RF e confirmando o comportamento esperado.

Resultado (fictício):

- Aceitos sem alteração: a maior parte dos RF.
- Ajustados: RF-010 (mensagem de nome duplicado), RF-037 (prioridade só quando a fila a habilita), RF-040 (rechamar apenas pelo operador responsável), RF-060 (cancelamento só enquanto aguardando) e RF-064 (notificações exibidas também ao administrador).
- Incluídos: nenhum requisito novo nesta rodada.
- Divergências entre código e documentação levantadas na sessão: listadas no fim de [requisitos-funcionais.md](requisitos-funcionais.md).

## Método de análise

1. Inventário: listar todas as rotas REST e operações GraphQL com método, caminho e middleware de acesso.
2. Agrupamento: atribuir cada rota a um caso de uso do catálogo (UC-01 a UC-15). Quando nenhum UC cobre a rota, atribuir ao mais próximo e registrar em Divergências.
3. Redação verificável: cada RF traz ator, comportamento observável e, quando a regra existe no código, o código de resposta de erro (400, 403, 409 etc.).
4. Priorização: MoSCoW pela oficina. Para o campo Milestone, usamos o critério Must = M1, Should = M2, Could = M3.
5. Rastreabilidade: cada RF aponta para um UC; a tabela de mapeamento UC para RF no fim de `requisitos-funcionais.md` alimenta as demais entregas.
6. Conferência: todos os RF foram comparados, item a item, com a rota correspondente em `src/routes/`.

## Convenções de identificação

| Prefixo | Significado | Exemplo |
|---|---|---|
| `UC-NN` | Caso de uso (catálogo fixo) | UC-08 Emitir senha online |
| `RF-NNN` | Requisito funcional, agrupado por UC | RF-034 |
| `RNF-NNN` | Requisito não funcional | RNF-001 |
| `US-NNN` | História de usuário | US-001 |
| `ACT-NN` | Ator | ACT-02 Operador |
| `T-<perfil>-NN` | Tela (wireframe) | T-CID-01 |

## Atores

| ID | Ator | Papel no sistema (`src/constants/roles.js`) |
|---|---|---|
| ACT-01 | Cidadão | `USUARIO_FINAL` |
| ACT-02 | Operador | `OPERADOR` |
| ACT-03 | Administrador da Instituição | `ADMIN_INSTITUICAO` |
| ACT-04 | Administrador da Plataforma | `ADMIN_PLATAFORMA` |

Visitante é quem não está autenticado. Não é ator do catálogo; aparece no texto dos requisitos como "visitante (sem login)".

## Arquivos desta pasta

- [requisitos-funcionais.md](requisitos-funcionais.md): RF-001 a RF-065, mapeamento UC para RF e divergências.
- `requisitos-nao-funcionais.md`: RNF (frente de requisitos não funcionais).
- `historias-de-usuario.md`: US derivadas dos UC.
- `backlog.md`: ordenação dos itens por prioridade e milestone.
- `rastreabilidade-requisitos.svg`: diagrama de rastreabilidade entre UC, RF e US.

## Veja também

- [Visão do produto](../01-visao/README.md)
- [Casos de uso](../05-modelagem/casos-de-uso/README.md)
- [Protótipo e telas](../04-prototipo/README.md)
- [Matriz de rastreabilidade](../07-rastreabilidade/matriz.md)
- [Requisitos funcionais](requisitos-funcionais.md)
- [Requisitos não funcionais](requisitos-nao-funcionais.md)
- [Histórias de usuário](historias-de-usuario.md)
- [Backlog](backlog.md)
