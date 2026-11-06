# Matriz de rastreabilidade

Milestone 2 · Fábrica de Software I · Unidade de rastreabilidade (cadeia requisito, história, caso de uso, classe, sequência, tela, tabela e teste)

Uma linha por requisito funcional (RF-001 a RF-065). Fonte dos RF: [requisitos-funcionais.md](../03-requisitos/requisitos-funcionais.md). As colunas seguem a cadeia da [malha](malha-rastreabilidade.svg): UC e US pelo catálogo e pelas histórias; classes e tabelas pelo modelo; sequência e estados pelos diagramas; telas pelos READMEs de protótipo; teste pelo arquivo em `src/tests/` que exercita a regra.

## Como ler

- **US**: `historias-de-usuario.md` marca "RF: pendente" em todas as 41 histórias. O vínculo foi derivado pelo UC e pelos endpoints citados em cada história. "(parcial)" indica que a história cobre só parte da regra do RF.
- **Classes**: nomes oficiais de [classes/README.md](../05-modelagem/classes/README.md). A OCL que garante cada regra está em [ocl/README.md](../05-modelagem/ocl/README.md).
- **Sequência**: os seis diagramas de [sequencia/README.md](../05-modelagem/sequencia/README.md). Estados: `estado-*.svg` em [estados](../05-modelagem/estados/).
- **Tela**: IDs como aparecem nos READMEs de [wireframes](../04-prototipo/wireframes/). As telas ADI-xx e ADP-xx não usam o prefixo `T-` do briefing; a divergência está em [lacunas.md](lacunas.md).
- **Teste**: caminho relativo a `src/tests/`. "(parcial)" indica teste que cobre a regra de serviço, não a rota HTTP ou o caso completo. `—` indica ausência de teste.

## Matriz

| RF | Nome | UC | US | Classes | Sequência | Tela | Tabela | Teste |
|---|---|---|---|---|---|---|---|---|
| RF-001 | Cadastrar conta de cidadão | UC-01 | US-001 | Usuario | — | T-PUB-03 | users, usuario_papeis | — |
| RF-002 | Autenticar com e-mail e senha | UC-01 | US-002 | Usuario | seq-login.svg | T-PUB-02 | users, usuario_papeis | `unit/middleware/AuthMiddleware.test.js` |
| RF-003 | Encerrar sessão | UC-01 | US-002 | Usuario | seq-login.svg | — | users, usuario_papeis | `unit/middleware/AuthMiddleware.test.js` |
| RF-004 | Redefinir senha por e-mail | UC-01 | US-003 | Usuario | — | — | users, usuario_papeis | — |
| RF-005 | Consultar e editar o próprio perfil | UC-02 | US-004 | Usuario | — | T-CID-09 | users, usuario_papeis | `routes/perfil.spec.js` |
| RF-006 | Alterar a própria senha | UC-02 | US-005 | Usuario | — | T-CID-09 | users, usuario_papeis | `routes/perfil.spec.js` |
| RF-007 | Gerenciar foto de perfil | UC-02 | US-006 | Usuario | — | T-CID-09 | users, usuario_papeis | `routes/perfil.spec.js` |
| RF-008 | Listar fusos horários | UC-02 | US-004 | Usuario | — | T-CID-09 | users, usuario_papeis | `routes/perfil.spec.js` |
| RF-009 | Solicitar cadastro de instituição | UC-03 | US-007 | Instituicao, Usuario | — | T-CID-08 | instituicoes, users, usuario_papeis | `integracao/InstituicaoService.test.js` |
| RF-010 | Impedir nome de instituição duplicado | UC-03 | US-007 | Instituicao | — | T-CID-08 | instituicoes | — |
| RF-011 | Exibir página pública de apresentação | UC-03 | — | LandingPage | — | T-PUB-01 | landing_pages | `integracao/LandingPageService.test.js` |
| RF-012 | Aprovar solicitação | UC-04 | US-008 | Instituicao, Usuario, Notificacao | seq-aprovar-instituicao.svg | ADP-02 | instituicoes, users, usuario_papeis, notificacoes | `integracao/InstituicaoService.test.js` |
| RF-013 | Rejeitar solicitação com motivo | UC-04 | US-009 | Instituicao, Notificacao | — | ADP-02 | instituicoes, notificacoes | `integracao/InstituicaoService.test.js` |
| RF-014 | Reconsiderar instituição rejeitada | UC-04 | US-010 | Instituicao | — | — | instituicoes | `integracao/InstituicaoService.test.js` |
| RF-015 | Anexar contrato em PDF | UC-04 | — | Instituicao | — | ADP-03 | instituicoes | — |
| RF-016 | Cadastrar instituição diretamente | UC-04 | — | Instituicao | — | — | instituicoes | `integracao/InstituicaoService.test.js` |
| RF-017 | Consultar instituições | UC-04 | — | Instituicao | — | ADP-03 | instituicoes | `routes/usuario.spec.js` (parcial) |
| RF-018 | Atualizar dados da instituição | UC-04 | — | Instituicao | — | ADP-03, ADI-08 | instituicoes | — |
| RF-019 | Excluir instituição em cascata | UC-04 | — | Instituicao | — | ADP-03 | instituicoes | — |
| RF-020 | Listar e detalhar usuários | UC-05 | US-011 | Usuario | — | ADI-05, ADP-04 | users, usuario_papeis | `integracao/UsuarioService.test.js`<br>`routes/usuario.spec.js` |
| RF-021 | Cadastrar usuário com papel e convite | UC-05 | US-012 | Usuario | — | ADI-05 | users, usuario_papeis | `routes/usuario.spec.js` |
| RF-022 | Alterar dados e papéis de usuário | UC-05 | US-013 | Usuario | — | ADI-05, ADP-04 | users, usuario_papeis | `routes/usuario.spec.js` |
| RF-023 | Remover usuário | UC-05 | US-014 | Usuario | — | — | users, usuario_papeis | `routes/usuario.spec.js` |
| RF-024 | Bloquear acesso de usuário inativo | UC-05 | US-013 (parcial) | Usuario | — | ADI-09 | users, usuario_papeis | `unit/middleware/AuthMiddleware.test.js` |
| RF-025 | Listar e consultar filas | UC-06 | — | Fila | — | T-CID-01, ADI-02 | filas | — |
| RF-026 | Criar fila | UC-06 | US-015 | Fila, Mesa | — | ADI-03 | filas, mesas | `integracao/FilaService.test.js`<br>`graphql/graphql.spec.js` |
| RF-027 | Atualizar fila | UC-06 | US-016 | Fila, Mesa | — | ADI-03, ADI-02 | filas, mesas | `integracao/FilaService.test.js` |
| RF-028 | Remover fila | UC-06 | US-017 | Fila | — | — | filas | `integracao/FilaService.test.js` |
| RF-029 | Consultar flows | UC-06 | — | Fluxo, EtapaFluxo, TransicaoFluxo | — | — | flows, flow_steps, flow_transitions | — |
| RF-030 | Criar flow de atendimento | UC-06 | — | Fluxo, EtapaFluxo, TransicaoFluxo | — | — | flows, flow_steps, flow_transitions | `integracao/FlowService.test.js` |
| RF-031 | Atualizar, desativar e remover flow | UC-06 | — | Fluxo, EtapaFluxo, TransicaoFluxo | — | — | flows, flow_steps, flow_transitions | — |
| RF-032 | Consultar tipos de etapa | UC-07 | US-019 | TipoEtapa | — | ADI-04 | tipos_etapa | — |
| RF-033 | Substituir lista de tipos de etapa | UC-07 | US-018 | TipoEtapa | — | ADI-04 | tipos_etapa | — |
| RF-034 | Emitir senha digital | UC-08 | US-020 | Senha, Fila | seq-emitir-senha-online.svg | T-CID-02, T-CID-11 | senhas, filas | `integracao/SenhaService.test.js` |
| RF-035 | Localizar fila pelo código do QR Code | UC-08 | US-022, US-033 | QrCode, Fila | — | T-CID-03 | qr_codes, filas | `integracao/QrCodeService.test.js` (parcial, regra de validar) |
| RF-036 | Consultar contagem de senhas da fila | UC-08 | US-020, US-021 | Senha, Fila | — | T-CID-01, T-CID-10 | senhas, filas | `integracao/SenhaService.test.js` |
| RF-037 | Aplicar prioridade habilitada pela fila | UC-08 | US-021 | Senha, Fila | seq-emitir-senha-online.svg | T-CID-02 | senhas, filas | `integracao/SenhaService.test.js` |
| RF-038 | Emitir senha presencial | UC-09 | US-023 | Senha, Fila | seq-emitir-senha-presencial.svg | T-OPE-03 | senhas, filas | `integracao/SenhaService.test.js` |
| RF-039 | Chamar senha | UC-10 | US-024, US-025 | Senha, Mesa | seq-chamar-senha.svg | T-OPE-01, T-OPE-02 | senhas, mesas | `integracao/SenhaService.test.js`<br>`integracao/SenhaServiceEventos.test.js` |
| RF-040 | Rechamar senha | UC-10 | US-026 | Senha, Mesa | seq-chamar-senha.svg | T-OPE-02 | senhas, mesas | `integracao/SenhaService.test.js` |
| RF-041 | Assumir atendimento de outro operador | UC-10 | US-027 | Senha, Usuario | seq-chamar-senha.svg | T-OPE-07 | senhas, users, usuario_papeis | `integracao/SenhaService.test.js` |
| RF-042 | Consultar atendimento ativo do operador | UC-10 | US-024 | Senha | — | T-OPE-02 | senhas | `graphql/graphql.spec.js` (parcial, via GraphQL) |
| RF-043 | Ingressar senha em flow | UC-10 | US-030 | Fluxo, RastreioFluxo, HistoricoFluxo, Senha | — | — | flows, senha_flow_trackings, senha_flow_historicos, senhas | `integracao/FlowService.test.js` |
| RF-044 | Encaminhar senha para outro step | UC-10 | US-030 | RastreioFluxo, HistoricoFluxo | — | — | senha_flow_trackings, senha_flow_historicos | `integracao/FlowService.test.js` |
| RF-045 | Finalizar atendimento | UC-11 | US-028 | Senha | seq-finalizar-cancelar.svg | T-OPE-02 | senhas | `integracao/SenhaService.test.js`<br>`integracao/SenhaServiceEventos.test.js` |
| RF-046 | Cancelar senha pelo administrador | UC-11 | — | Senha, Auditoria | seq-finalizar-cancelar.svg | T-OPE-01 | senhas, auditorias | `integracao/SenhaService.test.js` (parcial, cancelamento pelo dono) |
| RF-047 | Dar alta no flow | UC-11 | US-030 | RastreioFluxo, HistoricoFluxo, Senha | — | — | senha_flow_trackings, senha_flow_historicos, senhas | `integracao/FlowService.test.js` |
| RF-048 | Listar e consultar QR Codes | UC-12 | — | QrCode | — | ADI-06 | qr_codes | — |
| RF-049 | Gerar QR Code da fila | UC-12 | US-031 | QrCode | — | ADI-06 | qr_codes | `integracao/QrCodeService.test.js` |
| RF-050 | Regenerar QR Code | UC-12 | US-032 | QrCode | — | ADI-06 | qr_codes | `integracao/QrCodeService.test.js` |
| RF-051 | Desativar QR Code | UC-12 | US-032 | QrCode | — | ADI-06 | qr_codes | `integracao/QrCodeService.test.js` |
| RF-052 | Consultar dashboard geral da plataforma | UC-13 | US-034 | Instituicao, Senha | — | ADP-01 | instituicoes, senhas | — |
| RF-053 | Consultar dashboard da instituição | UC-13 | US-035 | Senha, Fila | — | ADI-01 | senhas, filas | — |
| RF-054 | Consultar estatísticas agregadas de senhas | UC-13 | US-036 | Senha | — | ADI-01, T-OPE-04 | senhas | `integracao/SenhaService.test.js` |
| RF-055 | Gerar relatório de senhas por período | UC-13 | US-036 | Senha | — | — | senhas | `integracao/SenhaService.test.js` |
| RF-056 | Consultar trilha de auditoria | UC-14 | US-037 | Auditoria | — | ADI-07, ADP-05 | auditorias | — |
| RF-057 | Registrar ações do sistema | UC-14 | US-037 (parcial) | Auditoria | — | ADI-07, ADP-05 | auditorias | `integracao/FilaService.test.js`<br>`integracao/InstituicaoService.test.js`<br>`integracao/SenhaService.test.js` |
| RF-058 | Listar minhas senhas | UC-15 | US-038 | Senha | — | T-CID-05, T-OPE-04 | senhas | `integracao/SenhaService.test.js` |
| RF-059 | Consultar uma senha | UC-15 | US-038 | Senha | — | T-CID-04, T-CID-12 | senhas | `integracao/SenhaService.test.js` |
| RF-060 | Cancelar minha senha | UC-15 | US-029 | Senha | — | T-CID-04 | senhas | `integracao/SenhaService.test.js` |
| RF-061 | Acompanhar senha sem login | UC-15 | US-039 | Senha | — | — | senhas | `integracao/FlowService.test.js` |
| RF-062 | Consultar fluxo da senha | UC-15 | US-039 (parcial) | RastreioFluxo, HistoricoFluxo | — | — | senha_flow_trackings, senha_flow_historicos | — |
| RF-063 | Conversar com o operador durante o atendimento | UC-15 | US-040 | ChatMensagem | — | T-CID-06 | chat_mensagens | `integracao/ChatService.test.js` |
| RF-064 | Consultar e marcar notificações | UC-15 | US-041 | Notificacao | — | T-CID-07 | notificacoes | `integracao/NotificacaoService.test.js` |
| RF-065 | Receber atualizações em tempo real | UC-15 | US-041 (parcial) | Notificacao | — | T-CID-07 | notificacoes | `integracao/socket/SocketAuth.test.js` |

## Cobertura da cadeia

| Elo da cadeia | RF com vínculo | Total | RF sem vínculo |
|---|---|---|---|
| UC | 65 | 65 | 0 |
| US | 53 | 65 | 12 |
| Classe | 65 | 65 | 0 |
| Sequência | 11 | 65 | 54 |
| Tela | 50 | 65 | 15 |
| Tabela | 65 | 65 | 0 |
| Teste | 49 | 65 | 16 |

A lista de RF sem cada elo está em [lacunas.md](lacunas.md).

## Divergências

1. **Numeração de RF.** O briefing previa RF agrupados por UC em blocos fixos (UC-01 com RF-001 a 003 etc.). O arquivo `requisitos-funcionais.md` publica 65 RF com outra distribuição (UC-01 tem 4, UC-15 tem 8). A matriz segue o arquivo.
2. **Classe Papel.** O briefing lista `Papel` entre as classes. O modelo de classes não tem essa classe; o papel é enum (`Papel`) e vínculo (`UsuarioPapel`). Lacuna L-18.
3. **IDs de tela.** Os READMEs de ADI e ADP usam `ADI-xx` e `ADP-xx`; os de CID, OPE e PUB usam `T-CID-xx` etc. A matriz mantém o ID de cada README. Lacuna L-07.
4. **US sem RF.** `historias-de-usuario.md` marca "RF: pendente" em todas as histórias. O vínculo da matriz é derivado e deve ser espelhado no arquivo de histórias. Lacuna L-02.
5. **Sequência e US.** O README de sequência marca a coluna US como "a definir", apesar de a lista de histórias já estar publicada. Lacuna L-19.

## Veja também

- [Lacunas e órfãos](lacunas.md)
- [Malha de rastreabilidade (diagrama)](malha-rastreabilidade.svg)
- [Requisitos funcionais](../03-requisitos/requisitos-funcionais.md)
- [Histórias de usuário](../03-requisitos/historias-de-usuario.md)
- [Casos de uso](../05-modelagem/casos-de-uso/README.md)
- [Classes](../05-modelagem/classes/README.md)
- [Dicionário de dados](../06-banco-de-dados/dicionario-de-dados.md)
