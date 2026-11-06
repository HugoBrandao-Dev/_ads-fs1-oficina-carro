# Glossário

Fábrica de Software I · Milestone 1 · termos do domínio, em ordem alfabética

Os termos seguem o domínio do FilaCidadã. A coluna "No código" aponta para o modelo do Prisma (`prisma/schema.prisma`), para o enum ou para a constante. Enums aparecem em maiúsculas, como no banco.

| Termo | Significado | No código |
|---|---|---|
| Administrador da instituição (ACT-03) | Administra a própria instituição: filas, mesas, usuários, QR Codes, flows e auditoria. Também atende | Papel `ADMIN_INSTITUICAO` |
| Administrador da plataforma (ACT-04) | Aprova ou rejeita instituições e gerencia usuários de todas. Não opera filas nem chama senhas | Papel `ADMIN_PLATAFORMA` |
| Auditoria | Registro de uma ação administrativa, como `CRIAR_FILA` ou `CHAMAR_SENHA`, com quem fez e quando | Model `Auditoria`, tabela `auditorias` |
| Chat | Mensagens entre cidadão e operador enquanto a senha está em atendimento | Model `ChatMensagem`, tabela `chat_mensagens` |
| Cidadão (ACT-01) | Pessoa que retira, acompanha e cancela as próprias senhas | Papel `USUARIO_FINAL` |
| Código 498 | Status próprio do projeto para "sessão inválida ou expirada". O 401 fica só para credencial errada no login | Classe `AuthenticationError` (`utils/errors/`) |
| Dashboard | Painel de indicadores de uma instituição ou da plataforma | Rotas `/dashboard/*` |
| Envelope | Formato de toda resposta REST: `{ message, data, errors }` | Helper `CommonResponse` |
| Fila | Serviço de atendimento de uma instituição. Pode ser `ONLINE`, `PRESENCIAL` ou `HIBRIDO` | Model `Fila`, enum `TipoAtendimento`, tabela `filas` |
| Flow | Percurso de atendimento em etapas (por exemplo, triagem, consulta e exame), com filas ligadas a cada etapa | Model `Flow`, tabela `flows` |
| Garage | Armazenamento de arquivos compatível com S3, com failover entre nós. Opcional: sem configuração, grava no disco local | `src/infra/StorageService.js` |
| Histórico do flow | Registro, sem edição, das etapas pelas quais a senha passou, com o nome da etapa na época | Model `SenhaFlowHistorico`, tabela `senha_flow_historicos` |
| Instituição | Órgão ou organização que usa o sistema. É um tenant: tem filas, usuários e flows próprios. Nasce `PENDENTE` até ser aprovada | Model `Instituicao`, enum `StatusInstituicao`, tabela `instituicoes` |
| Isolamento institucional | Administrador da instituição e operador só alcançam dados da própria instituição | Middleware `ensureInstituicao` e filtros nos services |
| Janela de tolerância | Tempo depois de `validoAte` em que um QR Code recém-expirado ainda é aceito | Campo `toleranciaAte` em `QrCode` |
| Landing page | Conteúdo da página inicial pública, guardado como uma linha JSON com `chave = "default"` | Model `LandingPage`, tabela `landing_pages` |
| Mesa | Guichê ou estação de atendimento de uma fila. Número único por fila | Model `Mesa`, tabela `mesas` |
| Notificação | Aviso guardado para o usuário. Fica na API mesmo sem conexão e pode sair também por socket e por push | Model `Notificacao`, tabela `notificacoes` |
| NPaaS | Serviço externo de e-mail transacional e push. Quando indisponível, o envio é pulado e registrado em log | `src/infra/NpaasClient.js` |
| Operador (ACT-02) | Atende as senhas da própria instituição; cria filas e QR Codes | Papel `OPERADOR` |
| Papel | O que um usuário pode fazer. Um usuário pode ter vários papéis | Enum `Papel`, tabela `usuario_papeis` (model `UsuarioPapel`) |
| Prioridade | Ordem de chamada da senha: `LEGAL` (peso 1), `FIDELIDADE` (peso 2) ou `NORMAL` (peso 3) | Enum `PrioridadeSenha`, campo `prioridadePeso` |
| QR Code | Código que prova presença em fila presencial. É `ROTATIVO` (expira e é regenerado) ou `FIXO` | Model `QrCode`, enum `ModoQrCode`, tabela `qr_codes` |
| Sala (room) | Canal do Socket.IO por onde os eventos chegam: `user:{id}`, `instituicao:{id}` e `fila:{id}` | `EventBusService` e `config/socket.js` |
| Senha | Posição de uma pessoa numa fila, do ingresso até a finalização. Passa por `AGUARDANDO`, `EM_ATENDIMENTO` e termina em `FINALIZADA` ou `CANCELADA` | Model `Senha`, enum `StatusSenha`, tabela `senhas` |
| Senha presencial | Senha criada pelo operador para quem não tem conta. Não tem usuário vinculado e leva o nome do cidadão | Campo `presencial = true`, `usuarioId` nulo |
| Sessão | Registro criado no login pelo BetterAuth. Dura 7 dias e se renova quando usada depois de 1 dia | Model `Session`, tabela `sessions` |
| Step | Etapa de um flow, ligada a uma fila. Tem uma ordem única dentro do flow | Model `FlowStep`, tabela `flow_steps` |
| Tipo de etapa | Catálogo de etapas da instituição, como `TRIAGEM` ou `CONSULTA`. Único por instituição e código | Model `TipoEtapa`, tabela `tipos_etapa` |
| Token público | Código que permite consultar a situação de uma senha sem login | Campo `tokenPublico` em `Senha` |
| Tracking | Situação de uma senha dentro de um flow: `EM_ANDAMENTO`, `CONCLUIDO` ou `CANCELADO`. Há um tracking por senha | Model `SenhaFlowTracking`, tabela `senha_flow_trackings` |
| Transição | Ligação entre dois steps de um flow: `SEQUENCIAL`, `CONDICIONAL` ou `ALTA` | Model `FlowTransition`, enum `FlowTransicaoTipo` |
| Usuário | Pessoa com conta no sistema. Pode ser cidadão, operador ou administrador, conforme os papéis | Model `User`, tabela `users` |
| Usuário final | Nome do papel `USUARIO_FINAL`, que é o cidadão no sistema | Enum `Papel` |

## Veja também

- [Visão do produto](README.md)
- [PM Canvas](pm-canvas.md)
- [RFP fictícia do cliente](rfp.md)
- [Dicionário de dados](../06-banco-de-dados/dicionario-de-dados.md)
- [Classes](../05-modelagem/classes/classes.svg)
