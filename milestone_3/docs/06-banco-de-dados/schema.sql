-- =============================================================
-- FilaCidada: DDL do SGBD PostgreSQL 17
-- Equivalente a prisma/migrations/20260805220051_init_uuid/migration.sql
-- (migracao unica, mais recente). Gerado a partir de prisma/schema.prisma.
-- Use para estudo e revisao; a aplicacao cria o banco por
-- `prisma migrate deploy`, nao por este arquivo.
--
-- Convencoes:
--   * Nomes de tabela em snake_case plural; colunas em camelCase (aspas duplas).
--   * Chave primaria UUID. O valor e gerado pelo Prisma (uuid()) no cliente,
--     por isso nao ha DEFAULT de UUID no banco.
--   * updatedAt nao tem DEFAULT no banco: o Prisma (@updatedAt) o preenche.
--   * Enums do dominio sao tipos do banco (CREATE TYPE ... AS ENUM).
-- =============================================================

-- CreateEnum
CREATE TYPE "Papel" AS ENUM ('ADMIN_PLATAFORMA', 'ADMIN_INSTITUICAO', 'OPERADOR', 'USUARIO_FINAL');

-- CreateEnum
CREATE TYPE "StatusInstituicao" AS ENUM ('PENDENTE', 'APROVADA', 'REJEITADA');

-- CreateEnum
CREATE TYPE "TipoAtendimento" AS ENUM ('ONLINE', 'PRESENCIAL', 'HIBRIDO');

-- CreateEnum
CREATE TYPE "ModoQrCode" AS ENUM ('ROTATIVO', 'FIXO');

-- CreateEnum
CREATE TYPE "StatusSenha" AS ENUM ('AGUARDANDO', 'EM_ATENDIMENTO', 'CANCELADA', 'FINALIZADA');

-- CreateEnum
CREATE TYPE "PrioridadeSenha" AS ENUM ('LEGAL', 'FIDELIDADE', 'NORMAL');

-- CreateEnum
CREATE TYPE "NotificacaoTipo" AS ENUM ('SENHA_CHAMADA', 'SENHA_FINALIZADA', 'SENHA_CANCELADA', 'SENHA_PROXIMA', 'SENHA_NOVA_NA_FILA', 'SENHA_TRANSFERIDA', 'FILA_CRIADA', 'FILA_REMOVIDA', 'FILA_ATUALIZADA', 'SOLICITACAO_INSTITUICAO', 'INSTITUICAO_APROVADA', 'INSTITUICAO_REJEITADA', 'USUARIO_CRIADO', 'SISTEMA', 'SENHA_ENCAMINHADA_FLOW', 'SENHA_MOVIDA_FILA');

-- CreateEnum
CREATE TYPE "FlowTransicaoTipo" AS ENUM ('SEQUENCIAL', 'CONDICIONAL', 'ALTA');

-- CreateEnum
CREATE TYPE "SenhaFlowStatus" AS ENUM ('EM_ANDAMENTO', 'CONCLUIDO', 'CANCELADO');

-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "emailVerified" BOOLEAN NOT NULL DEFAULT false,
    "image" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "pais" TEXT NOT NULL DEFAULT 'BR',
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "fusoHorario" VARCHAR(64) NOT NULL DEFAULT 'America/Manaus',
    "ultimoLoginEm" TIMESTAMP(3),
    "instituicaoId" UUID,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sessions" (
    "id" UUID NOT NULL,
    "token" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" UUID NOT NULL,

    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "accounts" (
    "id" UUID NOT NULL,
    "accountId" TEXT NOT NULL,
    "providerId" TEXT NOT NULL,
    "accessToken" TEXT,
    "refreshToken" TEXT,
    "accessTokenExpiresAt" TIMESTAMP(3),
    "refreshTokenExpiresAt" TIMESTAMP(3),
    "scope" TEXT,
    "idToken" TEXT,
    "password" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" UUID NOT NULL,

    CONSTRAINT "accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "verifications" (
    "id" UUID NOT NULL,
    "identifier" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "verifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "usuario_papeis" (
    "usuarioId" UUID NOT NULL,
    "papel" "Papel" NOT NULL,

    CONSTRAINT "usuario_papeis_pkey" PRIMARY KEY ("usuarioId","papel")
);

-- CreateTable
CREATE TABLE "instituicoes" (
    "id" UUID NOT NULL,
    "nome" VARCHAR(180) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "status" "StatusInstituicao" NOT NULL DEFAULT 'PENDENTE',
    "cnpj" VARCHAR(18),
    "email" VARCHAR(180),
    "telefone" VARCHAR(32),
    "responsavel" VARCHAR(180),
    "endereco" TEXT,
    "descricao" TEXT,
    "contratoUrl" TEXT,
    "motivoRejeicao" TEXT,
    "aprovadoEm" TIMESTAMP(3),
    "solicitanteId" UUID,
    "aprovadoPorId" UUID,
    "configuracoes" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "instituicoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tipos_etapa" (
    "id" UUID NOT NULL,
    "codigo" VARCHAR(64) NOT NULL,
    "nome" VARCHAR(120) NOT NULL,
    "cor" VARCHAR(32) NOT NULL DEFAULT 'gray',
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "instituicaoId" UUID NOT NULL,

    CONSTRAINT "tipos_etapa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "filas" (
    "id" UUID NOT NULL,
    "nome" VARCHAR(180) NOT NULL,
    "tipoAtendimento" "TipoAtendimento" NOT NULL,
    "ativa" BOOLEAN NOT NULL DEFAULT true,
    "prioridadesHabilitadas" BOOLEAN NOT NULL DEFAULT false,
    "fidelidadeHabilitada" BOOLEAN NOT NULL DEFAULT false,
    "tempoMaximoAtendimento" INTEGER,
    "modoQrCode" "ModoQrCode" NOT NULL DEFAULT 'ROTATIVO',
    "tempoExibicaoMin" INTEGER,
    "tempoExpiracaoMin" INTEGER,
    "toleranciaMin" INTEGER,
    "tempoAlertaSegundos" INTEGER,
    "instituicaoId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "filas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mesas" (
    "id" UUID NOT NULL,
    "numero" VARCHAR(32) NOT NULL,
    "nome" VARCHAR(120),
    "ativa" BOOLEAN NOT NULL DEFAULT true,
    "filaId" UUID NOT NULL,

    CONSTRAINT "mesas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "senhas" (
    "id" UUID NOT NULL,
    "numero" INTEGER,
    "posicao" INTEGER NOT NULL,
    "status" "StatusSenha" NOT NULL,
    "prioridade" "PrioridadeSenha",
    "prioridadePeso" INTEGER NOT NULL DEFAULT 3,
    "nomeCidadao" VARCHAR(180),
    "presencial" BOOLEAN NOT NULL DEFAULT false,
    "mesa" VARCHAR(32),
    "mesaNome" VARCHAR(120),
    "tokenPublico" VARCHAR(64),
    "filaId" UUID NOT NULL,
    "instituicaoId" UUID NOT NULL,
    "usuarioId" UUID,
    "operadorId" UUID,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "flowId" UUID,
    "flowStepAtualId" UUID,

    CONSTRAINT "senhas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "qr_codes" (
    "id" UUID NOT NULL,
    "codigo" VARCHAR(64) NOT NULL,
    "validoAte" TIMESTAMP(3) NOT NULL,
    "toleranciaAte" TIMESTAMP(3) NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "filaId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "qr_codes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auditorias" (
    "id" UUID NOT NULL,
    "acao" VARCHAR(64) NOT NULL,
    "entidade" VARCHAR(64) NOT NULL,
    "entidadeId" UUID,
    "dados" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "instituicaoId" UUID,
    "usuarioId" UUID,

    CONSTRAINT "auditorias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "landing_pages" (
    "id" UUID NOT NULL,
    "chave" VARCHAR(64) NOT NULL,
    "conteudo" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "landing_pages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notificacoes" (
    "id" UUID NOT NULL,
    "tipo" "NotificacaoTipo" NOT NULL,
    "titulo" VARCHAR(180) NOT NULL,
    "mensagem" TEXT NOT NULL,
    "dados" JSONB,
    "lida" BOOLEAN NOT NULL DEFAULT false,
    "usuarioId" UUID NOT NULL,
    "instituicaoId" UUID,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "notificacoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flows" (
    "id" UUID NOT NULL,
    "nome" VARCHAR(180) NOT NULL,
    "descricao" TEXT,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "instituicaoId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "flows_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flow_steps" (
    "id" UUID NOT NULL,
    "nome" VARCHAR(180) NOT NULL,
    "ordem" INTEGER NOT NULL,
    "tipo" VARCHAR(64) NOT NULL,
    "tempoMedioMinutos" INTEGER,
    "permiteBifurcacao" BOOLEAN NOT NULL DEFAULT false,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "flowId" UUID NOT NULL,
    "filaId" UUID NOT NULL,

    CONSTRAINT "flow_steps_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flow_transitions" (
    "id" UUID NOT NULL,
    "tipo" "FlowTransicaoTipo" NOT NULL DEFAULT 'SEQUENCIAL',
    "label" VARCHAR(120),
    "flowId" UUID NOT NULL,
    "fromStepId" UUID NOT NULL,
    "toStepId" UUID NOT NULL,

    CONSTRAINT "flow_transitions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "senha_flow_trackings" (
    "id" UUID NOT NULL,
    "status" "SenhaFlowStatus" NOT NULL DEFAULT 'EM_ANDAMENTO',
    "senhaId" UUID NOT NULL,
    "flowId" UUID NOT NULL,
    "stepAtualId" UUID,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "senha_flow_trackings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "senha_flow_historicos" (
    "id" UUID NOT NULL,
    "stepNome" VARCHAR(180) NOT NULL,
    "filaId" VARCHAR(64) NOT NULL,
    "entradaEm" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "saidaEm" TIMESTAMP(3),
    "resultado" VARCHAR(120),
    "observacao" TEXT,
    "trackingId" UUID NOT NULL,
    "stepId" UUID NOT NULL,
    "operadorId" UUID,

    CONSTRAINT "senha_flow_historicos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chat_mensagens" (
    "id" UUID NOT NULL,
    "texto" TEXT NOT NULL,
    "nome" VARCHAR(180) NOT NULL,
    "senhaId" UUID NOT NULL,
    "usuarioId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "chat_mensagens_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_instituicaoId_idx" ON "users"("instituicaoId");

-- CreateIndex
CREATE INDEX "users_ativo_idx" ON "users"("ativo");

-- CreateIndex
CREATE UNIQUE INDEX "sessions_token_key" ON "sessions"("token");

-- CreateIndex
CREATE INDEX "sessions_userId_idx" ON "sessions"("userId");

-- CreateIndex
CREATE INDEX "sessions_expiresAt_idx" ON "sessions"("expiresAt");

-- CreateIndex
CREATE INDEX "accounts_userId_idx" ON "accounts"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "accounts_providerId_accountId_key" ON "accounts"("providerId", "accountId");

-- CreateIndex
CREATE INDEX "verifications_identifier_idx" ON "verifications"("identifier");

-- CreateIndex
CREATE INDEX "verifications_expiresAt_idx" ON "verifications"("expiresAt");

-- CreateIndex
CREATE INDEX "usuario_papeis_papel_idx" ON "usuario_papeis"("papel");

-- CreateIndex
CREATE UNIQUE INDEX "instituicoes_nome_key" ON "instituicoes"("nome");

-- CreateIndex
CREATE INDEX "instituicoes_status_idx" ON "instituicoes"("status");

-- CreateIndex
CREATE INDEX "instituicoes_ativo_idx" ON "instituicoes"("ativo");

-- CreateIndex
CREATE UNIQUE INDEX "tipos_etapa_instituicaoId_codigo_key" ON "tipos_etapa"("instituicaoId", "codigo");

-- CreateIndex
CREATE INDEX "filas_instituicaoId_idx" ON "filas"("instituicaoId");

-- CreateIndex
CREATE INDEX "filas_instituicaoId_ativa_idx" ON "filas"("instituicaoId", "ativa");

-- CreateIndex
CREATE UNIQUE INDEX "mesas_filaId_numero_key" ON "mesas"("filaId", "numero");

-- CreateIndex
CREATE UNIQUE INDEX "senhas_tokenPublico_key" ON "senhas"("tokenPublico");

-- CreateIndex
CREATE INDEX "senhas_filaId_status_prioridadePeso_posicao_idx" ON "senhas"("filaId", "status", "prioridadePeso", "posicao");

-- CreateIndex
CREATE INDEX "senhas_usuarioId_filaId_status_idx" ON "senhas"("usuarioId", "filaId", "status");

-- CreateIndex
CREATE INDEX "senhas_instituicaoId_numero_idx" ON "senhas"("instituicaoId", "numero");

-- CreateIndex
CREATE INDEX "senhas_operadorId_idx" ON "senhas"("operadorId");

-- CreateIndex
CREATE INDEX "senhas_flowId_idx" ON "senhas"("flowId");

-- CreateIndex
CREATE UNIQUE INDEX "qr_codes_codigo_key" ON "qr_codes"("codigo");

-- CreateIndex
CREATE INDEX "qr_codes_filaId_ativo_idx" ON "qr_codes"("filaId", "ativo");

-- CreateIndex
CREATE INDEX "qr_codes_validoAte_idx" ON "qr_codes"("validoAte");

-- CreateIndex
CREATE INDEX "auditorias_instituicaoId_createdAt_idx" ON "auditorias"("instituicaoId", "createdAt");

-- CreateIndex
CREATE INDEX "auditorias_entidade_entidadeId_idx" ON "auditorias"("entidade", "entidadeId");

-- CreateIndex
CREATE INDEX "auditorias_usuarioId_idx" ON "auditorias"("usuarioId");

-- CreateIndex
CREATE UNIQUE INDEX "landing_pages_chave_key" ON "landing_pages"("chave");

-- CreateIndex
CREATE INDEX "notificacoes_usuarioId_lida_idx" ON "notificacoes"("usuarioId", "lida");

-- CreateIndex
CREATE INDEX "notificacoes_usuarioId_createdAt_idx" ON "notificacoes"("usuarioId", "createdAt" DESC);

-- CreateIndex
CREATE INDEX "flows_instituicaoId_ativo_idx" ON "flows"("instituicaoId", "ativo");

-- CreateIndex
CREATE INDEX "flow_steps_filaId_idx" ON "flow_steps"("filaId");

-- CreateIndex
CREATE UNIQUE INDEX "flow_steps_flowId_ordem_key" ON "flow_steps"("flowId", "ordem");

-- CreateIndex
CREATE INDEX "flow_transitions_flowId_idx" ON "flow_transitions"("flowId");

-- CreateIndex
CREATE UNIQUE INDEX "flow_transitions_fromStepId_toStepId_key" ON "flow_transitions"("fromStepId", "toStepId");

-- CreateIndex
CREATE UNIQUE INDEX "senha_flow_trackings_senhaId_key" ON "senha_flow_trackings"("senhaId");

-- CreateIndex
CREATE INDEX "senha_flow_trackings_flowId_status_idx" ON "senha_flow_trackings"("flowId", "status");

-- CreateIndex
CREATE INDEX "senha_flow_historicos_trackingId_idx" ON "senha_flow_historicos"("trackingId");

-- CreateIndex
CREATE INDEX "chat_mensagens_senhaId_createdAt_idx" ON "chat_mensagens"("senhaId", "createdAt");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_instituicaoId_fkey" FOREIGN KEY ("instituicaoId") REFERENCES "instituicoes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usuario_papeis" ADD CONSTRAINT "usuario_papeis_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "instituicoes" ADD CONSTRAINT "instituicoes_solicitanteId_fkey" FOREIGN KEY ("solicitanteId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "instituicoes" ADD CONSTRAINT "instituicoes_aprovadoPorId_fkey" FOREIGN KEY ("aprovadoPorId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tipos_etapa" ADD CONSTRAINT "tipos_etapa_instituicaoId_fkey" FOREIGN KEY ("instituicaoId") REFERENCES "instituicoes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "filas" ADD CONSTRAINT "filas_instituicaoId_fkey" FOREIGN KEY ("instituicaoId") REFERENCES "instituicoes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mesas" ADD CONSTRAINT "mesas_filaId_fkey" FOREIGN KEY ("filaId") REFERENCES "filas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senhas" ADD CONSTRAINT "senhas_filaId_fkey" FOREIGN KEY ("filaId") REFERENCES "filas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senhas" ADD CONSTRAINT "senhas_instituicaoId_fkey" FOREIGN KEY ("instituicaoId") REFERENCES "instituicoes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senhas" ADD CONSTRAINT "senhas_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senhas" ADD CONSTRAINT "senhas_operadorId_fkey" FOREIGN KEY ("operadorId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senhas" ADD CONSTRAINT "senhas_flowId_fkey" FOREIGN KEY ("flowId") REFERENCES "flows"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senhas" ADD CONSTRAINT "senhas_flowStepAtualId_fkey" FOREIGN KEY ("flowStepAtualId") REFERENCES "flow_steps"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "qr_codes" ADD CONSTRAINT "qr_codes_filaId_fkey" FOREIGN KEY ("filaId") REFERENCES "filas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "auditorias" ADD CONSTRAINT "auditorias_instituicaoId_fkey" FOREIGN KEY ("instituicaoId") REFERENCES "instituicoes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "auditorias" ADD CONSTRAINT "auditorias_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notificacoes" ADD CONSTRAINT "notificacoes_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notificacoes" ADD CONSTRAINT "notificacoes_instituicaoId_fkey" FOREIGN KEY ("instituicaoId") REFERENCES "instituicoes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "flows" ADD CONSTRAINT "flows_instituicaoId_fkey" FOREIGN KEY ("instituicaoId") REFERENCES "instituicoes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "flow_steps" ADD CONSTRAINT "flow_steps_flowId_fkey" FOREIGN KEY ("flowId") REFERENCES "flows"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "flow_steps" ADD CONSTRAINT "flow_steps_filaId_fkey" FOREIGN KEY ("filaId") REFERENCES "filas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "flow_transitions" ADD CONSTRAINT "flow_transitions_flowId_fkey" FOREIGN KEY ("flowId") REFERENCES "flows"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "flow_transitions" ADD CONSTRAINT "flow_transitions_fromStepId_fkey" FOREIGN KEY ("fromStepId") REFERENCES "flow_steps"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "flow_transitions" ADD CONSTRAINT "flow_transitions_toStepId_fkey" FOREIGN KEY ("toStepId") REFERENCES "flow_steps"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senha_flow_trackings" ADD CONSTRAINT "senha_flow_trackings_senhaId_fkey" FOREIGN KEY ("senhaId") REFERENCES "senhas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senha_flow_trackings" ADD CONSTRAINT "senha_flow_trackings_flowId_fkey" FOREIGN KEY ("flowId") REFERENCES "flows"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senha_flow_trackings" ADD CONSTRAINT "senha_flow_trackings_stepAtualId_fkey" FOREIGN KEY ("stepAtualId") REFERENCES "flow_steps"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senha_flow_historicos" ADD CONSTRAINT "senha_flow_historicos_trackingId_fkey" FOREIGN KEY ("trackingId") REFERENCES "senha_flow_trackings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senha_flow_historicos" ADD CONSTRAINT "senha_flow_historicos_stepId_fkey" FOREIGN KEY ("stepId") REFERENCES "flow_steps"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "senha_flow_historicos" ADD CONSTRAINT "senha_flow_historicos_operadorId_fkey" FOREIGN KEY ("operadorId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_mensagens" ADD CONSTRAINT "chat_mensagens_senhaId_fkey" FOREIGN KEY ("senhaId") REFERENCES "senhas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_mensagens" ADD CONSTRAINT "chat_mensagens_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- =============================================================
-- Comentarios (COMMENT ON). Documentam o papel de tabelas e colunas
-- no proprio banco; nao alteram estrutura.
-- =============================================================

COMMENT ON TABLE "users" IS 'Usuario do sistema (contrato do BetterAuth mais campos do dominio). Classe Usuario.';
COMMENT ON TABLE "sessions" IS 'Sessao do BetterAuth. Uma linha por sessao ativa ou expirada.';
COMMENT ON TABLE "accounts" IS 'Conta de login do BetterAuth: credential (senha em password) ou provedor OAuth.';
COMMENT ON TABLE "verifications" IS 'Token temporario do BetterAuth (ex.: redefinicao de senha).';
COMMENT ON TABLE "usuario_papeis" IS 'Associacao Usuario x Papel. Chave composta (usuarioId, papel).';
COMMENT ON TABLE "instituicoes" IS 'Instituicao que possui filas. Passa pelo fluxo de solicitacao e aprovacao (status).';
COMMENT ON TABLE "tipos_etapa" IS 'Tipo de etapa de atendimento cadastrado por instituicao (codigo unico por instituicao).';
COMMENT ON TABLE "filas" IS 'Fila de atendimento da instituicao, com configuracao de QR Code em colunas.';
COMMENT ON TABLE "mesas" IS 'Mesa ou guiche de atendimento de uma fila.';
COMMENT ON TABLE "senhas" IS 'Senha (ticket) emitida numa fila, online ou presencial.';
COMMENT ON TABLE "qr_codes" IS 'QR Code de uma fila, com validade e tolerancia.';
COMMENT ON TABLE "auditorias" IS 'Trilha de auditoria append-only. Sem FK em entidadeId (registro polimorfico).';
COMMENT ON TABLE "landing_pages" IS 'Conteudo da landing page em JSON, lido inteiro pelo front.';
COMMENT ON TABLE "notificacoes" IS 'Notificacao persistida do usuario. Fonte de verdade; WebSocket e push sao efeitos colaterais.';
COMMENT ON TABLE "flows" IS 'Fluxo de atendimento da instituicao (grafo de steps e transicoes).';
COMMENT ON TABLE "flow_steps" IS 'No do flow, ligado a uma fila. Desativar, nao apagar, quando ja usado.';
COMMENT ON TABLE "flow_transitions" IS 'Aresta do flow entre dois steps.';
COMMENT ON TABLE "senha_flow_trackings" IS 'Acompanhamento de uma senha dentro de um flow. Uma linha por senha (senhaId unico).';
COMMENT ON TABLE "senha_flow_historicos" IS 'Historico append-only dos steps por onde a senha passou. Snapshot de nome e fila.';
COMMENT ON TABLE "chat_mensagens" IS 'Mensagem do chat durante o atendimento (senha EM_ATENDIMENTO).';

COMMENT ON COLUMN "senhas"."prioridadePeso" IS 'Peso de ordenacao: menor valor e chamado primeiro. LEGAL=1, FIDELIDADE=2, NORMAL ou sem prioridade=3.';
COMMENT ON COLUMN "senhas"."tokenPublico" IS 'Token publico da senha para acompanhamento sem login. Unico.';
COMMENT ON COLUMN "senhas"."mesaNome" IS 'Snapshot do nome da mesa no momento do atendimento.';
COMMENT ON COLUMN "qr_codes"."validoAte" IS 'Fim da validade do QR Code.';
COMMENT ON COLUMN "qr_codes"."toleranciaAte" IS 'Fim da tolerancia apos validoAte.';
COMMENT ON COLUMN "auditorias"."entidadeId" IS 'Id do registro afetado. Sem FK: a entidade pode nao existir mais.';
COMMENT ON COLUMN "senha_flow_historicos"."stepNome" IS 'Snapshot do nome do step no momento da entrada.';
COMMENT ON COLUMN "senha_flow_historicos"."filaId" IS 'Snapshot do id da fila (texto, sem FK): sobrevive a exclusao da fila.';
COMMENT ON COLUMN "chat_mensagens"."nome" IS 'Snapshot do nome do autor no momento do envio.';
COMMENT ON COLUMN "landing_pages"."conteudo" IS 'Documento JSON da landing page.';
