# Como contribuir

Milestones M1, M2 e M3 · Unidade: Engenharia de Software (Fábrica de Software I)

Este guia define o fluxo de trabalho no GitLab para código e documentação do FilaCidadã: como abrir issues, nomear branches, abrir merge requests (MR) e saber quando um item está pronto. Vale para todos os integrantes da equipe, sem exceção para documentação.

## Fluxo em uma linha

Issue no quadro, branch a partir de `main`, commits que citam a issue, MR para `main`, revisão por outra pessoa, validação em QA, merge e fechamento.

## Issues

- Toda mudança nasce de uma issue. Sem issue, não há branch.
- Título curto no imperativo: "Cadastrar operador na instituição".
- A descrição cita os IDs do catálogo que a issue toca: caso de uso (UC-xx), requisito (RF-xxx), história (US-xxx) ou tela (T-<perfil>-NN). Os IDs estão no [índice do projeto](README.md).
- Histórias seguem o modelo [historia-de-usuario.md](templates/historia-de-usuario.md). Mudanças de decisão de arquitetura seguem o [adr.md](templates/adr.md) e entram em `adr/`.
- Os critérios de aceite ficam na própria issue, antes de ela sair de `workflow::Backlog`.

### Labels de workflow

Cada issue tem exatamente um label de workflow por vez. Ele é um label com escopo (`workflow::`), para que a troca de um remova o anterior.

| Label | Significado | Quem move |
|---|---|---|
| `workflow::Backlog` | Registrada e sem prioridade definida no milestone | Gerente de projeto |
| `workflow::Opened` | Priorizada, com critérios de aceite e responsável; aguarda início | Gerente de projeto |
| `workflow::Doing` | Em desenvolvimento, com branch criada | Responsável pela issue |
| `workflow::Review` | MR aberto, em revisão de código ou de documento | Responsável pela issue |
| `workflow::QA` | Revisão aprovada; em validação contra os critérios de aceite | Pessoa de qualidade ou revisora |
| `workflow::Closed` | MR mesclado e issue fechada | Automático pelo MR (`Closes #n`) |

Transições normais: `Backlog`, `Opened`, `Doing`, `Review`, `QA`, `Closed`. Se a QA reprovar, a issue volta para `Doing`. Uma issue só vai para `Closed` quando o MR é mesclado, e não por edição manual do label.

## Branches

- Uma issue, uma branch, criada a partir de `main` atualizada.
- Nome: `<número-da-issue>-<resumo-em-kebab-case>`. Exemplo: `12-cadastro-operador`.
- Nunca commitar direto em `main`.
- Atualize a branch a partir de `main` antes de abrir o MR, e resolva conflitos na própria branch.
- Antes de reescrever histórico de branch já publicada, confirme com a equipe.

## Commits

- Mensagem em português, na primeira linha com até 72 caracteres, no mesmo estilo do histórico do repositório: `Adiciona fila de senhas presenciais`.
- Cite a issue no corpo ou na linha final: `Refs #12`.
- Um commit por mudança lógica. Commit com mistura de assuntos é devolvido na revisão.
- Nada de `.env`, senha, token ou chave. O pipeline de detecção de segredos (`.gitlab-ci.yml`) bloqueia o MR que os contém, mas o certo é não commitar.

## Merge request

- Destino: `main`. Título igual ao da issue, com o número: `#12 Cadastrar operador na instituição`.
- Descrição: o que mudou, como validar e `Closes #12`. A linha `Closes` fecha a issue ao mesclar.
- Marque o label `workflow::Review` quando abrir o MR.
- Pelo menos uma revisão de pessoa diferente do autor. Quem escreveu não aprova o próprio MR.
- O pipeline precisa estar verde. Hoje ele roda SAST e detecção de segredos; não há job de testes (ver [Deploy e CI](../documentacao/15-deploy.md)), então os testes do código são rodados localmente.
- Mescle com "squash" e apague a branch após o merge.

### Revisão

- A revisora confere o MR contra os critérios de aceite da issue e contra os IDs citados.
- Para código, verifique regras de negócio, escopo por instituição e o contrato da API. Para documento, verifique links, numeração e consistência com o catálogo de IDs.
- Comentários que pedem mudança precisam estar resolvidos antes de ir para `workflow::QA`.

### QA

- A validação é feita por alguém que não escreveu a mudança.
- Para código, rode `npm test` (suíte completa, com banco de teste separado). Para o caminho alterado, rode também o teste específico.
- Para API, execute o caminho feliz e pelo menos uma falha prevista no critério (por exemplo, 403 para papel sem permissão).
- Para documento, confira os links relativos e a numeração de seções.

## Critério de pronto

Uma issue só vai para `workflow::Closed` quando todos os itens abaixo são verdadeiros:

- [ ] Os critérios de aceite da issue foram verificados em QA, item a item.
- [ ] O código ou o documento foi revisado por outra pessoa e os comentários estão resolvidos.
- [ ] Os testes passam (`npm test`), e a regra nova tem teste que falharia sem a mudança.
- [ ] O pipeline está verde, sem alerta de SAST ou de segredo.
- [ ] Nenhum segredo entrou no diff.
- [ ] A documentação afetada foi atualizada: contrato da API em `documentacao/` e artefatos em `docs/`.
- [ ] Os IDs da mudança (UC, RF, US, T) estão refletidos em `docs/07-rastreabilidade/matriz.md`.
- [ ] Mudança entregue tem linha em [CHANGELOG](CHANGELOG.md), na seção do milestone atual.
- [ ] A issue está fechada pelo MR e com label `workflow::Closed`.

## Papéis no fluxo

| Papel | Responsabilidade no fluxo |
|---|---|
| Gerente de projeto | Prioriza o backlog, define o milestone e move `Backlog` e `Opened` |
| Responsável pela issue | Cria a branch, abre o MR e move `Doing` e `Review` |
| Revisora | Revisa o MR e aprova ou pede mudanças |
| Pessoa de qualidade | Valida em `QA` e reabre a issue se houver falha |

Veja também: [Índice do projeto](README.md) · [CHANGELOG](CHANGELOG.md) · [Templates](templates/) · [Deploy e CI](../documentacao/15-deploy.md) · [Testes](../documentacao/14-testes.md) · [Backlog](03-requisitos/backlog.md)
