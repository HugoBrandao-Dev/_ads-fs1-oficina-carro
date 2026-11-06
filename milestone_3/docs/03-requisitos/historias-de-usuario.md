# Histórias de usuário

Milestone M1 · Unidade: Engenharia de Software (Fábrica de Software I) · Pasta `03-requisitos/`

Este documento detalha os casos de uso UC-01 a UC-15 em 41 histórias de usuário (US-001 a US-041). Os critérios de aceite em Gherkin seguem o comportamento do código (`src/routes`, `src/services`, `src/utils/validators`). Quando o código diverge do catálogo ou da documentação, o cenário recebe a tag `@lacuna` (regra esperada que o código não cumpre) ou `@defeito` (caminho provavelmente quebrado, não executado). As divergências estão na seção [Divergências](#divergências), no fim do documento.

## Índice

| US | Título | Ator | UC | MoSCoW | Depende de |
|---|---|---|---|---|---|
| [US-001](#us-001-cadastrar-se) | Cadastrar-se | ACT-01 Cidadão | UC-01 | Must | — |
| [US-002](#us-002-entrar-e-sair-da-conta) | Entrar e sair da conta | ACT-01 a ACT-04 | UC-01 | Must | US-001 |
| [US-003](#us-003-recuperar-senha) | Recuperar senha | ACT-01 Cidadão | UC-01 | Should | US-001 |
| [US-004](#us-004-editar-meus-dados-e-fuso-horário) | Editar meus dados e fuso horário | ACT-01 a ACT-04 | UC-02 | Should | US-002 |
| [US-005](#us-005-trocar-minha-senha) | Trocar minha senha | ACT-01 a ACT-04 | UC-02 | Should | US-002 |
| [US-006](#us-006-gerenciar-avatar) | Gerenciar avatar | ACT-01 a ACT-04 | UC-02 | Could | US-002 |
| [US-007](#us-007-solicitar-cadastro-de-instituição) | Solicitar cadastro de instituição | ACT-01 Cidadão | UC-03 | Must | US-002 |
| [US-008](#us-008-aprovar-solicitação-de-instituição) | Aprovar solicitação de instituição | ACT-04 Admin. Plataforma | UC-04 | Must | US-007 |
| [US-009](#us-009-rejeitar-solicitação-de-instituição) | Rejeitar solicitação de instituição | ACT-04 Admin. Plataforma | UC-04 | Should | US-007 |
| [US-010](#us-010-reconsiderar-instituição-rejeitada) | Reconsiderar instituição rejeitada | ACT-04 Admin. Plataforma | UC-04 | Could | US-009 |
| [US-011](#us-011-listar-usuários-da-instituição) | Listar usuários da instituição | ACT-03 Admin. Instituição | UC-05 | Must | US-002 |
| [US-012](#us-012-cadastrar-usuário-administrativo) | Cadastrar usuário administrativo | ACT-03 Admin. Instituição | UC-05 | Must | US-011 |
| [US-013](#us-013-alterar-papéis-e-status-do-usuário) | Alterar papéis e status do usuário | ACT-03 Admin. Instituição | UC-05 | Must | US-012 |
| [US-014](#us-014-remover-usuário) | Remover usuário | ACT-03 Admin. Instituição | UC-05 | Should | US-011 |
| [US-015](#us-015-criar-fila) | Criar fila | ACT-02 Operador | UC-06 | Must | US-012 |
| [US-016](#us-016-editar-e-desativar-fila) | Editar e desativar fila | ACT-02 Operador | UC-06 | Must | US-015 |
| [US-017](#us-017-excluir-fila) | Excluir fila | ACT-03 Admin. Instituição | UC-06 | Should | US-015 |
| [US-018](#us-018-definir-tipos-de-etapa) | Definir tipos de etapa | ACT-03 Admin. Instituição | UC-07 | Should | US-011 |
| [US-019](#us-019-consultar-tipos-de-etapa) | Consultar tipos de etapa | ACT-02 Operador | UC-07 | Should | US-018 |
| [US-020](#us-020-retirar-senha-em-fila-online) | Retirar senha em fila online | ACT-01 Cidadão | UC-08 | Must | US-015 |
| [US-021](#us-021-retirar-senha-com-prioridade) | Retirar senha com prioridade | ACT-01 Cidadão | UC-08 | Should | US-020 |
| [US-022](#us-022-retirar-senha-com-qr-code-em-fila-presencial) | Retirar senha com QR Code em fila presencial | ACT-01 Cidadão | UC-08 | Must | US-031, US-020 |
| [US-023](#us-023-emitir-senha-presencial) | Emitir senha presencial | ACT-02 Operador | UC-09 | Must | US-015 |
| [US-024](#us-024-chamar-próxima-senha) | Chamar próxima senha | ACT-02 Operador | UC-10 | Must | US-020, US-023 |
| [US-025](#us-025-pular-cidadão-já-em-atendimento) | Pular cidadão já em atendimento | ACT-02 Operador | UC-10 | Should | US-024 |
| [US-026](#us-026-rechamar-senha) | Rechamar senha | ACT-02 Operador | UC-10 | Should | US-024 |
| [US-027](#us-027-assumir-atendimento-de-outro-operador) | Assumir atendimento de outro operador | ACT-03 Admin. Instituição | UC-10 | Could | US-024 |
| [US-028](#us-028-finalizar-atendimento) | Finalizar atendimento | ACT-02 Operador | UC-11 | Must | US-024 |
| [US-029](#us-029-cancelar-senha-aguardando) | Cancelar senha aguardando | ACT-01 Cidadão | UC-11 | Must | US-020 |
| [US-030](#us-030-encaminhar-senha-no-flow-e-dar-alta) | Encaminhar senha no flow e dar alta | ACT-02 Operador | UC-11 | Should | US-015, US-024 |
| [US-031](#us-031-gerar-qr-code-da-fila) | Gerar QR Code da fila | ACT-02 Operador | UC-12 | Must | US-015 |
| [US-032](#us-032-regenerar-e-desativar-qr-code) | Regenerar e desativar QR Code | ACT-02 Operador | UC-12 | Should | US-031 |
| [US-033](#us-033-consultar-qr-code-antes-do-login) | Consultar QR Code antes do login | ACT-01 Cidadão | UC-12 | Must | US-031 |
| [US-034](#us-034-consultar-dashboard-da-plataforma) | Consultar dashboard da plataforma | ACT-04 Admin. Plataforma | UC-13 | Should | US-002 |
| [US-035](#us-035-consultar-dashboard-da-instituição) | Consultar dashboard da instituição | ACT-03 Admin. Instituição | UC-13 | Should | US-015 |
| [US-036](#us-036-consultar-estatísticas-e-relatório-de-senhas) | Consultar estatísticas e relatório de senhas | ACT-02 Operador | UC-13 | Could | US-020 |
| [US-037](#us-037-consultar-auditoria) | Consultar auditoria | ACT-03 Admin. Instituição | UC-14 | Should | US-002 |
| [US-038](#us-038-acompanhar-minha-senha) | Acompanhar minha senha | ACT-01 Cidadão | UC-15 | Must | US-020 |
| [US-039](#us-039-acompanhar-senha-em-painel-público) | Acompanhar senha em painel público | ACT-01 Cidadão | UC-15 | Should | US-030 |
| [US-040](#us-040-conversar-com-o-atendente-durante-o-atendimento) | Conversar com o atendente durante o atendimento | ACT-01 Cidadão | UC-15 | Should | US-024 |
| [US-041](#us-041-receber-notificações-de-senha) | Receber notificações de senha | ACT-01 Cidadão | UC-15 | Should | US-024 |

## Convenções

- Formato: **Como** `<ator>`, **quero** `<ação>`, **para** `<benefício>`. Atores conforme o [glossário](../01-visao/glossario.md): ACT-01 Cidadão (`USUARIO_FINAL`), ACT-02 Operador (`OPERADOR`), ACT-03 Administrador da Instituição (`ADMIN_INSTITUICAO`), ACT-04 Administrador da Plataforma (`ADMIN_PLATAFORMA`).
- Vínculo com requisitos funcionais: o arquivo `requisitos-funcionais.md` ainda não existe. Cada história cita o UC e fica com o campo RF pendente até o mapeamento UC para RF ser publicado (ver [Divergências](#divergências), D-15).
- Status HTTP e mensagens são os do código. `CustomError` responde com o status indicado; erro de validação Zod responde 400.
- Gherkin em português: `Funcionalidade`, `Cenário`, `Dado`, `Quando`, `Então`, `E`.
- Tags: `@lacuna` (o código não cumpre a regra esperada) e `@defeito` (caminho não executado, provavelmente quebrado).

## UC-01 Autenticar-se

### US-001 Cadastrar-se

**Como** cidadão (ACT-01), **quero** criar uma conta com nome, e-mail e senha, **para** acessar as filas das instituições.

- Vínculo: UC-01 · RF: pendente · Prioridade: Must
- Regras: `POST /api/auth/sign-up/email` (BetterAuth). Senha com no mínimo 8 caracteres. `autoSignIn` desligado: o cadastro não autentica. E-mail já cadastrado responde 422. Após o cadastro, a conta não tem papel administrativo.

```gherkin
Funcionalidade: Cadastro de cidadão

  Cenário: cadastro com dados válidos
    Dado que não existe conta com o e-mail "ana@exemplo.com"
    Quando envio POST /api/auth/sign-up/email com nome "Ana", e-mail "ana@exemplo.com" e senha "Senha@123"
    Então a conta é criada
    E a resposta não cria sessão, pois o cadastro não autentica
    E a conta não recebe papel administrativo

  Cenário: e-mail já cadastrado
    Dado que já existe conta com o e-mail "ana@exemplo.com"
    Quando envio novo cadastro com o mesmo e-mail
    Então a API responde 422
    E nenhuma conta nova é criada

  Cenário: senha com menos de 8 caracteres
    Quando envio cadastro com a senha "Ab@1"
    Então a API recusa o cadastro pela senha mínima de 8 caracteres
    E nenhuma conta é criada

  @lacuna
  Cenário: cidadão cadastrado retira senha
    Dado que me cadastrei e não recebi papel administrativo
    Quando faço POST /filas/{filaId}/senhas
    Então o cadastro recebe o papel USUARIO_FINAL e a senha é emitida
    # Hoje o código responde 403 "permissão insuficiente": nenhum papel USUARIO_FINAL é atribuído no cadastro (D-03).
```

### US-002 Entrar e sair da conta

**Como** usuário cadastrado, **quero** entrar com e-mail e senha e sair quando quiser, **para** usar o sistema com segurança.

- Vínculo: UC-01 · RF: pendente · Prioridade: Must
- Regras: sessão persistida com cookie assinado, validade de 7 dias, renovada após 1 dia de uso. `GET /auth/me` devolve `id`, `papeis`, `instituicaoId` e `fusoHorario`. Sem sessão, sessão revogada ou usuário apagado: 498. Usuário com `ativo: false` autentica, mas recebe 403 em toda rota protegida.

```gherkin
Funcionalidade: Entrar e sair

  Cenário: login com credenciais corretas
    Dado uma conta ativa com e-mail "ana@exemplo.com" e senha válida
    Quando faço POST /api/auth/sign-in/email com essas credenciais
    Então recebo o cookie de sessão
    E GET /auth/me devolve id, papeis, instituicaoId e fusoHorario do usuário

  Cenário: login com senha incorreta
    Dado uma conta ativa com e-mail "ana@exemplo.com"
    Quando faço POST /api/auth/sign-in/email com senha errada
    Então a API responde 401
    E nenhum cookie de sessão é emitido

  Cenário: usuário desativado
    Dado uma conta com ativo igual a falso
    Quando faço login com as credenciais corretas e chamo uma rota protegida
    Então o login é aceito
    E a rota protegida responde 403 com a mensagem "Usuário inativo. Procure o administrador da instituição."

  Cenário: saída da conta
    Dado um usuário autenticado
    Quando faço POST /api/auth/sign-out
    Então a sessão é apagada
    E o cookie deixa de valer imediatamente

  Cenário: uso de sessão revogada
    Dado um cookie de sessão já apagado
    Quando chamo uma rota protegida
    Então a API responde 498 "Sessão inválida ou expirada. Autentique-se novamente."
```

### US-003 Recuperar senha

**Como** cidadão que esqueceu a senha, **quero** receber um link para redefini-la, **para** voltar a acessar minha conta.

- Vínculo: UC-01 · RF: pendente · Prioridade: Should
- Regras: `POST /api/auth/request-password-reset` responde igual exista ou não o e-mail. O e-mail sai pelo NPaaS; sem `NPAAS_API_KEY` o envio não ocorre e fica um aviso no log. `POST /api/auth/reset-password` recebe `newPassword` e `token`.
- Nota: o catálogo UC-01 não lista recuperação de senha; a história é vinculada a UC-01 (D-13).

```gherkin
Funcionalidade: Recuperação de senha

  Cenário: pedido de redefinição com e-mail cadastrado
    Dado uma conta com o e-mail "ana@exemplo.com"
    Quando faço POST /api/auth/request-password-reset com esse e-mail
    Então a resposta é igual à de um e-mail não cadastrado
    E o link de redefinição é enviado pelo NPaaS

  Cenário: redefinição com token válido
    Dado um token de redefinição válido
    Quando faço POST /api/auth/reset-password com a nova senha e o token
    Então a senha é trocada

  Cenário: redefinição com token inválido
    Dado um token expirado ou já usado
    Quando faço POST /api/auth/reset-password com esse token
    Então a API recusa a redefinição
    E a senha atual não muda
```

## UC-02 Gerenciar perfil

### US-004 Editar meus dados e fuso horário

**Como** usuário, **quero** atualizar meu nome, e-mail e fuso horário, **para** manter meus dados corretos e ver os horários no meu fuso.

- Vínculo: UC-02 · RF: pendente · Prioridade: Should
- Regras: `PATCH /me` aceita `nome`, `email` e `fusoHorario`. O fuso precisa constar em `GET /timezones` (padrão `America/Manaus`). E-mail é normalizado para minúsculas. E-mail de outra conta responde 409.

```gherkin
Funcionalidade: Perfil do usuário

  Cenário: atualização de nome e fuso horário
    Dado um usuário autenticado
    Quando faço PATCH /me com nome "Ana Souza" e fusoHorario "America/Sao_Paulo"
    Então a API responde 200 com o perfil atualizado

  Cenário: e-mail normalizado para minúsculas
    Quando faço PATCH /me com email "ANA@EXEMPLO.COM"
    Então o e-mail gravado é "ana@exemplo.com"

  Cenário: e-mail de outra conta
    Dado que o e-mail "bruno@exemplo.com" pertence a outra conta
    Quando faço PATCH /me com esse e-mail
    Então a API responde 409 "Email já está em uso"

  Cenário: fuso horário fora da lista
    Quando faço PATCH /me com fusoHorario "Marte/Olympus"
    Então a API responde 400 de validação
```

### US-005 Trocar minha senha

**Como** usuário, **quero** trocar minha senha informando a atual, **para** proteger minha conta.

- Vínculo: UC-02 · RF: pendente · Prioridade: Should
- Regras: `PATCH /me/senha` com `senhaAtual` e `novaSenha`. A nova senha tem 8 ou mais caracteres, com maiúscula, minúscula, número e caractere especial (`@$!%*?&`). Senha atual incorreta responde 400.

```gherkin
Funcionalidade: Troca de senha

  Cenário: troca com senha atual correta e nova senha forte
    Dado um usuário autenticado que sabe a senha atual
    Quando faço PATCH /me/senha com senhaAtual correta e novaSenha "Nova@2026"
    Então a API responde 200 com a mensagem "Senha alterada com sucesso"
    E a senha nova passa a valer no login

  Cenário: senha atual incorreta
    Quando faço PATCH /me/senha com uma senhaAtual errada
    Então a API responde 400 "Senha atual incorreta"
    E a senha não muda

  Cenário: nova senha fraca
    Quando faço PATCH /me/senha com novaSenha "somenteletras"
    Então a API responde 400 de validação com a regra de maiúscula, minúscula, número e caractere especial
```

### US-006 Gerenciar avatar

**Como** usuário, **quero** enviar e remover minha foto de perfil, **para** ser reconhecido nas telas do sistema.

- Vínculo: UC-02 · RF: pendente · Prioridade: Could
- Regras: `POST /me/avatar` (multipart, campo `avatar`) aceita JPEG, PNG, WebP e GIF. `DELETE /me/avatar` anula `users.image`.

```gherkin
Funcionalidade: Avatar

  Cenário: envio de imagem JPEG
    Dado um usuário autenticado
    Quando envio um arquivo JPEG no campo avatar
    Então a API responde 200 com o caminho público do avatar

  Cenário: remoção do avatar
    Dado um usuário com avatar cadastrado
    Quando faço DELETE /me/avatar
    Então o campo avatar do perfil fica nulo

  Cenário: tipo de arquivo não permitido
    Quando envio um arquivo PDF no campo avatar
    Então a API responde 400 "Tipo de arquivo não permitido. Use JPEG, PNG, WebP ou GIF."

  Cenário: requisição sem arquivo
    Quando faço POST /me/avatar sem o campo avatar
    Então a API responde 400 "Nenhum arquivo enviado"
```

## UC-03 Solicitar cadastro de instituição

### US-007 Solicitar cadastro de instituição

**Como** responsável por um órgão público, **quero** solicitar o cadastro da minha instituição, **para** oferecer filas no FilaCidada após a aprovação.

- Vínculo: UC-03 · RF: pendente · Prioridade: Must
- Regras: `POST /instituicoes/solicitar` aceita qualquer usuário autenticado. Campos: `nome` (mín. 2), `cnpj` (14 a 18 caracteres), `email` válido, `telefone` (10 a 20), `responsavel` (mín. 2), `endereco` (mín. 5) e `descricao` opcional (máx. 500). A instituição nasce `PENDENTE`, com `ativo: false` e `solicitanteId` do usuário logado.

```gherkin
Funcionalidade: Solicitação de instituição

  Cenário: solicitação com dados completos
    Dado um usuário autenticado
    Quando faço POST /instituicoes/solicitar com dados válidos
    Então a instituição é criada com status PENDENTE e ativo falso
    E o solicitanteId é o usuário logado
    E é registrada auditoria SOLICITAR_INSTITUICAO

  Cenário: CNPJ incompleto
    Quando faço POST /instituicoes/solicitar com cnpj "1234"
    Então a API responde 400 "CNPJ é obrigatório."
    E nenhuma instituição é criada

  Cenário: solicitação sem sessão
    Quando faço POST /instituicoes/solicitar sem cookie de sessão
    Então a API responde 498

  @lacuna
  Cenário: aviso aos administradores da plataforma
    Quando a solicitação é criada
    Então os usuários ADMIN_PLATAFORMA recebem a notificação SOLICITACAO_INSTITUICAO
    # Hoje a notificação não é emitida (D-06).
```

## UC-04 Avaliar solicitação de instituição

### US-008 Aprovar solicitação de instituição

**Como** administrador da plataforma, **quero** aprovar uma solicitação, **para** liberar a instituição a operar no sistema.

- Vínculo: UC-04 · RF: pendente · Prioridade: Must
- Regras: `PATCH /instituicoes/:id/aprovar`, somente `ADMIN_PLATAFORMA`. Aceita instituições `PENDENTE` ou `REJEITADA`. Grava `aprovadoPorId` e `aprovadoEm`, ativa a instituição e envia e-mail ao solicitante (melhor esforço).

```gherkin
Funcionalidade: Aprovação de instituição

  Cenário: aprovação de solicitação pendente
    Dado uma instituição com status PENDENTE
    Quando o administrador da plataforma faz PATCH /instituicoes/{id}/aprovar
    Então a instituição fica APROVADA e ativa
    E aprovadoPorId e aprovadoEm são gravados
    E é registrada auditoria APROVAR_INSTITUICAO

  Cenário: aprovação de instituição rejeitada anteriormente
    Dado uma instituição com status REJEITADA
    Quando o administrador da plataforma aprova a instituição
    Então a instituição fica APROVADA e ativa

  Cenário: instituição já aprovada
    Dado uma instituição com status APROVADA
    Quando o administrador da plataforma tenta aprovar de novo
    Então a API responde 400 "Apenas solicitações pendentes ou rejeitadas podem ser aprovadas."

  Cenário: aprovação por administrador da instituição
    Dado um usuário com papel ADMIN_INSTITUICAO
    Quando faz PATCH /instituicoes/{id}/aprovar
    Então a API responde 403 "permissão insuficiente"
```

### US-009 Rejeitar solicitação de instituição

**Como** administrador da plataforma, **quero** rejeitar uma solicitação informando o motivo, **para** que o solicitante saiba o que corrigir.

- Vínculo: UC-04 · RF: pendente · Prioridade: Should
- Regras: `PATCH /instituicoes/:id/rejeitar` exige `motivoRejeicao` com 5 ou mais caracteres. Só instituições `PENDENTE` podem ser rejeitadas. A instituição fica `REJEITADA` e inativa.

```gherkin
Funcionalidade: Rejeição de instituição

  Cenário: rejeição com motivo válido
    Dado uma instituição PENDENTE
    Quando faço PATCH /instituicoes/{id}/rejeitar com motivoRejeicao "Documentação do CNPJ incompleta"
    Então a instituição fica REJEITADA e inativa
    E o motivo é gravado
    E o solicitante recebe e-mail com o motivo (melhor esforço)

  Cenário: motivo curto demais
    Dado uma instituição PENDENTE
    Quando faço PATCH /instituicoes/{id}/rejeitar com motivoRejeicao "ruim"
    Então a API responde 400 "Informe o motivo da rejeição (mín. 5 caracteres)."

  Cenário: rejeição de instituição já aprovada
    Dado uma instituição APROVADA
    Quando faço PATCH /instituicoes/{id}/rejeitar com um motivo válido
    Então a API responde 400 "Apenas solicitações pendentes podem ser rejeitadas."
```

### US-010 Reconsiderar instituição rejeitada

**Como** administrador da plataforma, **quero** reabrir uma solicitação rejeitada, **para** reavaliá-la quando o solicitante corrigir os dados.

- Vínculo: UC-04 · RF: pendente · Prioridade: Could
- Regras: `PATCH /instituicoes/:id/reconsiderar` só age sobre `REJEITADA` e a devolve a `PENDENTE`, limpando `motivoRejeicao`, `aprovadoPorId` e `aprovadoEm`.

```gherkin
Funcionalidade: Reconsideração de instituição

  Cenário: reabertura de solicitação rejeitada
    Dado uma instituição REJEITADA com motivo registrado
    Quando faço PATCH /instituicoes/{id}/reconsiderar
    Então a instituição volta a PENDENTE
    E o motivo de rejeição é limpo
    E é registrada auditoria RECONSIDERAR_INSTITUICAO

  Cenário: instituição pendente
    Dado uma instituição PENDENTE
    Quando faço PATCH /instituicoes/{id}/reconsiderar
    Então a API responde 400 "Apenas instituições rejeitadas podem ser reconsideradas."
```

## UC-05 Gerenciar usuários e papéis

### US-011 Listar usuários da instituição

**Como** administrador da instituição, **quero** ver os usuários e papéis da minha instituição, **para** saber quem acessa o sistema.

- Vínculo: UC-05 · RF: pendente · Prioridade: Must
- Regras: `GET /usuarios` e `GET /instituicoes/:instituicaoId/usuarios`, para `ADMIN_PLATAFORMA` e `ADMIN_INSTITUICAO`. Para o administrador da instituição a listagem é filtrada pela própria instituição, mesmo que outra seja pedida na query. Filtros: `nome`, `email`, `ativo`, `page`, `limit`.

```gherkin
Funcionalidade: Listagem de usuários

  Cenário: administrador lista a própria instituição
    Dado um ADMIN_INSTITUICAO vinculado à instituição "A"
    Quando faço GET /instituicoes/A/usuarios
    Então recebo somente os usuários da instituição "A"

  Cenário: pedido de outra instituição pela rota aninhada
    Dado um ADMIN_INSTITUICAO vinculado à instituição "A"
    Quando faço GET /instituicoes/B/usuarios
    Então a API responde 403 "recurso pertence a outra instituição"

  Cenário: operador tenta listar usuários
    Dado um OPERADOR da instituição "A"
    Quando faço GET /usuarios
    Então a API responde 403 "permissão insuficiente"
```

### US-012 Cadastrar usuário administrativo

**Como** administrador da instituição, **quero** cadastrar operadores e administradores, **para** que a equipe acesse as filas.

- Vínculo: UC-05 · RF: pendente · Prioridade: Must
- Regras: `POST /instituicoes/:instituicaoId/usuarios` com `nome`, `email`, `papeis` (um ou mais de `ADMIN_PLATAFORMA`, `ADMIN_INSTITUICAO`, `OPERADOR`, `USUARIO_FINAL`) e `senha` opcional. Sem senha, o sistema cria uma senha temporária e envia convite para definição de senha. Papel administrativo exige instituição ativa.

```gherkin
Funcionalidade: Cadastro de usuário pelo administrador

  Cenário: cadastro de operador sem senha informada
    Dado um ADMIN_INSTITUICAO da instituição "A"
    Quando faço POST /instituicoes/A/usuarios com nome "Carla", email "carla@exemplo.com" e papeis ["OPERADOR"]
    Então a API responde 201
    E a conta é criada com uma senha temporária
    E é enviado o convite para definição de senha
    E é registrada auditoria CRIAR_USUARIO

  Cenário: e-mail já em uso
    Dado que "carla@exemplo.com" já tem conta
    Quando faço o mesmo cadastro
    Então a API responde 409 "Email já está em uso"

  Cenário: lista de papéis vazia
    Quando faço o cadastro com papeis []
    Então a API responde 400 "Ao menos um papel é obrigatório."

  Cenário: papel inexistente
    Quando faço o cadastro com papeis ["GERENTE"]
    Então a API responde 400 "Papel deve ser um de: ADMIN_PLATAFORMA, ADMIN_INSTITUICAO, OPERADOR, USUARIO_FINAL"

  Cenário: cadastro em outra instituição
    Dado um ADMIN_INSTITUICAO da instituição "A"
    Quando faço POST /instituicoes/B/usuarios
    Então a API responde 403 "recurso pertence a outra instituição"
```

### US-013 Alterar papéis e status do usuário

**Como** administrador da instituição, **quero** alterar papéis e ativar ou desativar usuários, **para** ajustar o acesso da equipe à medida que ela muda.

- Vínculo: UC-05 · RF: pendente · Prioridade: Must
- Regras: `PATCH /usuarios/:id` aceita `nome`, `papeis`, `ativo`, `instituicaoId` e `senha`. Alterar papéis invalida o cache de 30 s do `AuthMiddleware`, então a mudança vale no próximo request. Usuário com `ativo: false` recebe 403 em toda rota protegida.

```gherkin
Funcionalidade: Alteração de papéis e status

  Cenário: troca de papel de operador para administrador da instituição
    Dado um OPERADOR da instituição "A"
    Quando o ADMIN_INSTITUICAO da instituição "A" faz PATCH /usuarios/{id} com papeis ["ADMIN_INSTITUICAO"]
    Então a API responde 200
    E o novo papel vale no próximo request do usuário

  Cenário: desativação de usuário
    Quando faço PATCH /usuarios/{id} com ativo false
    Então as próximas requisições do usuário recebem 403 "Usuário inativo. Procure o administrador da instituição."

  Cenário: instituição de destino inativa
    Quando faço PATCH /usuarios/{id} com instituicaoId de uma instituição inativa
    Então a API responde 400 "Instituição inválida ou inativa"

  @lacuna
  Cenário: administrador altera usuário de outra instituição
    Dado um ADMIN_INSTITUICAO da instituição "A" e um usuário da instituição "B"
    Quando faço PATCH /usuarios/{id} com qualquer alteração
    Então a API responde 403 "recurso pertence a outra instituição"
    # Hoje a alteração é aceita (D-01).

  @lacuna
  Cenário: administrador concede papel de plataforma
    Dado um ADMIN_INSTITUICAO
    Quando faço PATCH /usuarios/{id} com papeis ["ADMIN_PLATAFORMA"]
    Então a API responde 403 "permissão insuficiente"
    # Hoje a alteração é aceita (D-01).
```

### US-014 Remover usuário

**Como** administrador da instituição, **quero** remover um usuário que não deve mais ter acesso, **para** encerrar o vínculo com a instituição.

- Vínculo: UC-05 · RF: pendente · Prioridade: Should
- Regras: `DELETE /usuarios/:id` (204). `ADMIN_PLATAFORMA` remove qualquer usuário; `ADMIN_INSTITUICAO` só da própria instituição. Sessões, contas e papéis são apagados; senhas e auditorias ficam com a referência anulada.

```gherkin
Funcionalidade: Remoção de usuário

  Cenário: remoção de usuário da própria instituição
    Dado um ADMIN_INSTITUICAO da instituição "A" e um OPERADOR da instituição "A"
    Quando faço DELETE /usuarios/{id}
    Então a API responde 204
    E as sessões e papéis do usuário são apagados
    E as senhas do usuário permanecem com o usuário anulado
    E é registrada auditoria DELETAR_USUARIO

  Cenário: remoção de usuário de outra instituição
    Dado um ADMIN_INSTITUICAO da instituição "A" e um usuário da instituição "B"
    Quando faço DELETE /usuarios/{id}
    Então a API responde 403 "Sem permissão para remover este usuário"

  Cenário: usuário inexistente
    Quando faço DELETE /usuarios/id-inexistente
    Então a API responde 404
```

## UC-06 Gerenciar filas

### US-015 Criar fila

**Como** operador, **quero** criar uma fila com seu tipo de atendimento e suas estações, **para** receber senhas dos cidadãos.

- Vínculo: UC-06 · RF: pendente · Prioridade: Must
- Regras: `POST /filas` por `ADMIN_INSTITUICAO` ou `OPERADOR`. `tipoAtendimento` é `ONLINE`, `PRESENCIAL` ou `HIBRIDO`. `modoQrCode` padrão `ROTATIVO`. `tempoExibicaoMin` entre 1 e 60 (padrão 5). `tempoAlertaSegundos` entre 5 e 120 (padrão 30). `mesas` cria as estações. A instituição vem da sessão e a instituição precisa estar ativa.

```gherkin
Funcionalidade: Criação de fila

  Cenário: criação de fila online com estações
    Dado um OPERADOR da instituição "A" com a instituição ativa
    Quando faço POST /filas com nome "Atendimento Geral", tipoAtendimento "ONLINE" e mesas [{ "numero": "1" }]
    Então a API responde 201 com a fila e a estação criadas
    E é registrada auditoria CRIAR_FILA
    E a instituição recebe o evento fila:criada

  Cenário: tipo de atendimento inválido
    Quando faço POST /filas com tipoAtendimento "DRIVE_THRU"
    Então a API responde 400 "tipoAtendimento deve ser ONLINE, PRESENCIAL ou HIBRIDO"

  Cenário: tempo de alerta fora da faixa
    Quando faço POST /filas com tempoAlertaSegundos 3
    Então a API responde 400 de validação

  Cenário: instituição inativa
    Dado que a instituição do operador está inativa
    Quando faço POST /filas
    Então a API responde 400 "Instituição inválida ou inativa"

  Cenário: cidadão tenta criar fila
    Dado um USUARIO_FINAL
    Quando faço POST /filas
    Então a API responde 403 "permissão insuficiente"
```

### US-016 Editar e desativar fila

**Como** operador, **quero** alterar as configurações da fila e desativá-la, **para** ajustar o atendimento ou suspendê-lo sem apagar o histórico.

- Vínculo: UC-06 · RF: pendente · Prioridade: Must
- Regras: `PATCH /filas/:id` aceita os mesmos campos de criação, todos opcionais. `mesas`, quando enviado, substitui a lista de estações. `ativa: false` faz a fila deixar de aceitar senhas.

```gherkin
Funcionalidade: Edição de fila

  Cenário: desativação da fila
    Dado uma fila ativa com senhas aguardando
    Quando faço PATCH /filas/{id} com ativa false
    Então a fila deixa de aceitar novas senhas
    E as senhas já emitidas continuam no fluxo

  Cenário: troca de estações
    Quando faço PATCH /filas/{id} com mesas [{ "numero": "1", "nome": "Guichê 1" }, { "numero": "2" }]
    Então a lista de estações da fila é substituída pela enviada

  Cenário: nova senha em fila desativada
    Dado uma fila com ativa false
    Quando um cidadão faz POST /filas/{id}/senhas
    Então a API responde 400 "Fila inválida ou inativa"

  @lacuna
  Cenário: operador edita fila de outra instituição
    Dado um OPERADOR da instituição "A" e uma fila da instituição "B"
    Quando faço PATCH /filas/{id} de fila da instituição "B"
    Então a API responde 403 "recurso pertence a outra instituição"
    # Hoje a alteração é aceita (D-02).
```

### US-017 Excluir fila

**Como** administrador da instituição, **quero** excluir uma fila criada por engano, **para** manter apenas filas em uso.

- Vínculo: UC-06 · RF: pendente · Prioridade: Should
- Regras: `DELETE /filas/:id` somente `ADMIN_INSTITUICAO`. A exclusão apaga estações, QR Codes e senhas da fila. A exclusão é irreversível; para preservar o histórico da fila, desative-a (US-016).

```gherkin
Funcionalidade: Exclusão de fila

  Cenário: exclusão de fila da própria instituição
    Dado um ADMIN_INSTITUICAO da instituição "A" e uma fila da instituição "A"
    Quando faço DELETE /filas/{id}
    Então a API responde 204
    E as estações, QR Codes e senhas da fila são apagados
    E é registrada auditoria DELETAR_FILA

  Cenário: operador tenta excluir fila
    Dado um OPERADOR da instituição "A"
    Quando faço DELETE /filas/{id}
    Então a API responde 403 "permissão insuficiente"

  @lacuna
  Cenário: administrador exclui fila de outra instituição
    Dado um ADMIN_INSTITUICAO da instituição "A" e uma fila da instituição "B"
    Quando faço DELETE /filas/{id}
    Então a API responde 403 "recurso pertence a outra instituição"
    # Hoje a exclusão é aceita (D-02).
```

## UC-07 Configurar tipos de etapa

### US-018 Definir tipos de etapa

**Como** administrador da instituição, **quero** definir a lista de tipos de etapa da instituição, **para** usá-la na composição dos fluxos de atendimento.

- Vínculo: UC-07 · RF: pendente · Prioridade: Should
- Regras: `PUT /instituicoes/:instituicaoId/tipos-etapa` recebe a lista inteira (`codigo`, `nome`, `cor`, `ativo`) e substitui a anterior. Permitido a `ADMIN_PLATAFORMA` e `ADMIN_INSTITUICAO` (da própria instituição).
- Atenção: o caminho está ligado ao repositório de forma incompleta (D-10). O cenário de sucesso está marcado como `@defeito` até ser executado.

```gherkin
Funcionalidade: Tipos de etapa

  @defeito
  Cenário: substituição da lista de tipos
    Dado um ADMIN_INSTITUICAO da instituição "A"
    Quando faço PUT /instituicoes/A/tipos-etapa com [{ "codigo": "TRIAGEM", "nome": "Triagem" }]
    Então a API responde 200 com a nova lista
    E a lista anterior deixa de existir

  Cenário: operador tenta alterar tipos de etapa
    Dado um OPERADOR da instituição "A"
    Quando faço PUT /instituicoes/A/tipos-etapa
    Então a API responde 403 "permissão insuficiente"

  Cenário: administrador de outra instituição
    Dado um ADMIN_INSTITUICAO da instituição "A"
    Quando faço PUT /instituicoes/B/tipos-etapa
    Então a API responde 403 "recurso pertence a outra instituição"
```

### US-019 Consultar tipos de etapa

**Como** operador, **quero** consultar os tipos de etapa da minha instituição, **para** escolher a etapa correta ao montar um fluxo.

- Vínculo: UC-07 · RF: pendente · Prioridade: Should
- Regras: `GET /instituicoes/:instituicaoId/tipos-etapa` para `ADMIN_PLATAFORMA`, `ADMIN_INSTITUICAO` e `OPERADOR`, sempre da própria instituição. Retorna `codigo`, `nome`, `cor` e `ativo`.

```gherkin
Funcionalidade: Consulta de tipos de etapa

  Cenário: operador consulta a própria instituição
    Dado um OPERADOR da instituição "A" e tipos de etapa cadastrados
    Quando faço GET /instituicoes/A/tipos-etapa
    Então recebo codigo, nome, cor e ativo de cada tipo

  Cenário: operador consulta outra instituição
    Dado um OPERADOR da instituição "A"
    Quando faço GET /instituicoes/B/tipos-etapa
    Então a API responde 403 "recurso pertence a outra instituição"
```

## UC-08 Emitir senha online

### US-020 Retirar senha em fila online

**Como** cidadão, **quero** retirar uma senha em uma fila online pelo celular, **para** aguardar sem sair de casa.

- Vínculo: UC-08 · RF: pendente · Prioridade: Must
- Regras: `POST /filas/:filaId/senhas`, somente `USUARIO_FINAL`. Ordem das validações: fila existente e ativa (400); cidadão sem senha `AGUARDANDO` ou `EM_ATENDIMENTO` na mesma fila (409); fila `PRESENCIAL` exige QR Code válido (409). Resposta 201 com `id`, `numero`, `posicao` e `status: AGUARDANDO`. Gera auditoria `CRIAR_SENHA` e evento `senha:criada`.
- Pré-condição: o cidadão precisa do papel `USUARIO_FINAL` (D-03).

```gherkin
Funcionalidade: Retirada de senha online

  Cenário: retirada de senha em fila online
    Dado um USUARIO_FINAL sem senha ativa na fila "Atendimento Geral"
    Quando faço POST /filas/{filaId}/senhas
    Então a API responde 201 com id, numero, posicao e status "AGUARDANDO"
    E a posição é calculada dentro da prioridade da senha
    E é registrada auditoria CRIAR_SENHA

  Cenário: cidadão já tem senha ativa na fila
    Dado um USUARIO_FINAL com senha AGUARDANDO na fila
    Quando faço POST /filas/{filaId}/senhas de novo
    Então a API responde 409 "Usuário já possui senha ativa nesta fila"

  Cenário: fila inativa
    Dado uma fila com ativa false
    Quando faço POST /filas/{filaId}/senhas
    Então a API responde 400 "Fila inválida ou inativa"

  Cenário: operador tenta retirar senha por essa rota
    Dado um OPERADOR
    Quando faço POST /filas/{filaId}/senhas
    Então a API responde 403 "permissão insuficiente"
```

### US-021 Retirar senha com prioridade

**Como** cidadão idoso, PcD ou gestante, **quero** informar minha prioridade ao retirar a senha, **para** ser atendido antes dos demais quando a fila aceitar esse critério.

- Vínculo: UC-08 · RF: pendente · Prioridade: Should
- Regras: `LEGAL` (idoso, PcD, gestante) vale só se a fila tiver `prioridadesHabilitadas`. `FIDELIDADE` vale só se tiver `fidelidadeHabilitada`. Caso contrário a prioridade é ignorada e a senha entra como normal (peso 3). A prioridade define a posição inicial; não há reordenação retroativa. A próxima senha é a de menor `prioridadePeso` e depois a de menor `posicao`.

```gherkin
Funcionalidade: Prioridade na retirada

  Cenário: prioridade legal em fila que a aceita
    Dado uma fila com prioridadesHabilitadas verdadeiro
    Quando um USUARIO_FINAL retira senha com prioridade "LEGAL"
    Então a senha fica com prioridade "LEGAL" e prioridadePeso 1
    E a posição é calculada dentro dessa prioridade

  Cenário de exceção: prioridade não habilitada na fila
    Dado uma fila com fidelidadeHabilitada falso
    Quando um USUARIO_FINAL retira senha com prioridade "FIDELIDADE"
    Então a API responde 201
    E a senha entra com prioridadePeso 3, como senha normal
```

### US-022 Retirar senha com QR Code em fila presencial

**Como** cidadão, **quero** escanear o QR Code da fila presencial antes de retirar a senha, **para** comprovar que estou no local de atendimento.

- Vínculo: UC-08 · RF: pendente · Prioridade: Must
- Regras: o QR precisa pertencer à fila, estar `ativo` e estar dentro de `validoAte` ou de `toleranciaAte`. A comparação do código ignora maiúsculas e minúsculas. QR inválido, expirado ou ausente responde 409 "QR Code inválido ou expirado".

```gherkin
Funcionalidade: Senha com QR Code

  Cenário: QR Code válido em fila presencial
    Dado uma fila PRESENCIAL com QR Code ativo dentro da validade
    Quando um USUARIO_FINAL faz POST /filas/{filaId}/senhas com o código do QR
    Então a API responde 201 e a senha fica AGUARDANDO

  Cenário: QR expirado
    Dado um QR Code cuja validoAte e toleranciaAte já passaram
    Quando um USUARIO_FINAL retira senha com esse código
    Então a API responde 409 "QR Code inválido ou expirado"

  Cenário: QR de outra fila
    Dado um QR Code da fila "B"
    Quando um USUARIO_FINAL retira senha na fila "A" com esse código
    Então a API responde 409 "QR Code inválido ou expirado"

  @lacuna
  Cenário: fila híbrida sem QR Code
    Dado uma fila HIBRIDO
    Quando um USUARIO_FINAL retira senha sem qrCode
    Então a API responde 409 "QR Code inválido ou expirado"
    # Hoje a senha é emitida, pois o código só exige QR em fila PRESENCIAL (D-08).
```

## UC-09 Emitir senha presencial

### US-023 Emitir senha presencial

**Como** operador, **quero** emitir senha para um cidadão que está no balcão e não tem celular, **para** incluí-lo na fila como os demais.

- Vínculo: UC-09 · RF: pendente · Prioridade: Must
- Regras: `POST /filas/:filaId/senhas/presencial` por `ADMIN_INSTITUICAO` ou `OPERADOR`, somente em fila da própria instituição. Não exige QR Code. A senha sai com `presencial: true`, `usuarioId` nulo e `nomeCidadao`; sem nome informado, usa "Cidadão Presencial".

```gherkin
Funcionalidade: Senha presencial

  Cenário: emissão com nome do cidadão
    Dado um OPERADOR da instituição "A" e uma fila ativa da instituição "A"
    Quando faço POST /filas/{filaId}/senhas/presencial com nomeCidadao "José Lima"
    Então a API responde 201 com presencial true e usuarioId nulo
    E o nomeCidadao gravado é "José Lima"
    E é registrada auditoria CRIAR_SENHA com presencial e nomeCidadao

  Cenário: emissão sem nome
    Quando faço POST /filas/{filaId}/senhas/presencial sem nomeCidadao
    Então o nomeCidadao gravado é "Cidadão Presencial"

  Cenário: fila de outra instituição
    Dado um OPERADOR da instituição "A" e uma fila da instituição "B"
    Quando faço POST /filas/{filaId}/senhas/presencial
    Então a API responde 403 "Acesso negado: fila pertence a outra instituição"

  Cenário: fila inativa
    Dado uma fila com ativa false
    Quando faço POST /filas/{filaId}/senhas/presencial
    Então a API responde 400 "Fila inválida ou inativa"
```

## UC-10 Chamar, rechamar e assumir senha

### US-024 Chamar próxima senha

**Como** operador, **quero** chamar a próxima senha da fila para uma estação de atendimento, **para** iniciar o atendimento e avisar o cidadão.

- Vínculo: UC-10 · RF: pendente · Prioridade: Must
- Regras: `POST /senhas/:id/chamar` com `mesa` opcional, por `ADMIN_INSTITUICAO` ou `OPERADOR`. A senha precisa estar `AGUARDANDO` (409). O operador não pode ter outra senha `EM_ATENDIMENTO` (409). A estação não pode estar ocupada na fila (409). A senha passa a `EM_ATENDIMENTO` com `operadorId`, `mesa` e `mesaNome` (nome configurado da estação ou "Estação N"). Notifica o cidadão (`SENHA_CHAMADA`), grava auditoria `CHAMAR_SENHA` e emite `senha:chamada`. `GET /senhas/meu-atendimento` devolve a senha em atendimento do operador, ou `null`.

```gherkin
Funcionalidade: Chamada de senha

  Cenário: chamada com estação configurada
    Dado uma senha AGUARDANDO e uma estação "1" com nome "Guichê 1"
    Quando o operador faz POST /senhas/{id}/chamar com mesa "1"
    Então a senha fica EM_ATENDIMENTO com operadorId do operador, mesa "1" e mesaNome "Guichê 1"
    E o cidadão recebe a notificação SENHA_CHAMADA
    E é registrada auditoria CHAMAR_SENHA

  Cenário: consulta do atendimento atual
    Dado um operador com uma senha EM_ATENDIMENTO
    Quando faço GET /senhas/meu-atendimento
    Então recebo essa senha

  Cenário: consulta sem atendimento em curso
    Dado um operador sem senha EM_ATENDIMENTO
    Quando faço GET /senhas/meu-atendimento
    Então recebo null

  Cenário: senha que não está aguardando
    Dado uma senha EM_ATENDIMENTO
    Quando o operador tenta chamá-la
    Então a API responde 409 "Apenas senhas com status AGUARDANDO podem ser chamadas"

  Cenário: operador com atendimento em curso
    Dado um operador atendendo a senha 12 na fila "Triagem"
    Quando tenta chamar outra senha
    Então a API responde 409 com mensagem que cita a senha 12, a fila "Triagem" e pede para finalizar o atendimento atual

  Cenário: estação ocupada
    Dado que a estação "2" está em uso por outro atendimento na fila
    Quando o operador chama uma senha com mesa "2"
    Então a API responde 409 "Estação 2 já está em uso por outro atendimento"

  Cenário: senha de outra instituição
    Dado uma senha da instituição "B"
    Quando um operador da instituição "A" tenta chamá-la
    Então a API responde 403 "Acesso negado: senha pertence a outra instituição"
```

### US-025 Pular cidadão já em atendimento

**Como** operador, **quero** que o sistema pule o cidadão que já está sendo atendido em outra fila, **para** não atender a mesma pessoa duas vezes ao mesmo tempo.

- Vínculo: UC-10 · RF: pendente · Prioridade: Should
- Regras: se o cidadão da senha já está `EM_ATENDIMENTO` em outra fila da mesma instituição, a senha vai para o fim da fila e o sistema tenta a próxima `AGUARDANDO`. Outras instituições não bloqueiam. Se todas forem puladas, a resposta não é erro: traz `skipped: true` e `allSkipped: true`, com a mensagem de cada pulo.

```gherkin
Funcionalidade: Pulo de cidadão em atendimento

  Cenário: próxima senha chamada após pulo
    Dado a senha 5 cujo cidadão está EM_ATENDIMENTO na fila "Triagem"
    E a senha 6 AGUARDANDO na mesma fila com cidadão livre
    Quando o operador chama a próxima senha da fila
    Então a senha 5 é movida para o fim da fila
    E a senha 6 fica EM_ATENDIMENTO
    E a resposta traz skippedMessages com o aviso da senha 5

  Cenário: todas as senhas puladas
    Dado que todas as senhas AGUARDANDO têm cidadãos já em atendimento na instituição
    Quando o operador chama a próxima senha da fila
    Então a resposta traz skipped true e allSkipped true
    E nenhuma senha muda para EM_ATENDIMENTO
```

### US-026 Rechamar senha

**Como** operador responsável pelo atendimento, **quero** rechamar o cidadão, **para** avisá-lo de novo quando ele não aparece.

- Vínculo: UC-10 · RF: pendente · Prioridade: Should
- Regras: `POST /senhas/:id/rechamar` só pelo operador responsável (403 para os demais). A senha precisa estar `EM_ATENDIMENTO` (409). O estado não muda. Emite `senha:chamada` com `rechamada: true` e grava auditoria `RECHAMAR_SENHA`.

```gherkin
Funcionalidade: Rechamada de senha

  Cenário: operador responsável rechama
    Dado uma senha EM_ATENDIMENTO com o operador "Marcos" como responsável
    Quando Marcos faz POST /senhas/{id}/rechamar
    Então a API responde 200
    E o estado da senha continua EM_ATENDIMENTO
    E é emitido o evento senha:chamada com rechamada true
    E é registrada auditoria RECHAMAR_SENHA

  Cenário: outro operador tenta rechamar
    Dado uma senha EM_ATENDIMENTO com o operador "Marcos" como responsável
    Quando a operadora "Ana" faz POST /senhas/{id}/rechamar
    Então a API responde 403 "Apenas o operador responsável pode rechamar a senha"

  Cenário: senha aguardando
    Dado uma senha AGUARDANDO
    Quando faço POST /senhas/{id}/rechamar
    Então a API responde 409 "Apenas senhas EM_ATENDIMENTO podem ser rechamadas"
```

### US-027 Assumir atendimento de outro operador

**Como** administrador da instituição, **quero** assumir um atendimento que está com outro operador, **para** cobrir ausências e redistribuir a fila.

- Vínculo: UC-10 · RF: pendente · Prioridade: Could
- Regras: `POST /senhas/:id/assumir`, somente `ADMIN_INSTITUICAO`. Troca o `operadorId`, grava auditoria `ASSUMIR_ATENDIMENTO` com o operador anterior e notifica esse operador (`SENHA_TRANSFERIDA`). Não se assume a própria senha nem se atende duas ao mesmo tempo.

```gherkin
Funcionalidade: Assumir atendimento

  Cenário: administrador assume atendimento
    Dado uma senha EM_ATENDIMENTO com o operador "Marcos"
    Quando o ADMIN_INSTITUICAO faz POST /senhas/{id}/assumir
    Então o operador da senha passa a ser o administrador
    E Marcos recebe a notificação SENHA_TRANSFERIDA
    E é registrada auditoria ASSUMIR_ATENDIMENTO com operadorAnterior

  Cenário: administrador já é o responsável
    Dado uma senha EM_ATENDIMENTO com o próprio administrador como operador
    Quando faz POST /senhas/{id}/assumir
    Então a API responde 409 "Você já é o operador deste atendimento"

  Cenário: administrador já atende outra senha
    Dado um administrador atendendo outra senha em curso
    Quando faz POST /senhas/{id}/assumir
    Então a API responde 409 com a mensagem para finalizar o atendimento atual

  Cenário: senha não está em atendimento
    Dado uma senha AGUARDANDO
    Quando o administrador faz POST /senhas/{id}/assumir
    Então a API responde 409 "Apenas senhas EM_ATENDIMENTO podem ser assumidas"

  Cenário: operador tenta assumir
    Dado um OPERADOR
    Quando faz POST /senhas/{id}/assumir
    Então a API responde 403 "permissão insuficiente"
```

## UC-11 Finalizar ou cancelar atendimento

### US-028 Finalizar atendimento

**Como** operador, **quero** encerrar o atendimento de uma senha, **para** liberar a estação e registrar a conclusão.

- Vínculo: UC-11 · RF: pendente · Prioridade: Must
- Regras: `POST /senhas/:id/finalizar` por `ADMIN_INSTITUICAO` ou `OPERADOR` da mesma instituição. Só senhas `EM_ATENDIMENTO` (409). `FINALIZADA` é estado terminal. Grava auditoria `FINALIZAR_SENHA`, emite `senha:finalizada` e notifica o cidadão (`SENHA_FINALIZADA`).

```gherkin
Funcionalidade: Finalização de atendimento

  Cenário: finalização de atendimento em curso
    Dado uma senha EM_ATENDIMENTO atendida pelo operador "Marcos"
    Quando Marcos faz POST /senhas/{id}/finalizar
    Então a senha fica FINALIZADA
    E o cidadão recebe a notificação SENHA_FINALIZADA
    E é registrada auditoria FINALIZAR_SENHA

  Cenário: operador que não é o responsável finaliza
    Dado uma senha EM_ATENDIMENTO com o operador "Marcos"
    Quando a operadora "Ana", da mesma instituição, faz POST /senhas/{id}/finalizar
    Então a senha fica FINALIZADA
    # Comportamento do código, sem checagem de responsável (D-09).

  Cenário: senha ainda aguardando
    Dado uma senha AGUARDANDO
    Quando faço POST /senhas/{id}/finalizar
    Então a API responde 409 "Apenas senhas EM_ATENDIMENTO podem ser finalizadas"

  Cenário: senha já finalizada
    Dado uma senha FINALIZADA
    Quando faço POST /senhas/{id}/finalizar
    Então a API responde 409 "Apenas senhas EM_ATENDIMENTO podem ser finalizadas"

  Cenário: senha de outra instituição
    Dado uma senha da instituição "B"
    Quando um operador da instituição "A" faz POST /senhas/{id}/finalizar
    Então a API responde 403 "Acesso negado: senha pertence a outra instituição"
```

### US-029 Cancelar senha aguardando

**Como** cidadão, **quero** cancelar minha senha quando desistir da fila, **para** não ser chamado à toa.

- Vínculo: UC-11 · RF: pendente · Prioridade: Must
- Regras: `POST /senhas/:id/cancelar` só em `AGUARDANDO` (409). Podem cancelar o dono da senha, o `ADMIN_PLATAFORMA`, o `ADMIN_INSTITUICAO` e o `OPERADOR` da mesma instituição. Demais usuários recebem 403. Grava `CANCELADA`, auditoria `CANCELAR_SENHA`, evento `senha:atualizada` e notificação `SENHA_CANCELADA` ao cidadão.

```gherkin
Funcionalidade: Cancelamento de senha

  Cenário: cidadão cancela a própria senha
    Dado uma senha AGUARDANDO do cidadão "Ana"
    Quando Ana faz POST /senhas/{id}/cancelar
    Então a senha fica CANCELADA
    E Ana recebe a notificação SENHA_CANCELADA
    E é registrada auditoria CANCELAR_SENHA

  Cenário: operador da instituição cancela
    Dado uma senha AGUARDANDO de um cidadão da instituição "A"
    Quando um OPERADOR da instituição "A" faz POST /senhas/{id}/cancelar
    Então a senha fica CANCELADA
    # Regra do código, que inclui o OPERADOR além de AI e AP (D-09).

  Cenário: senha já em atendimento
    Dado uma senha EM_ATENDIMENTO
    Quando o dono da senha faz POST /senhas/{id}/cancelar
    Então a API responde 409 "Senha não pode ser cancelada"

  Cenário: outro cidadão tenta cancelar
    Dado uma senha AGUARDANDO do cidadão "Ana"
    Quando o cidadão "Bruno" faz POST /senhas/{id}/cancelar
    Então a API responde 403 "Sem permissão para cancelar esta senha"
```

### US-030 Encaminhar senha no flow e dar alta

**Como** operador, **quero** encaminhar o cidadão de uma etapa para outra fila do fluxo e dar alta quando o percurso terminar, **para** acompanhar atendimentos que passam por mais de um setor.

- Vínculo: UC-11 (o fluxo não consta no catálogo; ver D-13) · RF: pendente · Prioridade: Should
- Regras: `POST /flows/:id/senhas/:senhaId/ingressar` põe a senha no primeiro step e gera `tokenPublico`. Senha que já está em um flow responde 409. `POST .../encaminhar` exige transição do step atual para `toStepId`; sem transição responde 400; a senha volta para a fila de destino como `AGUARDANDO`. `POST .../alta` conclui o acompanhamento e finaliza a senha.

```gherkin
Funcionalidade: Flow de atendimento

  Cenário: encaminhamento por transição válida
    Dado uma senha no step "Triagem" com transição para o step "Atendimento"
    Quando o operador faz POST /flows/{id}/senhas/{senhaId}/encaminhar com toStepId do step "Atendimento"
    Então o histórico do step "Triagem" é fechado
    E a senha fica AGUARDANDO na fila do step "Atendimento"
    E o cidadão recebe a notificação SENHA_ENCAMINHADA_FLOW

  Cenário: encaminhamento sem transição
    Quando o operador tenta encaminhar para um step sem transição a partir do atual
    Então a API responde 400 "Não existe transição do step atual para o step pedido"

  Cenário: alta ao final do percurso
    Dado uma senha no último step do flow
    Quando o operador faz POST /flows/{id}/senhas/{senhaId}/alta
    Então o acompanhamento fica CONCLUIDO
    E a senha fica FINALIZADA

  Cenário: senha já está em outro flow
    Dado uma senha que já está em um flow
    Quando o operador tenta ingressá-la em outro flow
    Então a API responde 409 "Esta senha já está em um flow"
```

## UC-12 Gerenciar QR Codes

### US-031 Gerar QR Code da fila

**Como** operador, **quero** gerar o QR Code de uma fila, **para** exibi-lo no local e exigir a presença do cidadão na retirada da senha.

- Vínculo: UC-12 · RF: pendente · Prioridade: Must
- Regras: `POST /qrcodes` com `filaId`, por `ADMIN_INSTITUICAO` ou `OPERADOR`. Modo rotativo: validade de `tempoExpiracaoMin` (padrão 2 vezes `tempoExibicaoMin`, ou seja 10 min) e tolerância de `toleranciaMin` (padrão 1 vez a exibição, 5 min). Modo fixo: validade de 10 anos com 1 h de tolerância; se já existe QR ativo, devolve o existente. Fila inativa responde 400. Grava auditoria `GERAR_QRCODE` e emite `qrcode:novo`.

```gherkin
Funcionalidade: Geração de QR Code

  Cenário: QR rotativo com validade padrão
    Dado uma fila ativa em modo ROTATIVO sem tempos configurados
    Quando o operador faz POST /qrcodes com o filaId
    Então a API responde 201 com um QR ativo
    E validoAte é 10 minutos após a emissão
    E toleranciaAte é 5 minutos após validoAte

  Cenário: QR fixo já existente
    Dado uma fila em modo FIXO com QR ativo
    Quando o operador faz POST /qrcodes com o mesmo filaId
    Então a API devolve o QR ativo existente sem criar outro

  Cenário: fila inativa
    Dado uma fila com ativa false
    Quando faço POST /qrcodes com o filaId
    Então a API responde 400 "Fila inválida ou inativa"

  @lacuna
  Cenário: QR de fila de outra instituição
    Dado um ADMIN_INSTITUICAO da instituição "A" e uma fila da instituição "B"
    Quando faço POST /qrcodes com o filaId da fila "B"
    Então a API responde 403 "recurso pertence a outra instituição"
    # Hoje o QR é gerado (D-02).
```

### US-032 Regenerar e desativar QR Code

**Como** operador, **quero** regenerar o QR Code e desativar um QR específico, **para** invalidar um código que vazou ou que não deve mais valer.

- Vínculo: UC-12 · RF: pendente · Prioridade: Should
- Regras: `POST /qrcodes/regenerar` desativa todos os QR ativos da fila, cria um novo e emite `qrcode:regenerado`. `PATCH /qrcodes/:id/desativar` marca `ativo: false` e mantém a linha. QR desativado é recusado na retirada de senha (409).

```gherkin
Funcionalidade: Regeneração e desativação de QR Code

  Cenário: regeneração invalida o código anterior
    Dado uma fila com QR ativo "ABC"
    Quando o operador faz POST /qrcodes/regenerar com o filaId
    Então o QR "ABC" fica inativo
    E um novo QR ativo é criado
    E é emitido o evento qrcode:regenerado

  Cenário: QR desativado na retirada de senha
    Dado um QR desativado pelo operador
    Quando um cidadão retira senha com esse código
    Então a API responde 409 "QR Code inválido ou expirado"

  Cenário: desativação de QR inexistente
    Quando o operador faz PATCH /qrcodes/id-inexistente/desativar
    Então a API responde 404
```

### US-033 Consultar QR Code antes do login

**Como** cidadão, **quero** escanear o QR Code antes de entrar na conta, **para** saber em qual fila e instituição estou.

- Vínculo: UC-12 · RF: pendente · Prioridade: Must
- Regras: `GET /qrcodes/buscar/:codigo` é público e devolve nome da fila, tipo de atendimento e instituição. Código inexistente responde 404 "QR Code não encontrado. Verifique se o código é válido.". QR cuja fila foi removida responde 404 "Fila associada não encontrada".

```gherkin
Funcionalidade: Consulta pública de QR Code

  Cenário: QR válido sem login
    Dado um QR Code de uma fila "Atendimento Geral" da instituição "A"
    Quando um visitante não autenticado faz GET /qrcodes/buscar/{codigo}
    Então a API responde 200 com nome da fila, tipo de atendimento e instituição

  Cenário: código inexistente
    Quando faço GET /qrcodes/buscar/codigo-invalido
    Então a API responde 404 "QR Code não encontrado. Verifique se o código é válido."
```

## UC-13 Consultar dashboard e estatísticas

### US-034 Consultar dashboard da plataforma

**Como** administrador da plataforma, **quero** ver a situação geral do sistema, **para** acompanhar as instituições e o volume de atendimento.

- Vínculo: UC-13 · RF: pendente · Prioridade: Should
- Regras: `GET /dashboard/admin` somente `ADMIN_PLATAFORMA`. Traz instituições, pendências de aprovação, filas, senhas nas últimas 24 h e tempo médio. O fuso vem de `?timezone=`, depois do perfil, depois `America/Manaus`.

```gherkin
Funcionalidade: Dashboard da plataforma

  Cenário: consulta do dashboard geral
    Dado um ADMIN_PLATAFORMA
    Quando faço GET /dashboard/admin
    Então recebo os indicadores de instituições, pendentes, filas, senhas em 24 h e tempo médio

  Cenário: administrador da instituição tenta acessar
    Dado um ADMIN_INSTITUICAO
    Quando faço GET /dashboard/admin
    Então a API responde 403 "permissão insuficiente"
```

### US-035 Consultar dashboard da instituição

**Como** administrador ou operador, **quero** ver o andamento das filas da minha instituição, **para** decidir onde reforçar o atendimento.

- Vínculo: UC-13 · RF: pendente · Prioridade: Should
- Regras: `GET /dashboard/instituicao` para `ADMIN_PLATAFORMA`, `ADMIN_INSTITUICAO` e `OPERADOR`. Quem não é plataforma vê sempre a própria instituição; a query `instituicaoId` é ignorada para eles. `ADMIN_PLATAFORMA` precisa informar `instituicaoId`.

```gherkin
Funcionalidade: Dashboard da instituição

  Cenário: operador vê a própria instituição
    Dado um OPERADOR da instituição "A"
    Quando faço GET /dashboard/instituicao com instituicaoId "B" na query
    Então recebo os dados da instituição "A", pois a query é ignorada

  Cenário: administrador da plataforma sem instituição
    Dado um ADMIN_PLATAFORMA
    Quando faço GET /dashboard/instituicao sem instituicaoId
    Então a API responde 400 "instituicaoId é obrigatório"

  Cenário: cidadão tenta acessar
    Dado um USUARIO_FINAL
    Quando faço GET /dashboard/instituicao
    Então a API responde 403 "permissão insuficiente"
```

### US-036 Consultar estatísticas e relatório de senhas

**Como** operador, **quero** ver contagens de senhas e um relatório por período, **para** acompanhar o atendimento do dia e dos dias anteriores.

- Vínculo: UC-13 · RF: pendente · Prioridade: Could
- Regras: `GET /senhas/stats` (em atendimento, aguardando, finalizadas hoje, senhas hoje, por fila) e `GET /senhas/stats/relatorio` (`dataInicio`, `dataFim`, `timezone`). O escopo depende do papel: `ADMIN_PLATAFORMA` vê tudo; administrador e operador veem a própria instituição; `USUARIO_FINAL` vê somente as próprias senhas.

```gherkin
Funcionalidade: Estatísticas de senhas

  Cenário: operador consulta a própria instituição
    Dado um OPERADOR da instituição "A"
    Quando faço GET /senhas/stats?timezone=America/Sao_Paulo
    Então recebo contagens somente das senhas da instituição "A"

  Cenário: cidadão consulta estatísticas
    Dado um USUARIO_FINAL com duas senhas próprias
    Quando faço GET /senhas/stats/relatorio com dataInicio e dataFim
    Então as contagens consideram apenas as duas senhas do cidadão

  Cenário de exceção: consulta sem sessão
    Dado um cookie de sessão apagado
    Quando faço GET /senhas/stats
    Então a API responde 498
```

## UC-14 Consultar auditoria

### US-037 Consultar auditoria

**Como** administrador, **quero** consultar o registro de ações do sistema, **para** investigar quem fez o quê e quando.

- Vínculo: UC-14 · RF: pendente · Prioridade: Should
- Regras: `GET /auditorias` para `ADMIN_PLATAFORMA` e `ADMIN_INSTITUICAO`. Filtros: `instituicaoId`, `usuarioId`, `acao`, `entidade`, `dataInicio`, `dataFim`, `page`, `limit` (padrão 20). Ordem: mais recente primeiro. Para `ADMIN_INSTITUICAO` o filtro de instituição é sempre a própria, mesmo se outra for pedida.

```gherkin
Funcionalidade: Auditoria

  Cenário: administrador da plataforma filtra por ação
    Dado um ADMIN_PLATAFORMA
    Quando faço GET /auditorias?acao=CANCELAR_SENHA&limit=20
    Então recebo os registros de cancelamento de todas as instituições, do mais recente para o mais antigo

  Cenário: administrador da instituição pede outra instituição
    Dado um ADMIN_INSTITUICAO da instituição "A"
    Quando faço GET /auditorias?instituicaoId=B
    Então recebo somente registros da instituição "A"

  Cenário: operador tenta consultar auditoria
    Dado um OPERADOR
    Quando faço GET /auditorias
    Então a API responde 403 "permissão insuficiente"
```

## UC-15 Acompanhar minha senha

### US-038 Acompanhar minha senha

**Como** cidadão, **quero** ver a situação da minha senha, **para** saber minha posição na fila e quando será chamado.

- Vínculo: UC-15 · RF: pendente · Prioridade: Must
- Regras: `GET /senhas` lista apenas as senhas do cidadão. `GET /senhas/:id` para o cidadão só responde ao dono da senha; outro cidadão recebe 403 "Acesso negado: senha pertence a outro usuário". A resposta traz `status` (`AGUARDANDO`, `EM_ATENDIMENTO`, `CANCELADA` ou `FINALIZADA`) e a posição.

```gherkin
Funcionalidade: Acompanhamento da senha

  Cenário: cidadão vê a própria senha aguardando
    Dado um USUARIO_FINAL com senha AGUARDANDO na posição 3
    Quando faço GET /senhas
    Então recebo a senha com status "AGUARDANDO" e posicao 3

  Cenário: cidadão vê a senha de outro cidadão
    Dado uma senha do cidadão "Ana"
    Quando o cidadão "Bruno" faz GET /senhas/{id}
    Então a API responde 403 "Acesso negado: senha pertence a outro usuário"
```

### US-039 Acompanhar senha em painel público

**Como** cidadão, **quero** acompanhar minha senha pelo celular sem fazer login, **para** ver a chamada em um painel ou no próprio aparelho.

- Vínculo: UC-15 · RF: pendente · Prioridade: Should
- Regras: `GET /publico/senhas/:token/status` não exige login e devolve `numero`, `status`, `posicao`, nome da fila e nome do step atual. O `tokenPublico` só é gerado quando a senha ingressa em um flow (D-14). Token inexistente responde 404.

```gherkin
Funcionalidade: Painel público

  Cenário: consulta de senha em flow pelo token
    Dado uma senha que ingressou no flow e recebeu tokenPublico
    Quando um visitante faz GET /publico/senhas/{tokenPublico}/status
    Então a API responde 200 com numero, status, posicao, fila e stepAtual

  Cenário: token inexistente
    Quando um visitante faz GET /publico/senhas/token-inexistente/status
    Então a API responde 404 "Token inválido ou senha não encontrada"
```

### US-040 Conversar com o atendente durante o atendimento

**Como** cidadão, **quero** enviar mensagens ao atendente enquanto sou atendido, **para** esclarecer dúvidas sem sair da fila.

- Vínculo: UC-15 · RF: pendente · Prioridade: Should
- Regras: `POST /senhas/:senhaId/chat` com `texto` (1 a 2000 caracteres após aparar espaços). Só com a senha `EM_ATENDIMENTO` (409). Envia o cidadão dono ou o operador responsável (403 para os demais). Leem o cidadão, o operador responsável, administradores e operadores da instituição e o `ADMIN_PLATAFORMA`. O nome do autor é gravado no envio. Emite `chat:nova-mensagem`.

```gherkin
Funcionalidade: Chat do atendimento

  Cenário: cidadão envia mensagem durante o atendimento
    Dado uma senha EM_ATENDIMENTO com o cidadão "Ana" e o operador "Marcos"
    Quando Ana faz POST /senhas/{id}/chat com texto "Já estou na sala"
    Então a API responde 201 com a mensagem
    E o nome "Ana" fica gravado na mensagem
    E é emitido o evento chat:nova-mensagem

  Cenário: chat fora do atendimento
    Dado uma senha AGUARDANDO
    Quando Ana faz POST /senhas/{id}/chat
    Então a API responde 409 "Chat só está disponível durante o atendimento (senha EM_ATENDIMENTO)"

  Cenário: mensagem vazia
    Dado uma senha EM_ATENDIMENTO
    Quando Ana envia texto com somente espaços
    Então a API responde 400 "Mensagem não pode ser vazia"

  Cenário: administrador tenta enviar mensagem
    Dado um ADMIN_INSTITUICAO que não é o operador da senha
    Quando faz POST /senhas/{id}/chat
    Então a API responde 403 "apenas o cidadão ou o operador do atendimento podem enviar mensagens"
```

### US-041 Receber notificações de senha

**Como** cidadão, **quero** ser avisado quando minha senha for chamada, finalizada ou cancelada, **para** não perder a minha vez.

- Vínculo: UC-15 · RF: pendente · Prioridade: Should
- Regras: `GET /notificacoes` (filtro `lida`, `page`, `limit` padrão 20), `GET /notificacoes/nao-lidas` (`naoLidas`), `PATCH /notificacoes/:id/lida` e `PATCH /notificacoes/ler-todas`. Notificações não são apagadas. Marcar como lida emite `notificacao:contagem`. Envio por push é melhor esforço: falha no NPaaS só gera aviso no log.

```gherkin
Funcionalidade: Notificações

  Cenário: aviso de chamada
    Dado uma senha do cidadão "Ana"
    Quando o operador chama a senha com mesa "1"
    Então Ana recebe a notificação SENHA_CHAMADA com a mensagem "Dirija-se a: Guichê 1"
    E GET /notificacoes/nao-lidas devolve naoLidas maior que zero

  Cenário: marcar notificação como lida
    Dado uma notificação não lida de Ana
    Quando Ana faz PATCH /notificacoes/{id}/lida
    Então a notificação fica lida
    E é emitido o evento notificacao:contagem

  Cenário: notificação de outro usuário
    Dado uma notificação do cidadão "Bruno"
    Quando Ana faz PATCH /notificacoes/{id}/lida
    Então a API responde 403 "Acesso negado: notificação pertence a outro usuário"
```

## Critérios INVEST

- **Independentes:** as dependências estão na coluna "Depende de" do índice, sem ciclos.
- **Negociáveis:** cada história descreve o objetivo do ator; os detalhes de mensagens e validações estão nos cenários, que podem ser revistos sem mudar a história.
- **Valiosas:** cada história tem ator e benefício explícitos.
- **Estimáveis:** cada história cobre um fluxo ou um conjunto de endpoints de um mesmo UC.
- **Pequenas:** de 2 a 6 cenários por história, todos do mesmo fluxo.
- **Testáveis:** os cenários trazem valores concretos, status HTTP e mensagens do código.

## Divergências

Os itens abaixo são diferenças entre o código, o catálogo de UC e a documentação em `documentacao/`. Quando a regra foi decidida pelo código, a história segue o código. Os itens marcados como lacuna exigem decisão do time.

| ID | Assunto | Código | Catálogo ou documentação | Histórias |
|---|---|---|---|---|
| D-01 | Escopo do administrador da instituição sobre usuários (UC-05) | `PATCH /usuarios/:id` não confere a instituição do alvo nem impede a concessão de `ADMIN_PLATAFORMA`. `UsuarioService.atualizar` não recebe o ator | `03-papeis-e-regras.md`: AI faz tudo da própria instituição | US-013 (`@lacuna`) |
| D-02 | Escopo de filas e QR Codes por instituição (UC-06, UC-12) | `PATCH /filas/:id` e `DELETE /filas/:id` não verificam a instituição da fila. `POST /qrcodes` e `/qrcodes/regenerar` não usam `ensureInstituicao` e `QrCodeService.criar` não confere a fila | Isolamento por instituição em `03-papeis-e-regras.md` | US-016, US-017, US-031 (`@lacuna`) |
| D-03 | Papel do cidadão cadastrado (UC-01) | O cadastro não atribui `USUARIO_FINAL`. `POST /filas/:filaId/senhas` exige esse papel, então o cidadão recebe 403 ao retirar senha | `03-papeis-e-regras.md`: `USUARIO_FINAL` retira senha | US-001, US-020 (`@lacuna` em US-001) |
| D-04 | Complexidade de senha no cadastro (UC-01) | BetterAuth exige só 8 caracteres. A regra de maiúscula, minúscula, número e especial vale em `PATCH /me/senha` e no cadastro administrativo | `06-autenticacao.md` não define complexidade no cadastro | US-001, US-005 |
| D-05 | Estados e mensagens de instituição (UC-04) | `aprovar`, `rejeitar` e `reconsiderar` fora de estado respondem 400, não 409. `aprovar` aceita `REJEITADA`. `rejeitar` exige `motivoRejeicao` com 5 ou mais caracteres | `03-papeis-e-regras.md` e `07-endpoints.md`: 409; só `PENDENTE` aprova; motivo opcional | US-008, US-009, US-010 |
| D-06 | Aviso de solicitação aos administradores da plataforma (UC-03) | Não há chamada que emita `SOLICITACAO_INSTITUICAO`. O tipo existe só no enum e no seed | `03-papeis-e-regras.md`: notifica `ADMIN_PLATAFORMA` | US-007 (`@lacuna`) |
| D-07 | Notificações definidas e não emitidas | `SENHA_NOVA_NA_FILA` (aos operadores, em `criar`), `SENHA_PROXIMA` (ao próximo da fila, em `chamar`) e `FILA_CRIADA` existem em `constants/notificacao.js`, mas não são emitidas. `criarParaInstituicao` não tem chamador | `03-papeis-e-regras.md` descreve `SENHA_NOVA_NA_FILA` e `SENHA_PROXIMA` | US-020, US-024 |
| D-08 | QR Code em fila híbrida (UC-08) | `SenhaService.criar` exige QR só para `PRESENCIAL` | `03-papeis-e-regras.md`: `PRESENCIAL` ou `HIBRIDO` exige QR | US-022 (`@lacuna`) |
| D-09 | Quem finaliza e quem cancela (UC-11) | Finalizar aceita qualquer `ADMIN_INSTITUICAO` ou `OPERADOR` da instituição, sem checar o responsável. Cancelar aceita também o `OPERADOR` da instituição | `03-papeis-e-regras.md` lista cancelar para dono, AI e AP; não define o responsável para finalizar | US-028, US-029 |
| D-10 | Definição da lista de tipos de etapa (UC-07) | `PUT /instituicoes/:id/tipos-etapa` envia `tiposEtapa` a `InstituicaoRepository.atualizar` (update do Prisma com array simples). `definirTiposEtapa` existe mas não tem chamador. Não executado; provável erro 500 | `07-endpoints.md`: substitui a lista inteira | US-018 (`@defeito`) |
| D-11 | Prioridade normal | A senha sem prioridade efetiva grava `prioridade` nulo; o peso é 3. O enum `NORMAL` não é gravado | `03-papeis-e-regras.md`: "vira NORMAL" | US-021 |
| D-12 | Rechamada e notificação | O comentário de `rechamar` diz que reenvia notificação ao cidadão, mas o método só emite o evento | `03-papeis-e-regras.md`: rechamar não muda estado | US-026 |
| D-13 | Cobertura do catálogo | Recuperação de senha (US-003), flow (US-030), chat (US-040), notificações (US-041) e "assumir atendimento" (US-027) não aparecem nas descrições de UC-01 a UC-15. Foram mapeados ao UC mais próximo | Catálogo de casos de uso UC-01 a UC-15 | US-003, US-027, US-030, US-040, US-041 |
| D-14 | Painel público (UC-15) | `tokenPublico` só é gerado ao ingressar em flow. Senhas comuns não têm painel público | `06-autenticacao.md` e `07-endpoints.md`: painel e TVs | US-039 |
| D-15 | Vínculo com RF | `requisitos-funcionais.md` não existe ainda. O campo RF das histórias está pendente | Mapeamento UC para RF prometido pela frente de requisitos | Todas |

## Veja também

- [Requisitos funcionais](requisitos-funcionais.md)
- [Requisitos não funcionais](requisitos-nao-funcionais.md)
- [Backlog](backlog.md)
- [Casos de uso](../05-modelagem/casos-de-uso/README.md)
- [Template de história de usuário](../templates/historia-de-usuario.md)
- [Glossário](../01-visao/glossario.md)
