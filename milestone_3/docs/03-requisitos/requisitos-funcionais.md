# Requisitos funcionais

Milestone 1 · Fábrica de Software I · Unidade de requisitos

Derivados do código do repositório (commit `38b55c7`). Cada RF tem ator, prioridade MoSCoW, caso de uso de origem, endpoint(s) REST ou GraphQL e milestone (Must = M1, Should = M2, Could = M3). Quando a regra existe no código, a descrição cita o código de resposta de erro. Os endpoints REST são caminhos a partir da raiz da API; as rotas de autenticação do BetterAuth ficam sob `/api/auth/*`.

## UC-01 Autenticar-se

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-001 | Cadastrar conta de cidadão | Com nome, e-mail e senha (mínimo 8 caracteres), cria o usuário sem papel administrativo e sem autenticá-lo. E-mail já existente responde 422 | ACT-01 (visitante) | Must | UC-01 | `POST /api/auth/sign-up/email` | M1 |
| RF-002 | Autenticar com e-mail e senha | Credencial válida devolve cookie de sessão e o cabeçalho `set-auth-token`. Credencial inválida responde 401. `GET /auth/me` devolve id, papéis, instituição e fuso do usuário logado | ACT-01, ACT-02, ACT-03, ACT-04 | Must | UC-01 | `POST /api/auth/sign-in/email`; `GET /auth/me` | M1 |
| RF-003 | Encerrar sessão | Sign-out apaga a sessão no banco e a revogação vale no request seguinte. Sem sessão válida, a API responde 498 | Usuário autenticado | Must | UC-01 | `POST /api/auth/sign-out` | M1 |
| RF-004 | Redefinir senha por e-mail | Pedido de recuperação responde do mesmo modo exista ou não o e-mail. O link de redefinição, enviado pelo NPaaS, permite definir nova senha | Usuário (qualquer) | Should | UC-01 | `POST /api/auth/request-password-reset`; `POST /api/auth/reset-password` | M2 |

## UC-02 Gerenciar perfil

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-005 | Consultar e editar o próprio perfil | `GET /me` devolve o próprio usuário. `PATCH /me` altera nome e e-mail (campos aceitos pelo `PerfilUpdateSchema`); e-mail já em uso é recusado | Usuário autenticado | Must | UC-02 | `GET /me`; `PATCH /me` | M1 |
| RF-006 | Alterar a própria senha | Com a senha atual correta, grava a nova senha. Senha atual incorreta responde com a mensagem "Senha atual incorreta" | Usuário autenticado | Must | UC-02 | `PATCH /me/senha` | M1 |
| RF-007 | Gerenciar foto de perfil | Envia imagem de avatar (multer valida tipo e tamanho) e remove o avatar atual | Usuário autenticado | Could | UC-02 | `POST /me/avatar`; `DELETE /me/avatar` | M3 |
| RF-008 | Listar fusos horários | Devolve a lista de fusos IANA aceitos, usada para o campo `fusoHorario` do perfil e nas estatísticas. Rota pública | Qualquer um | Should | UC-02 | `GET /timezones` | M2 |

## UC-03 Solicitar cadastro de instituição

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-009 | Solicitar cadastro de instituição | Qualquer usuário autenticado envia a solicitação. A instituição nasce com status `PENDENTE`, grava o solicitante e notifica os administradores da plataforma (`SOLICITACAO_INSTITUICAO`) | ACT-01 | Must | UC-03 | `POST /instituicoes/solicitar` | M1 |
| RF-010 | Impedir nome de instituição duplicado | Nome já cadastrado responde 409 e não cria registro (restrição de unicidade no banco) | ACT-01 | Must | UC-03 | `POST /instituicoes/solicitar`; `POST /instituicoes` | M1 |
| RF-011 | Exibir página pública de apresentação | Devolve os dados da landing page sem exigir login. Somente leitura: não há rota de escrita | Visitante | Could | UC-03 | `GET /landing-page` | M3 |

## UC-04 Avaliar solicitação de instituição

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-012 | Aprovar solicitação | Só o administrador da plataforma aprova. Aprova instituição `PENDENTE` ou `REJEITADA` (outros status: 400), grava `aprovadoPorId` e `aprovadoEm` e notifica o solicitante (`INSTITUICAO_APROVADA`) | ACT-04 | Must | UC-04 | `PATCH /instituicoes/:id/aprovar` | M1 |
| RF-013 | Rejeitar solicitação com motivo | Só o administrador da plataforma rejeita, e só instituição `PENDENTE` (outros status: 400). Grava `motivoRejeicao` e notifica o solicitante (`INSTITUICAO_REJEITADA`) | ACT-04 | Must | UC-04 | `PATCH /instituicoes/:id/rejeitar` | M1 |
| RF-014 | Reconsiderar instituição rejeitada | Muda status `REJEITADA` para `PENDENTE`. Outros status: 400 | ACT-04 | Should | UC-04 | `PATCH /instituicoes/:id/reconsiderar` | M2 |
| RF-015 | Anexar contrato em PDF | Recebe arquivo até 10 MB e vincula o contrato à instituição. Só o administrador da plataforma | ACT-04 | Should | UC-04 | `POST /instituicoes/:id/contrato` | M2 |
| RF-016 | Cadastrar instituição diretamente | Administrador da plataforma cria instituição já aprovada, sem passar pela solicitação. Nome duplicado responde 409 | ACT-04 | Should | UC-04 | `POST /instituicoes` | M2 |
| RF-017 | Consultar instituições | Lista e detalha instituições com paginação. Administrador da plataforma vê todas; administrador da instituição vê só a sua | ACT-03, ACT-04 | Must | UC-04 | `GET /instituicoes`; `GET /instituicoes/:instituicaoId` | M1 |
| RF-018 | Atualizar dados da instituição | Altera dados cadastrais. Administrador da instituição altera só a própria; administrador da plataforma altera qualquer uma | ACT-03, ACT-04 | Should | UC-04 | `PATCH /instituicoes/:instituicaoId` | M2 |
| RF-019 | Excluir instituição em cascata | Só o administrador da plataforma exclui. Remove tipos de etapa, filas, mesas, QR Codes, senhas e flows. Instituição com flow já usado por senhas não pode ser excluída (FK restrita) | ACT-04 | Could | UC-04 | `DELETE /instituicoes/:id` | M3 |

## UC-05 Gerenciar usuários e papéis

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-020 | Listar e detalhar usuários | Lista usuários com paginação e detalha por id. Administrador da instituição vê só usuários da própria instituição (403 para os demais) | ACT-03, ACT-04 | Must | UC-05 | `GET /usuarios`; `GET /usuarios/:id`; `GET /instituicoes/:instituicaoId/usuarios` | M1 |
| RF-021 | Cadastrar usuário com papel e convite | Cria usuário na instituição com um ou mais papéis e dispara o e-mail de definição de senha (convite). Papel administrativo sem `instituicaoId` responde 400 | ACT-03, ACT-04 | Must | UC-05 | `POST /instituicoes/:instituicaoId/usuarios` | M1 |
| RF-022 | Alterar dados e papéis de usuário | Altera campos do usuário; quando envia `papeis`, substitui o conjunto de papéis e invalida o cache de papéis. Usuário de outra instituição responde 403 | ACT-03, ACT-04 | Must | UC-05 | `PATCH /usuarios/:id` | M1 |
| RF-023 | Remover usuário | Remove o usuário quando o ator tem permissão sobre ele. Sem permissão responde 403 com "Sem permissão para remover este usuário" | ACT-03, ACT-04 | Should | UC-05 | `DELETE /usuarios/:id` | M2 |
| RF-024 | Bloquear acesso de usuário inativo | Usuário com `ativo: false` autentica, mas recebe 403 em toda rota protegida. Papéis removidos valem no request seguinte | Sistema | Must | UC-05 | Todas as rotas com `AuthMiddleware` | M1 |

## UC-06 Gerenciar filas

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-025 | Listar e consultar filas | Lista filas com paginação e detalha por id. Usuário sem administrador da plataforma vê só as filas da própria instituição | Usuário autenticado | Must | UC-06 | `GET /filas`; `GET /filas/:id` | M1 |
| RF-026 | Criar fila | Cria fila com tipo de atendimento `ONLINE`, `PRESENCIAL` ou `HIBRIDO`, mesas e prioridades habilitadas. Instituição inválida ou inativa responde 400. Só administrador da instituição e operador | ACT-02, ACT-03 | Must | UC-06 | `POST /filas` | M1 |
| RF-027 | Atualizar fila | Altera os dados da fila da própria instituição. Emite `fila:atualizada` para a instituição | ACT-02, ACT-03 | Must | UC-06 | `PATCH /filas/:id` | M1 |
| RF-028 | Remover fila | Só o administrador da instituição remove fila da própria instituição. Emite `fila:removida` | ACT-03 | Should | UC-06 | `DELETE /filas/:id` | M2 |
| RF-029 | Consultar flows | Lista e detalha flows de atendimento da instituição | ACT-02, ACT-03, ACT-04 | Should | UC-06 | `GET /flows`; `GET /flows/:id` | M2 |
| RF-030 | Criar flow de atendimento | Cria flow com steps apontando para filas da própria instituição (fila de outra instituição: 400). `ordem` não se repete e transições ligam apenas steps do mesmo flow. Um flow sem step responde 400 | ACT-03 | Should | UC-06 | `POST /flows` | M2 |
| RF-031 | Atualizar, desativar e remover flow | Altera o flow; desativa sem apagar; remove só se nenhuma senha já passou por ele (409 com a mensagem "Desative-o em vez disso") | ACT-03 | Should | UC-06 | `PUT /flows/:id`; `PATCH /flows/:id/desativar`; `DELETE /flows/:id` | M2 |

## UC-07 Configurar tipos de etapa

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-032 | Consultar tipos de etapa | Lista os tipos de etapa da instituição. Administrador da instituição e operador só consultam a própria | ACT-02, ACT-03, ACT-04 | Should | UC-07 | `GET /instituicoes/:instituicaoId/tipos-etapa` | M2 |
| RF-033 | Substituir lista de tipos de etapa | Recebe a lista completa e substitui a anterior de uma vez; não há inclusão ou remoção parcial | ACT-03, ACT-04 | Should | UC-07 | `PUT /instituicoes/:instituicaoId/tipos-etapa` | M2 |

## UC-08 Emitir senha online

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-034 | Emitir senha digital | Cidadão cria senha em fila ativa com status `AGUARDANDO`, número e posição calculados numa transação. Usuário que já tem senha `AGUARDANDO` ou `EM_ATENDIMENTO` na mesma fila recebe 409. Emite `senha:criada` e notifica operadores (`SENHA_NOVA_NA_FILA`) | ACT-01 | Must | UC-08 | `POST /filas/:filaId/senhas` | M1 |
| RF-035 | Localizar fila pelo código do QR Code | Sem login, devolve nome, tipo e instituição da fila a partir do código do QR Code. Código não encontrado responde 404 | Visitante | Must | UC-08 | `GET /qrcodes/buscar/:codigo` | M1 |
| RF-036 | Consultar contagem de senhas da fila | Devolve quantas senhas estão aguardando e em atendimento, sem exigir papel administrativo | ACT-01 | Should | UC-08 | `GET /filas/:id/senhas/contagem` | M2 |
| RF-037 | Aplicar prioridade habilitada pela fila | `LEGAL` só vale se a fila tiver prioridades habilitadas; `FIDELIDADE` só se tiver fidelidade habilitada. Caso contrário a senha vira `NORMAL`. A prioridade define a posição inicial, sem reordenação posterior | ACT-01 | Should | UC-08 | `POST /filas/:filaId/senhas` | M2 |

## UC-09 Emitir senha presencial

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-038 | Emitir senha presencial | Operador ou administrador da instituição cria senha para cidadão sem celular, informando o nome do cidadão (sem `usuarioId`). A fila precisa ser da instituição do operador (403). Não exige QR Code | ACT-02, ACT-03 | Must | UC-09 | `POST /filas/:filaId/senhas/presencial` | M1 |

## UC-10 Chamar, rechamar e assumir senha

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-039 | Chamar senha | Só senha `AGUARDANDO` pode ser chamada (409 caso contrário). Grava `operadorId`, `mesa` e `mesaNome`, muda para `EM_ATENDIMENTO` e notifica o cidadão (`SENHA_CHAMADA`) e o próximo da fila (`SENHA_PROXIMA`). Operador com outra senha em atendimento recebe 409; mesa ocupada recebe 409 | ACT-02, ACT-03 | Must | UC-10 | `POST /senhas/:id/chamar` | M1 |
| RF-040 | Rechamar senha | Só o operador responsável pode rechamar (403 para os demais). Reenvia a chamada aos painéis e ao cidadão, sem criar nova notificação persistida | ACT-02 | Should | UC-10 | `POST /senhas/:id/rechamar` | M2 |
| RF-041 | Assumir atendimento de outro operador | Administrador da instituição assume a senha `EM_ATENDIMENTO` e vira o operador responsável. Notifica o operador anterior (`SENHA_TRANSFERIDA`). Assumir a própria senha responde 409 | ACT-03 | Should | UC-10 | `POST /senhas/:id/assumir` | M2 |
| RF-042 | Consultar atendimento ativo do operador | Devolve a senha `EM_ATENDIMENTO` atribuída ao operador logado, em qualquer fila da instituição | ACT-02, ACT-03 | Must | UC-10 | `GET /senhas/meu-atendimento` | M1 |
| RF-043 | Ingressar senha em flow | Coloca a senha no primeiro step do flow e cria o acompanhamento (uma vez por senha; senha já em flow responde 409). Gera token público se ainda não houver | ACT-02, ACT-03 | Should | UC-10 | `POST /flows/:id/senhas/:senhaId/ingressar` | M2 |
| RF-044 | Encaminhar senha para outro step | Só existe encaminhamento para step com transição do step atual (400 caso contrário). Fecha o histórico atual, move a senha para a fila de destino como `AGUARDANDO` e emite `flow:senha:encaminhada` | ACT-02, ACT-03 | Should | UC-10 | `POST /flows/:id/senhas/:senhaId/encaminhar` | M2 |

## UC-11 Finalizar ou cancelar atendimento

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-045 | Finalizar atendimento | Só senha `EM_ATENDIMENTO` pode ser finalizada (409 caso contrário). Muda para `FINALIZADA`, grava auditoria `FINALIZAR_SENHA` e emite `senha:finalizada` | ACT-02, ACT-03 | Must | UC-11 | `POST /senhas/:id/finalizar` | M1 |
| RF-046 | Cancelar senha pelo administrador | Administrador da instituição ou da plataforma cancela senha `AGUARDANDO` (409 se estiver em outro status). Grava auditoria `CANCELAR_SENHA` | ACT-03, ACT-04 | Must | UC-11 | `POST /senhas/:id/cancelar` | M1 |
| RF-047 | Dar alta no flow | Fecha o acompanhamento como `CONCLUIDO`, finaliza a senha e limpa o flow da senha. Emite `flow:senha:alta`. Flow já concluído ou cancelado responde 409 | ACT-02, ACT-03 | Should | UC-11 | `POST /flows/:id/senhas/:senhaId/alta` | M2 |

## UC-12 Gerenciar QR Codes

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-048 | Listar e consultar QR Codes | Lista e detalha QR Codes da instituição, com escopo por papel | ACT-02, ACT-03, ACT-04 | Must | UC-12 | `GET /qrcodes`; `GET /qrcodes/:id` | M1 |
| RF-049 | Gerar QR Code da fila | Cria QR Code do modo `ROTATIVO` (expira e é renovado pela janela de tolerância) ou `FIXO` (validade de 10 anos). Fila inválida ou inativa responde 400. Emite `qrcode:novo` | ACT-02, ACT-03 | Must | UC-12 | `POST /qrcodes` | M1 |
| RF-050 | Regenerar QR Code | Desativa o QR Code atual e cria outro para a mesma fila. Grava `GERAR_QRCODE` e emite `qrcode:regenerado` | ACT-02, ACT-03 | Should | UC-12 | `POST /qrcodes/regenerar` | M2 |
| RF-051 | Desativar QR Code | Marca o QR Code como inativo; a validação de senha presencial deixa de aceitá-lo | ACT-02, ACT-03 | Should | UC-12 | `PATCH /qrcodes/:id/desativar` | M2 |

## UC-13 Consultar dashboard e estatísticas

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-052 | Consultar dashboard geral da plataforma | Devolve indicadores de todas as instituições. Só o administrador da plataforma (403 para os demais) | ACT-04 | Could | UC-13 | `GET /dashboard/admin` | M3 |
| RF-053 | Consultar dashboard da instituição | Devolve indicadores da instituição do usuário, com o fuso informado para o cálculo de "hoje" | ACT-02, ACT-03, ACT-04 | Should | UC-13 | `GET /dashboard/instituicao` | M2 |
| RF-054 | Consultar estatísticas agregadas de senhas | Conta senhas por status e o total de hoje, no escopo do papel. O fuso informado define o início do dia e a hora de pico | Usuário autenticado | Should | UC-13 | `GET /senhas/stats` | M2 |
| RF-055 | Gerar relatório de senhas por período | Devolve estatísticas de senhas filtradas por período, no escopo do papel | Usuário autenticado | Could | UC-13 | `GET /senhas/stats/relatorio` | M3 |

## UC-14 Consultar auditoria

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-056 | Consultar trilha de auditoria | Lista os registros de auditoria com paginação e filtros. Administrador da instituição vê só a própria instituição | ACT-03, ACT-04 | Should | UC-14 | `GET /auditorias` | M2 |
| RF-057 | Registrar ações do sistema | Toda operação de escrita relevante grava um registro (ação, entidade, autor) do catálogo `AUDITORIA_ACOES`, como `CRIAR_FILA`, `CHAMAR_SENHA` ou `LOGIN` | Sistema | Must | UC-14 | Efeito colateral das rotas de escrita | M1 |

## UC-15 Acompanhar minha senha

| ID | Nome | Descrição verificável | Ator | Prioridade | UC | Endpoint(s) | Milestone |
|---|---|---|---|---|---|---|---|
| RF-058 | Listar minhas senhas | Cidadão lista somente as próprias senhas. Administrador e operador listam as da instituição | ACT-01, ACT-02, ACT-03 | Must | UC-15 | `GET /senhas` | M1 |
| RF-059 | Consultar uma senha | Devolve a senha por id. Cidadão que não é dono recebe 403 ("pertence a outro usuário"); senha de outra instituição recebe 403 | ACT-01, ACT-02, ACT-03, ACT-04 | Must | UC-15 | `GET /senhas/:id` | M1 |
| RF-060 | Cancelar minha senha | Cidadão dono cancela a própria senha enquanto `AGUARDANDO`. Em outro status responde 409 | ACT-01 | Must | UC-15 | `POST /senhas/:id/cancelar` | M1 |
| RF-061 | Acompanhar senha sem login | Com o token público da senha, devolve número, status, posição, fila e step atual. Token inválido responde 404 | Visitante | Should | UC-15 | `GET /publico/senhas/:token/status` | M2 |
| RF-062 | Consultar fluxo da senha | Devolve as transições disponíveis e o status do flow em que a senha está. Senha fora de flow responde 404 | ACT-01, ACT-02, ACT-03 | Could | UC-15 | `GET /senhas/:id/flow/transicoes`; `GET /senhas/:id/flow/status` | M3 |
| RF-063 | Conversar com o operador durante o atendimento | Chat só existe com senha `EM_ATENDIMENTO` (409 caso contrário). Só o cidadão dono e o operador responsável enviam; administradores da instituição leem. Mensagem guarda o nome do autor no envio | ACT-01, ACT-02, ACT-03 | Could | UC-15 | `GET /senhas/:senhaId/chat`; `POST /senhas/:senhaId/chat` | M3 |
| RF-064 | Consultar e marcar notificações | Lista notificações, conta as não lidas e marca uma ou todas como lidas. Notificação não é apagada; marcar como lida emite `notificacao:contagem` | Usuário autenticado | Should | UC-15 | `GET /notificacoes`; `GET /notificacoes/nao-lidas`; `PATCH /notificacoes/:id/lida`; `PATCH /notificacoes/ler-todas` | M2 |
| RF-065 | Receber atualizações em tempo real | Socket.IO entrega ao usuário as mudanças da própria senha (`senha:chamada`, `senha:atualizada`, `senha:finalizada`) e notificações (`notificacao:nova`), sem recarregar a página | Usuário autenticado | Should | UC-15 | Socket.IO (handshake com cookie de sessão) | M2 |

## Mapeamento UC para RF

Tabela consumida pelas demais frentes. Cada RF aparece em um único UC de origem.

| UC | Nome | RF (IDs) | Quantidade | Must | Should | Could |
|---|---|---|---|---|---|---|
| UC-01 | Autenticar-se | RF-001 a RF-004 | 4 | 3 | 1 | 0 |
| UC-02 | Gerenciar perfil | RF-005 a RF-008 | 4 | 2 | 1 | 1 |
| UC-03 | Solicitar cadastro de instituição | RF-009 a RF-011 | 3 | 2 | 0 | 1 |
| UC-04 | Avaliar solicitação de instituição | RF-012 a RF-019 | 8 | 3 | 4 | 1 |
| UC-05 | Gerenciar usuários e papéis | RF-020 a RF-024 | 5 | 4 | 1 | 0 |
| UC-06 | Gerenciar filas | RF-025 a RF-031 | 7 | 3 | 4 | 0 |
| UC-07 | Configurar tipos de etapa | RF-032 a RF-033 | 2 | 0 | 2 | 0 |
| UC-08 | Emitir senha online | RF-034 a RF-037 | 4 | 2 | 2 | 0 |
| UC-09 | Emitir senha presencial | RF-038 | 1 | 1 | 0 | 0 |
| UC-10 | Chamar, rechamar e assumir senha | RF-039 a RF-044 | 6 | 2 | 4 | 0 |
| UC-11 | Finalizar ou cancelar atendimento | RF-045 a RF-047 | 3 | 2 | 1 | 0 |
| UC-12 | Gerenciar QR Codes | RF-048 a RF-051 | 4 | 2 | 2 | 0 |
| UC-13 | Consultar dashboard e estatísticas | RF-052 a RF-055 | 4 | 0 | 2 | 2 |
| UC-14 | Consultar auditoria | RF-056 a RF-057 | 2 | 1 | 1 | 0 |
| UC-15 | Acompanhar minha senha | RF-058 a RF-065 | 8 | 3 | 3 | 2 |

Total: 65 RF. Must 30, Should 28, Could 7.

## Divergências

Itens em que o código e a documentação de regras (`documentacao/03-papeis-e-regras.md`) ou o texto de apoio divergem. Os RF seguem o código; a documentação deve ser corrigida ou a divergência decidida pela equipe.

1. **QR Code obrigatório.** A documentação diz que filas `PRESENCIAL` ou `HIBRIDO` exigem QR Code na emissão. O código (`SenhaService.criar`) valida o QR Code só para `PRESENCIAL`. RF-034 segue o código. Decisão pendente para `HIBRIDO`.
2. **Aprovação de instituição rejeitada.** A documentação diz que só instituição `PENDENTE` pode ser aprovada (409). O código aceita também `REJEITADA` (`InstituicaoService.aprovar`). RF-012 segue o código.
3. **Código de erro nas transições de instituição.** A regra geral da documentação diz que transição inválida responde 409. Em aprovar, rejeitar e reconsiderar, o código responde 400. RF-012 a RF-014 seguem o código.
4. **Landing page sem escrita.** `LandingPageService` tem `atualizar`, mas não há rota de escrita em `landingPageRoutes.js`. RF-011 descreve só a leitura.
5. **Itens sem UC próprio no catálogo.** Flows (RF-029 a RF-031, RF-043, RF-044, RF-047, RF-062), CRUD de instituição (RF-016 a RF-019), notificações (RF-064), tempo real (RF-065) e landing page (RF-011) não têm UC próprio. Foram mapeados ao UC mais próximo. Sugestão para a equipe: criar UC próprio para flows.
6. **Rota de exemplo fora do escopo.** `GET /examples` (`exampleRoutes.js`) é um modelo de domínio, não requisito; não entrou no levantamento.

## Veja também

- [Levantamento e método](README.md)
- [Requisitos não funcionais](requisitos-nao-funcionais.md)
- [Histórias de usuário](historias-de-usuario.md)
- [Backlog](backlog.md)
- [Casos de uso](../05-modelagem/casos-de-uso/README.md)
- [Matriz de rastreabilidade](../07-rastreabilidade/matriz.md)
- [Rastreabilidade de requisitos (diagrama)](rastreabilidade-requisitos.svg)
