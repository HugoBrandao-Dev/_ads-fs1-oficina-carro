# RFP: sistema de filas para atendimento público

Fábrica de Software I · Milestone 1 · documento de partida

> **Documento fictício, para fins didáticos.** O órgão, as pessoas, os números e os prazos são inventados para o exercício. Este texto traz necessidades, não requisitos prontos. Cabe ao grupo transformar cada necessidade em requisitos, casos de uso e histórias de usuário.

## 1. Órgão solicitante

Município de Exemplo (fictício), por meio de sua Secretaria de Atendimento ao Cidadão (fictícia). A secretaria atende em três unidades: protocolo de documentos, emissão de certidões e atendimento a benefícios. Cada unidade tem balcões e, hoje, controla a fila em papel.

## 2. Contexto

Nos dias de maior movimento, as filas chegam a algumas dezenas de pessoas. O cidadão não sabe quanto vai esperar e não tem como saber se ainda vale ficar. O servidor não tem registro de quem foi atendido, por quem nem em quanto tempo. A secretaria quer reduzir a espera no balcão e passar a ter números para planejar o atendimento.

A secretaria também quer aceitar retirada de senha pelo celular, sem obrigar o cidadão a estar fisicamente na fila para entrar nela.

## 3. Objeto da contratação

Um sistema web e uma API para:

- emitir senha pela internet e no balcão;
- acompanhar a posição na fila;
- chamar, rechamar, transferir e finalizar atendimentos;
- configurar, por unidade, filas, mesas, etapas e QR Codes;
- consultar painéis e a trilha de auditoria.

A plataforma deve atender mais de um órgão. Os dados de cada órgão ficam isolados dos demais.

## 4. Necessidades do cliente

As necessidades estão em linguagem de negócio. Cada uma deve virar um ou mais requisitos.

| Código | Necessidade |
|---|---|
| N01 | O cidadão retira senha pelo celular e vê a própria posição na fila. |
| N02 | O atendente emite senha no balcão para quem não tem conta. |
| N03 | Em fila presencial, o cidadão prova que está no local com o QR Code do balcão. O código troca e expira. |
| N04 | O cidadão é avisado quando for chamado e quando for o próximo. |
| N05 | O atendente chama, rechama, assume o atendimento de outro colega e finaliza ou cancela. |
| N06 | Há prioridades legais e prioridade por fidelidade, configuráveis por fila. |
| N07 | O administrador da unidade cria filas, mesas, tipos de etapa, QR Codes e usuários da própria unidade. |
| N08 | O administrador geral aprova ou rejeita pedidos de cadastro de órgão e gerencia usuários de todos. |
| N09 | Um atendimento pode passar por mais de uma etapa (por exemplo, triagem, atendimento e entrega), com histórico. |
| N10 | Cidadão e atendente conversam pelo sistema enquanto o atendimento está em andamento. |
| N11 | A unidade tem um painel com volume e tempos, e toda ação administrativa fica registrada. |
| N12 | Site e aplicativo móvel funcionam com a mesma regra de negócio. |

## 5. Usuários

| Perfil | Quem é | O que faz no sistema |
|---|---|---|
| Cidadão | Pessoa que precisa do serviço | Retira senha, acompanha, cancela a própria senha |
| Operador | Servidor no balcão | Emite senha presencial, chama, atende e finaliza |
| Administrador da unidade | Chefe da unidade | Configura a unidade, seus usuários e seus QR Codes; também atende |
| Administrador geral | Equipe da secretaria que cuida da plataforma | Aprova órgãos e administra usuários de todos |

## 6. Restrições

- **Dados pessoais:** o tratamento segue a LGPD. Pede-se finalidade declarada, coleta mínima e possibilidade de o cidadão ver os próprios dados.
- **Acessibilidade:** as telas públicas seguem a WCAG 2.1 no nível AA.
- **Integrações:** e-mail e notificações push passam por um serviço externo já contratado pela secretaria. Não há SMTP próprio.
- **Software:** sem licença paga de software de base. Serviços externos, se houver, têm custo informado na proposta.
- **Prazo:** as entregas seguem o calendário da disciplina (ver seção 10).

## 7. Fora do escopo

- Pagamento de taxas.
- Agendamento de atendimento para data futura.
- Integração com prontuários ou com cadastros de cidadãos de outros órgãos.

## 8. Critérios de aceitação gerais

- Um operador chama a senha seguinte sem recarregar a tela.
- Nenhuma ação administrativa acontece sem registro na auditoria.
- Um administrador de um órgão não vê dados de outro órgão.
- Um cidadão não consegue retirar senha em uma fila presencial sem o QR Code válido.
- Os valores e prazos dos critérios específicos são definidos na análise, com base nas respostas da seção 12.

## 9. Entregáveis esperados

- Visão do produto, PM Canvas e glossário.
- Requisitos funcionais, não funcionais, histórias de usuário e backlog.
- Protótipo de telas (wireframes) por perfil e mapa do site.
- Modelagem: casos de uso, classes, sequência, atividades e estados.
- Modelo de dados (conceitual, lógico, dicionário e script de criação).
- API implementada, testada e documentada.
- Matriz de rastreabilidade entre visão, requisitos, modelos e código.

## 10. Calendário

Datas definidas pelo professor da disciplina, por milestone. Não há data neste documento.

## 11. Como o grupo será avaliado

- Aderência das entregas às necessidades N01 a N12.
- Consistência entre os artefatos: cada requisito deve chegar a um caso de uso, a uma história e a um trecho de código.
- Clareza da documentação e das decisões registradas.

## 12. Perguntas em aberto ao cliente

Estas perguntas devem ser respondidas antes da análise. Enquanto não houver resposta, a equipe registra a premissa adotada.

1. Quanto tempo uma senha online vale antes de expirar, se é que expira?
2. Quais prioridades legais a unidade atende, e quem comprova a elegibilidade?
3. Filas online dispensam o QR Code? Filas presenciais exigem sempre?
4. Por quais canais o cidadão quer ser avisado: no sistema, por e-mail, por notificação push, ou todos?
5. Quem pode cancelar uma senha? Só o próprio cidadão, ou também o atendente?
6. Quantas unidades e balcões cada órgão tem, em média e no pico?
7. Por quanto tempo a auditoria deve ser guardada?
8. Quais metas de tempo de espera a secretaria quer atingir?

## Veja também

- [Visão do produto](README.md)
- [PM Canvas](pm-canvas.md)
- [Glossário](glossario.md)
- [Requisitos funcionais](../03-requisitos/requisitos-funcionais.md)
- [Histórias de usuário](../03-requisitos/historias-de-usuario.md)
