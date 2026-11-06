# Restrições OCL do domínio

Milestone 2 · Unidade: Engenharia de Software (Fábrica de Software I) · Analista de modelagem

Este documento escreve em OCL as regras de negócio que o diagrama de classes não expressa. Cada restrição foi lida no código (`src/services/`, `src/repositories/`, `src/utils/validators/`) e no schema (`prisma/schema.prisma`). Quando [documentacao/03-papeis-e-regras.md](../../../documentacao/03-papeis-e-regras.md) diverge do código, vale o código, e a diferença está na seção [Divergências](#divergências).

## Convenções

- Sintaxe: OCL 2.4, em subconjunto (`context`, `inv`, `pre`, `post`, `@pre`, `result`, `allInstances()`, coleções `Set{...}`).
- Classes seguem a convenção de [docs/README.md](../../README.md): português, singular. Atributos e papéis de associação seguem o schema Prisma, para que cada expressão possa ser conferida campo a campo.
- `agora : Date` é parâmetro das operações que dependem do relógio. Assim a expressão não chama uma função que o modelo não define.
- Enumerações usam o nome do enum do schema, por exemplo `StatusSenha::EM_ATENDIMENTO`.
- Os códigos de erro citados são os HTTP devolvidos por `CustomError.statusCode`.

### Mapeamento schema para classes OCL

| Model Prisma | Classe OCL | Observação |
|---|---|---|
| `User` | `Usuario` | `Session`, `Account` e `Verification` são do BetterAuth e ficam fora do domínio |
| `UsuarioPapel` e enum `Papel` | `Papel` (enumeração) | `Usuario.papeis : Set(Papel)`. Ver [divergencias-m2.md](divergencias-m2.md), N-02 |
| `Instituicao` | `Instituicao` | |
| `TipoEtapa` | `TipoEtapa` | |
| `Fila` | `Fila` | |
| `Mesa` | `Mesa` | Não associada a `Senha`: `Senha.mesa` é texto. Ver [divergencias-m2.md](divergencias-m2.md), N-09 |
| `Senha` | `Senha` | |
| `QrCode` | `QrCode` | |
| `Auditoria` | `Auditoria` | |
| `Notificacao` | `Notificacao` | |
| `LandingPage` | `LandingPage` | |
| `Flow` | `Fluxo` | Grafo de atendimento por instituição |
| `FlowStep` | `PassoFluxo` | |
| `FlowTransition` | `TransicaoFluxo` | Atributos `fromStep` e `toStep` |
| `SenhaFlowTracking` | `AcompanhamentoFluxo` | |
| `SenhaFlowHistorico` | `HistoricoFluxo` | |
| `ChatMensagem` | `MensagemChat` | |

## Invariantes

Cada invariante indica o contexto em que vale, a expressão e a consequência da violação. A garantia no código e no banco está na [tabela de rastreio](#tabela-de-rastreio).

### INV-01 Senha em atendimento tem operador

Vale para `Senha`. Uma senha `EM_ATENDIMENTO` tem o operador responsável, gravado por `chamar` e `assumirAtendimento`.

```ocl
context Senha
inv OperadorEmAtendimento:
  self.status = StatusSenha::EM_ATENDIMENTO implies self.operador->notEmpty()
```

Consequência: `rechamar` passa a responder 403 para todos ("Apenas o operador responsável pode rechamar a senha"), e o painel mostra um atendimento sem responsável.

### INV-02 Senha aguardando não tem operador

Vale para `Senha`. Uma senha nova ou ainda não chamada não tem operador.

```ocl
context Senha
inv AguardandoSemOperador:
  self.status = StatusSenha::AGUARDANDO implies self.operador->isEmpty()
```

Consequência: a fila exibiria um atendente numa senha que ninguém chamou, e a auditoria de atendimento ficaria inconsistente.

### INV-03 Identificação do cidadão

Vale para `Senha`. Senha presencial é de cidadão sem conta: não tem `usuario` e tem `nomeCidadao`. Senha online tem `usuario`.

```ocl
context Senha
inv IdentificacaoDoCidadao:
  (self.presencial implies (self.usuario->isEmpty() and self.nomeCidadao->notEmpty()))
  and (not self.presencial implies self.usuario->notEmpty())
```

Consequência: senha online sem `usuario` não recebe notificação (`_notificar(senha.usuarioId)`) e não aparece em `GET /senhas`.

### INV-04 Senha na instituição da fila

Vale para `Senha`. A senha pertence à mesma instituição da fila em que foi emitida.

```ocl
context Senha
inv InstituicaoDaFila:
  self.instituicao = self.fila.instituicao
```

Consequência: um operador de uma instituição passa a enxergar ou chamar senhas de outra. O isolamento por `instituicaoId` deixa de valer.

### INV-05 Peso coerente com a prioridade

Vale para `Senha`. O peso de ordenação segue a prioridade efetiva: LEGAL = 1, FIDELIDADE = 2, sem prioridade = 3.

```ocl
context Senha
inv PesoDaPrioridade:
  (self.prioridade = PrioridadeSenha::LEGAL implies self.prioridadePeso = 1)
  and (self.prioridade = PrioridadeSenha::FIDELIDADE implies self.prioridadePeso = 2)
  and (self.prioridade.oclIsUndefined() implies self.prioridadePeso = 3)
```

Consequência: a próxima senha, ordenada por `prioridadePeso, posicao`, sairia fora de ordem. Uma senha LEGAL com peso 3 seria chamada depois de senhas NORMAL.

### INV-06 Uma senha ativa por cidadão e fila

Vale para `Senha` com `usuario` definido. Só há uma senha `AGUARDANDO` ou `EM_ATENDIMENTO` do mesmo cidadão na mesma fila.

```ocl
context Senha
inv UmaSenhaAtivaPorCidadaoNaFila:
  self.usuario->notEmpty() implies
    Senha.allInstances()->select(s |
      s.usuario = self.usuario
      and s.fila = self.fila
      and Set{StatusSenha::AGUARDANDO, StatusSenha::EM_ATENDIMENTO}->includes(s.status)
    )->size() <= 1
```

Consequência: o cidadão ocupa duas posições na mesma fila. A operação `criar` responde 409 ("Usuário já possui senha ativa nesta fila"). Duas requisições simultâneas podem passar pela checagem, porque o banco não tem restrição única para esse caso.

### INV-07 Um atendimento por operador

Vale para `Senha`. Um operador tem no máximo uma senha `EM_ATENDIMENTO`.

```ocl
context Senha
inv UmAtendimentoPorOperador:
  (self.operador->notEmpty() and self.status = StatusSenha::EM_ATENDIMENTO) implies
    Senha.allInstances()->select(s |
      s.operador = self.operador
      and s.status = StatusSenha::EM_ATENDIMENTO
    )->size() = 1
```

Consequência: o operador atende duas pessoas ao mesmo tempo. `chamar` e `assumirAtendimento` respondem 409 ("Você já está atendendo a senha ...") para impedir isso.

### INV-08 Mesa exclusiva por fila

Vale para `Senha` com `mesa` preenchida. Duas senhas `EM_ATENDIMENTO` da mesma fila não usam a mesma estação.

```ocl
context Senha
inv MesaExclusivaNaFila:
  (self.status = StatusSenha::EM_ATENDIMENTO and not self.mesa.oclIsUndefined()) implies
    Senha.allInstances()->select(s |
      s.fila = self.fila
      and s.status = StatusSenha::EM_ATENDIMENTO
      and s.mesa = self.mesa
    )->size() = 1
```

Consequência: duas pessoas são atendidas na mesma estação. `chamar` responde 409 ("Estação X já está em uso por outro atendimento").

### INV-09 Número da senha único por instituição

Vale para `Senha` com `numero` definido. Dois números iguais não existem na mesma instituição.

```ocl
context Senha
inv NumeroUnicoNaInstituicao:
  Senha.allInstances()->forAll(outra |
    (outra <> self
      and outra.instituicao = self.instituicao
      and not self.numero.oclIsUndefined()
      and not outra.numero.oclIsUndefined())
    implies outra.numero <> self.numero
  )
```

Consequência: duas senhas com o mesmo número no painel e no histórico. A unicidade depende só da transação em `calcularProximoNumero`, porque o índice do banco não é único.

### INV-10 Tolerância do QR Code não anterior à validade

Vale para `QrCode`. A janela de tolerância começa depois de `validoAte` e nunca termina antes dela.

```ocl
context QrCode
inv JanelaDeTolerancia:
  self.toleranciaAte >= self.validoAte
```

Consequência: a tolerância deixa de ter efeito e o código fica válido apenas até `validoAte`, sem o período configurado.

### INV-11 Instituição aprovada tem registro de aprovação

Vale para `Instituicao` com `status = APROVADA`.

```ocl
context Instituicao
inv AprovadaComRegistro:
  self.status = StatusInstituicao::APROVADA implies
    (self.aprovadoPor->notEmpty() and not self.aprovadoEm.oclIsUndefined())
```

Consequência: instituição ativa sem registro de quem aprovou e quando. A trilha de aprovação fica incompleta.

### INV-12 Instituição rejeitada tem motivo

Vale para `Instituicao` com `status = REJEITADA`.

```ocl
context Instituicao
inv RejeitadaComMotivo:
  self.status = StatusInstituicao::REJEITADA implies not self.motivoRejeicao.oclIsUndefined()
```

Consequência: o solicitante recebe a notificação `INSTITUICAO_REJEITADA` sem motivo (`InstituicaoService.js:142` usa `motivoRejeicao`). A validação está só na camada HTTP.

### INV-13 Solicitação pendente sem resíduos de decisão anterior

Vale para `Instituicao` com `status = PENDENTE`. Uma solicitação que volta a pendente não carrega aprovador, data ou motivo da decisão anterior.

```ocl
context Instituicao
inv PendenteSemResiduos:
  self.status = StatusInstituicao::PENDENTE implies
    (self.aprovadoPor->isEmpty()
      and self.aprovadoEm.oclIsUndefined()
      and self.motivoRejeicao.oclIsUndefined())
```

Consequência: a tela de análise mostraria um motivo de rejeição ou um aprovador numa solicitação que ainda está em análise.

### INV-14 Papel administrativo exige instituição

Vale para `Usuario` com papel `ADMIN_INSTITUICAO` ou `OPERADOR`. Esses papéis só existem vinculados a uma instituição.

```ocl
context Usuario
inv PapelAdministrativoExigeInstituicao:
  (self.papeis->includes(Papel::ADMIN_INSTITUICAO) or self.papeis->includes(Papel::OPERADOR))
  implies self.instituicao->notEmpty()
```

Consequência: um operador sem instituição recebe 403 ("usuário sem vínculo institucional") em todas as listagens escopadas por instituição. A regra vale na criação, mas não na alteração: ver D-05.

### INV-15 Transição entre passos do mesmo fluxo

Vale para `TransicaoFluxo`. Origem e destino pertencem ao fluxo da transição.

```ocl
context TransicaoFluxo
inv MesmoFluxo:
  self.fromStep.flow = self.flow and self.toStep.flow = self.flow
```

Consequência: `encaminhar` levaria a senha para um passo de outro fluxo, que o fluxo atual não conhece.

## Operações

Cada operação traz `pre` (condição de entrada) e `post` (efeito). Quando o papel exigido é imposto pela rota (`authorize` em `src/routes/senhaRoutes.js`), a `pre` aparece com o comentário `-- rota`. Em `@pre`, o valor vale antes da operação. `result` é o retorno.

### OP-01 Senha::criar (retirada online ou presencial com QR Code)

```ocl
context Senha::criar(ator : Usuario, fila : Fila, codigoQr : String,
                     prioridade : PrioridadeSenha, agora : Date) : Senha
pre UsuarioAtivo:
  ator.ativo
pre FilaAtiva:
  fila.ativa
pre SemSenhaAtivaNaFila:
  Senha.allInstances()->select(s |
    s.usuario = ator
    and s.fila = fila
    and Set{StatusSenha::AGUARDANDO, StatusSenha::EM_ATENDIMENTO}->includes(s.status)
  )->isEmpty()
pre QrCodeValidoSeFilaPresencial:
  fila.tipoAtendimento = TipoAtendimento::PRESENCIAL implies
    QrCode.allInstances()->exists(q |
      q.fila = fila
      and q.ativo
      and q.codigo.toUpper() = codigoQr.toUpper()
      and (agora <= q.validoAte or agora <= q.toleranciaAte))
post NovaSenhaAguardando:
  result.status = StatusSenha::AGUARDANDO
post VinculadaAoCidadaoEFila:
  result.usuario = ator
  and result.fila = fila
  and result.instituicao = fila.instituicao
post PrioridadeSomenteSeHabilitada:
  (result.prioridade = PrioridadeSenha::LEGAL implies fila.prioridadesHabilitadas)
  and (result.prioridade = PrioridadeSenha::FIDELIDADE implies fila.fidelidadeHabilitada)
post UmaSenhaAMais:
  Senha.allInstances()->size() = Senha.allInstances()@pre->size() + 1
```

Observações: a comparação do código é insensível a maiúsculas (`mesmoCodigo`, `QrCodeRepository.js:29`), por isso `toUpper()`. A `post PrioridadeSomenteSeHabilitada` cobre o caso em que a prioridade pedida não é habilitada: o código grava `prioridade` nula, e não `NORMAL` (ver D-02).

### OP-02 Senha::chamar

```ocl
context Senha::chamar(ator : Usuario, mesa : String)
pre EstadoAguardando:
  self.status = StatusSenha::AGUARDANDO
pre MesmaInstituicao:
  ator.instituicao = self.instituicao
pre PapelDeAtendimento:  -- rota
  ator.papeis->exists(p | p = Papel::ADMIN_INSTITUICAO or p = Papel::OPERADOR)
pre OperadorLivre:
  Senha.allInstances()->select(s |
    s.operador = ator and s.status = StatusSenha::EM_ATENDIMENTO
  )->isEmpty()
pre MesaLivre:
  mesa.oclIsUndefined() or
  Senha.allInstances()->select(s |
    s.fila = self.fila and s.mesa = mesa and s.status = StatusSenha::EM_ATENDIMENTO
  )->isEmpty()
post EmAtendimento:
  self.status = StatusSenha::EM_ATENDIMENTO
post OperadorResponsavel:
  self.operador = ator
post MesaRegistrada:
  self.mesa = mesa
post EstadoAnterior:
  self.status@pre = StatusSenha::AGUARDANDO
```

Observação: quando o cidadão da senha já está em atendimento em outra fila da mesma instituição, `chamar` não responde 409. Move a senha para o fim da fila e tenta a próxima `AGUARDANDO` (`SenhaService.js:355-370`). Por isso as `post` valem para a senha efetivamente chamada, que pode ser outra que não `self`. A resposta traz `skippedMessages` (ver D-06).

### OP-03 Senha::rechamar

```ocl
context Senha::rechamar(ator : Usuario)
pre EmAtendimento:
  self.status = StatusSenha::EM_ATENDIMENTO
pre OperadorResponsavel:
  self.operador = ator
post EstadoPreservado:
  self.status = self.status@pre
post OperadorPreservado:
  self.operador = self.operador@pre
```

Observação: `rechamar` não muda estado nem operador. Reemite o evento de chamada para o painel e não grava nova notificação.

### OP-04 Senha::finalizar

```ocl
context Senha::finalizar(ator : Usuario)
pre EmAtendimento:
  self.status = StatusSenha::EM_ATENDIMENTO
pre MesmaInstituicao:
  ator.instituicao = self.instituicao
pre PapelDeAtendimento:  -- rota
  ator.papeis->exists(p | p = Papel::ADMIN_INSTITUICAO or p = Papel::OPERADOR)
post Finalizada:
  self.status = StatusSenha::FINALIZADA
post EstadoAnterior:
  self.status@pre = StatusSenha::EM_ATENDIMENTO
post OperadorPreservado:
  self.operador = self.operador@pre
```

Observação: a operação não exige que `ator` seja o operador responsável. Qualquer AI ou OP da instituição finaliza (ver D-04).

### OP-05 Senha::cancelar

```ocl
context Senha::cancelar(ator : Usuario)
pre AguardandoApenas:
  self.status = StatusSenha::AGUARDANDO
pre Autorizado:
  self.usuario = ator
  or ator.papeis->includes(Papel::ADMIN_PLATAFORMA)
  or (ator.papeis->exists(p | p = Papel::ADMIN_INSTITUICAO or p = Papel::OPERADOR)
      and ator.instituicao = self.instituicao)
post Cancelada:
  self.status = StatusSenha::CANCELADA
post EstadoAnterior:
  self.status@pre = StatusSenha::AGUARDANDO
```

Observação: `cancelar` só vale em `AGUARDANDO`. Uma senha `EM_ATENDIMENTO` responde 409 antes de qualquer checagem de permissão (`SenhaService.js:255-258`).

### OP-06 Senha::assumirAtendimento

```ocl
context Senha::assumirAtendimento(ator : Usuario)
pre EmAtendimento:
  self.status = StatusSenha::EM_ATENDIMENTO
pre AdministradorDaInstituicao:  -- rota
  ator.papeis->includes(Papel::ADMIN_INSTITUICAO)
  and ator.instituicao = self.instituicao
pre NaoEhOperadorAtual:
  self.operador <> ator
pre SemOutroAtendimento:
  Senha.allInstances()->select(s |
    s.operador = ator and s.status = StatusSenha::EM_ATENDIMENTO
  )->isEmpty()
post NovoOperador:
  self.operador = ator
post EstadoPreservado:
  self.status = self.status@pre
post OperadorAnteriorSubstituido:
  self.operador <> self.operador@pre
```

## Tabela de rastreio

Expressão (resumida), regra e onde está garantida. "Nenhuma" no banco quer dizer que o modelo físico aceita a violação, e só o código impede.

| Ref | Expressão (resumo) | Regra | Garantia no código (arquivo:linha) | Garantia no banco |
|---|---|---|---|---|
| INV-01 | `status = EM_ATENDIMENTO implies operador->notEmpty()` | Atendimento tem responsável | `src/services/SenhaService.js:415` (chamar grava `operadorId`); `:596` (assumir) | Nenhuma: `operadorId` é nullable (`prisma/schema.prisma:308`) |
| INV-02 | `status = AGUARDANDO implies operador->isEmpty()` | Senha nova sem atendente | `SenhaService.js:166-176` (criar não grava operador); `:255-258` (cancelar só em AGUARDANDO) | Nenhuma |
| INV-03 | `presencial implies usuario->isEmpty()` e o inverso | Identificação do cidadão | `SenhaService.js:170` (online), `:226-228` (presencial) | Nenhuma: `usuarioId` nullable (`schema.prisma:306`) |
| INV-04 | `instituicao = fila.instituicao` | Isolamento por instituição | `SenhaService.js:169` e `:225` (instituicaoId vem da fila) | Nenhuma: `filaId` e `instituicaoId` são FKs independentes (`schema.prisma:302`, `:304`) |
| INV-05 | `prioridade = LEGAL implies prioridadePeso = 1`, etc. | Ordem da fila | `SenhaService.js:174` e `:232` (`SENHA_PRIORIDADE_PESO[...] ?? 3`) | Só default 3 (`schema.prisma:292`); sem check |
| INV-06 | uma senha ativa por cidadão e fila | Uma posição por fila | `SenhaService.js:145-149` (`buscarAtivaPorUsuarioEFila`, `SenhaRepository.js:73-80`) | Nenhuma: `@@index([usuarioId, filaId, status])` não é único (`schema.prisma:325`) |
| INV-07 | um `EM_ATENDIMENTO` por operador | Um atendimento por vez | `SenhaService.js:393-400` (chamar); `:583-591` (assumir) | Nenhuma: `@@index([operadorId])` não é único (`schema.prisma:327`) |
| INV-08 | mesa única por fila em atendimento | Estação exclusiva | `SenhaService.js:404-410`; `SenhaRepository.js:83-87` | Nenhuma: `mesa` é texto sem unicidade (`schema.prisma:298`) |
| INV-09 | `numero` único por instituição | Número sequencial | `SenhaRepository.js:243-250` (max + 1 dentro de `$transaction`) | Índice não único `@@index([instituicaoId, numero])` (`schema.prisma:326`) |
| INV-10 | `toleranciaAte >= validoAte` | Janela do QR Code | `QrCodeService.js:91-92` (fixo, +1 h); `:101-102` (rotativo) | Nenhuma |
| INV-11 | `APROVADA implies aprovadoPor e aprovadoEm` | Trilha de aprovação | `InstituicaoService.js:74-77` | Nenhuma: `aprovadoPorId` nullable (`schema.prisma:205`) |
| INV-12 | `REJEITADA implies motivoRejeicao` | Motivo obrigatório | `src/utils/validators/schemas/zod/InstituicaoSchema.js:35-37` (zod, camada HTTP); `InstituicaoService.js:108-124` não valida | Nenhuma: `motivoRejeicao` nullable (`schema.prisma:200`) |
| INV-13 | `PENDENTE implies` sem aprovador, data ou motivo | Reconsideração limpa a decisão | `InstituicaoService.js:158-169` (reconsiderar só em REJEITADA; zera os campos) | Nenhuma |
| INV-14 | papel administrativo exige `instituicao` | Vínculo institucional | `UsuarioService.js:122-127` (criar). Na alteração não há checagem: `UsuarioService.js:176-198` | Nenhuma: `instituicaoId` nullable (`schema.prisma:88`) |
| INV-15 | origem e destino no mesmo fluxo | Grafo consistente | `FlowService.js:92-101` (transições só entre passos do próprio fluxo, via `idPorOrdem`) | Parcial: `@@unique([fromStepId, toStepId])` (`schema.prisma:523`) não liga a transição ao fluxo |

## Divergências

Onde a documentação e o código não batem, a OCL segue o código. A tabela lista o que foi encontrado ao escrever as restrições.

| # | Documentação | Código | Tratamento na OCL |
|---|---|---|---|
| D-01 | `documentacao/03-papeis-e-regras.md`: fila `PRESENCIAL` ou `HIBRIDO` exige QR Code válido | `SenhaService.js:151`: só `TipoAtendimento.PRESENCIAL` valida o QR Code. `HIBRIDO` aceita retirada sem QR | `OP-01` usa `PRESENCIAL`. Se a regra for a documentada, a correção é no código (`SenhaService.js:151`) |
| D-02 | Prioridade não habilitada "vira NORMAL" | `SenhaService.js:672-684` retorna `null`. A senha é gravada com `prioridade` nula e `prioridadePeso` 3 | `INV-05` aceita `prioridade` indefinida com peso 3. `NORMAL` não existe como valor gravado |
| D-03 | Transição inválida de instituição responde 409 | `InstituicaoService.js:66-69`, `:111-114` e `:158-161` respondem 400. `FlowService.js:260` também responde 400 para transição inexistente | Códigos de erro citados na OCL são os do código |
| D-04 | Finalizar: "AI, OP" | `SenhaService.js:510-528` não confere se `ator` é o operador responsável; qualquer AI ou OP da instituição finaliza | `OP-04` não restringe ao operador. Rechamar, ao contrário, exige o operador (`SenhaService.js:479-485`) |
| D-05 | `instituicaoId` obrigatório para papéis administrativos | Só é checado na criação (`UsuarioService.js:122-127`). Na alteração (`UsuarioService.js:176-198`) aceita `papeis` com `ADMIN_INSTITUICAO` ou `OPERADOR` e `instituicaoId` nulo, porque `UsuarioUpdateSchema` deixa os dois opcionais | `INV-14` vale na criação. Na alteração a invariante não é garantida, e a lacuna está registrada aqui |
| D-06 | Não documentado: chamar com cidadão já em atendimento | `SenhaService.js:355-370` move a senha para o fim da fila e chama a próxima. Não há 409 | `OP-02` descreve o comportamento real (ver observação da operação) |
| D-07 | Comentário em `SenhaService.js:164` e `:220`: "Numero fixo da senha: único por instituição" | Índice `@@index([instituicaoId, numero])` não é único (`schema.prisma:326`). A unicidade vem só da transação em `calcularProximoNumero` (`SenhaRepository.js:243-250`) | `INV-09` depende do código. Um índice único em `(instituicaoId, numero)` fecharia a lacuna |
| D-08 | `documentacao/05-dados.md` (seção "Índices que são regra") apresenta `(usuarioId, filaId, status)` como regra de "cidadão já tem senha ativa aqui" | O índice não é único (`schema.prisma:325`). A regra é checada só no serviço (`SenhaService.js:145-149`), em leitura sem bloqueio; duas requisições simultâneas podem passar | `INV-06` e `INV-07` ficam marcadas como "Nenhuma" no banco na tabela de rastreio |


Veja também: [Divergências de nomes (M2)](divergencias-m2.md) · [Modelo de classes](../classes/README.md) · [Casos de uso](../casos-de-uso/README.md) · [Estados da senha](../estados/README.md) · [Papéis e regras de negócio](../../../documentacao/03-papeis-e-regras.md) · [Dicionário de dados](../../06-banco-de-dados/dicionario-de-dados.md) · [Requisitos funcionais](../../03-requisitos/requisitos-funcionais.md)
