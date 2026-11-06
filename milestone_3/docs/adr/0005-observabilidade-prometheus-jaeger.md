# ADR 0005: Observabilidade com OpenTelemetry, Jaeger e Prometheus

Contexto de ensino: Engenharia de Software (Fábrica de Software I), operação e monitoramento.

| Campo | Valor |
|---|---|
| Status | Aceita, implementação pendente |
| Data da decisão | Não registrada nos documentos lidos. Há arquivos de configuração no repositório, sem data de decisão |
| Data do registro | 2026-11-06 |
| Decisor | Gilberto, mantenedor do repositório |

## Contexto

O sistema já grava logs com winston em `logs/`, com rotação diária, e cada erro 500 recebe um `errorId` que aparece no log e na resposta. Logs não respondem a duas perguntas de operação: onde o tempo de uma requisição é gasto entre middlewares, banco e integrações; e qual a latência e a taxa de erro por rota ao longo do tempo.

## Decisão

Instrumentar a API com o SDK do OpenTelemetry (`@opentelemetry/sdk-node` e auto-instrumentações), exportando traces para o Jaeger. As métricas derivadas dos spans (spanmetrics) seriam expostas ao Prometheus, que alimentaria a visão de SPM do Jaeger. Os arquivos `jaeger-spm-config.yaml` e `prometheus.yml` descrevem essa cadeia.

## Estado atual

Esta decisão ainda não está operacional:

- As dependências estão instaladas no `package.json`: `@opentelemetry/sdk-node`, `@opentelemetry/auto-instrumentations-node`, `@opentelemetry/exporter-jaeger`, `@opentelemetry/api`.
- `server.js` tem `import './otel.js'` comentado, com a nota "telemetria, desativa por enquanto". O arquivo `otel.js` não existe no repositório.
- `docker-compose.yml` define `OTEL_EXPORTER_JAEGER_ENDPOINT` e `OTEL_SERVICE_NAME` no serviço `api-filas`, mas não há serviço `jaeger` nem `prometheus` no Compose. O endpoint `http://jaeger:14268` não resolve.
- Não há rota de métricas (`/metrics`) na aplicação.
- Os arquivos `prometheus.yml` e `jaeger-spm-config.yaml` não são carregados por nenhum serviço.

## Alternativas consideradas

| Alternativa | Situação |
|---|---|
| Só logs estruturados | Estado atual em produção. Não responde à pergunta de latência por etapa. |
| OpenTelemetry com Jaeger e Prometheus | Adotada como decisão, sem implementação. |
| Exportador OTLP em vez do exportador Jaeger | Não avaliada. O pacote instalado é o exportador específico do Jaeger; vale avaliar a troca antes de implementar. |

## Consequências

- Até a implementação, a observabilidade se resume a logs e ao `errorId`.
- Os arquivos de configuração parecem funcionais e não são. Quem lê o repositório pode supor que há telemetria ativa.
- Para concluir a decisão é preciso: criar `otel.js`, reativar o import em `server.js`, incluir `jaeger` e `prometheus` no Compose (ou remover as configurações) e expor ou coletar métricas.

## Evidências no código

- `server.js` (import comentado), `package.json` (dependências OpenTelemetry), `docker-compose.yml` (variáveis OTEL no `api-filas`).
- `jaeger-spm-config.yaml` e `prometheus.yml` na raiz.
- `documentacao/15-deploy.md` (seção Compose e Logs).

## Veja também

- [ADR 0003: Arquitetura em camadas com DI manual](0003-arquitetura-em-camadas-com-di-manual.md)
- [Deploy e CI](../../documentacao/15-deploy.md)
- [Retrospectiva final](../08-qualidade/retrospectiva-final.md)
- [Índice de ADRs](README.md)
