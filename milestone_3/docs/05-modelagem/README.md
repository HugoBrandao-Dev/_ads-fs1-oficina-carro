# Modelagem

> Fábrica de Software I · Unidade de modelagem (UML) · Visão geral dos diagramas do FilaCidadã

Este diretório reúne os diagramas que descrevem o sistema antes e além do código. Cada diagrama responde a uma pergunta específica. Se uma pergunta já é respondida por um texto curto, ou pelo próprio código, o diagrama não precisa existir.

## Critério para manter um diagrama

Seguimos a linha de Martin Fowler em *UML Distilled*: a UML serve sobretudo como **esboço** para comunicar uma ideia, não como documentação completa. Daí as regras deste projeto:

1. **Um diagrama, uma pergunta.** Cada arquivo responde a uma questão (quem faz o quê, quais são os estados, em que ordem as mensagens trafegam). Diagrama que tenta responder tudo não responde nada.
2. **Só o que é difícil de ver no texto.** Uma lista de quatro atores não precisa de diagrama; a interação entre quatro partes com dez mensagens precisa.
3. **Notação mínima.** Usamos só os elementos que a pergunta exige. Um caso de uso não ganha atributos; uma classe não ganha operações que o código não tem.
4. **Sincronizado com o código.** Quando um diagrama contradiz o código, o código vence e o diagrama é corrigido. Divergências encontradas ficam registradas no documento da unidade, não escondidas.
5. **Rastreável.** Todo diagrama cita os casos de uso (UC-xx) que cobre. Assim é possível ver se algum UC ficou sem modelo.

## Ordem de leitura

1. [Casos de uso](casos-de-uso/README.md): o escopo, quem são os atores e o que o sistema faz. Ponto de partida.
2. [Classes](classes/README.md): o vocabulário do domínio (Usuário, Papel, Instituição, Fila, Senha e demais). Serve para ler o restante sem ambiguidade.
3. [Estados](estados/README.md): como a senha e a instituição mudam de status, e quais transições são proibidas.
4. [Sequência](sequencia/README.md): a ordem das mensagens entre cidadão, operador, API, banco e tempo real nos casos mais complexos.
5. [Atividades](atividades/README.md): o fluxo de decisão de processos com desvios, como a validação da emissão de senha.
6. [OCL](ocl/README.md): as regras que não cabem no desenho, escritas como restrições formais, e as divergências do segundo marco.

## Mapa diagrama para caso de uso

Esta tabela cobre os UC de cada diagrama. Ela é a referência para o levantamento de cobertura: um UC sem nenhum diagrama aparece na última linha.

| Diagrama | Arquivo | Pergunta que responde | Casos de uso cobertos |
|---|---|---|---|
| Casos de uso | [casos-de-uso.svg](casos-de-uso/casos-de-uso.svg) | Quem faz o quê, e qual é a fronteira do sistema | UC-01 a UC-15 (visão geral) |
| Classes | [classes.svg](classes/classes.svg) | Quais são os conceitos do domínio e como se relacionam | UC-02 a UC-15 |
| Estados da senha | [estado-senha.svg](../../documentacao/diagramas/estados-senha.svg) | Quais estados a senha assume e quais transições são permitidas | UC-08, UC-09, UC-10, UC-11, UC-15 |
| Estados da instituição | `estados/estado-instituicao.svg` (a publicar) | Como uma solicitação passa de pendente a aprovada ou rejeitada | UC-03, UC-04 |
| Sequência | `sequencia/seq-*.svg` (a publicar) | Em que ordem as partes trocam mensagens em um caso de uso | UC-08 (emitir online com QR Code), UC-10 (chamar senha e notificar), UC-04 (aprovar instituição) |
| Atividades | `atividades/ativ-*.svg` (a publicar) | Quais decisões e desvios existem em um processo | UC-08 (validações em ordem), UC-10 (chamar, rechamar, assumir), UC-12 (regenerar QR Code) |
| OCL | `ocl/divergencias-m2.md` (a publicar) | Quais regras são restrições formais e onde o código diverge delas | UC-08, UC-10, UC-12 |

Os casos de uso sem cobertura de diagrama de interação ou de estado são tratados só no texto de especificação. Isso é intencional: UC-02, UC-05, UC-06, UC-07, UC-13 e UC-14 são CRUD ou consulta, e um diagrama adicionaria pouco. A lista definitiva de nomes de arquivo é fechada pelas frentes responsáveis; os nomes marcados "a publicar" ainda não existem.

## Veja também

- [Casos de uso (diagrama e especificação dos UC-01 a UC-15)](casos-de-uso/README.md)
- [Requisitos funcionais](../03-requisitos/requisitos-funcionais.md)
- [Histórias de usuário](../03-requisitos/historias-de-usuario.md)
- [Glossário](../01-visao/glossario.md)
- [Processo: fluxo as-is](../02-processo/bpmn/README.md)
