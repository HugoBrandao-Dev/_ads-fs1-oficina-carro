# Wireframes: Login

Fábrica de Software I · Protótipo em alta fidelidade · Desktop 1440×900 · Perfil Todos

O Login é o estado inicial do sistema para quem ainda não está autenticado. A tela divide-se em um painel institucional, com a identidade do Bancada e três indicadores da oficina, e o formulário de entrada, que pede a matrícula do funcionário e a senha. A navegação está modelada no [IFML-01](../../../ifml/README.md#ifml-01-acesso-e-painel).

## Telas

| Nº | Tela | Estado | US | UC |
|---|---|---|---|---|
| [1.01](<1.01 - Login - entrar no sistema (US-001).svg>) | Login: entrar no sistema | Padrão | US-001 | Todos (inclusão) |

Os casos de uso (UC) reproduzem os vínculos registrados nas issues do GitLab, conforme o índice de [historias-de-usuario.md](../../../../03-requisitos/historias-de-usuario.md#índice).

## Entrar no sistema

**1.01 · Login: entrar no sistema**

![Tela de login: painel escuro à esquerda com a marca Bancada e os indicadores veículos na oficina, boxes ativos e mecânicos hoje; à direita, formulário com Matrícula, Senha, opção Manter conectada, link Esqueci a senha, botão Entrar e aviso de acesso restrito por perfil](<1.01 - Login - entrar no sistema (US-001).svg>)

## Regras de comportamento

Cada linha é um cenário Gherkin das histórias da área. A coluna Situação indica se o wireframe mostra o comportamento: **Desenhado**, **Parcial** (a tela existe, mas falta parte do cenário), **Não desenhado** ou **Divergente** (a tela contradiz o cenário). Cenários marcados `@proposta` foram escritos pela equipe de documentação e ainda não estão nas issues.

| Cenário | US | Telas | Situação | Observação |
|---|---|---|---|---|
| Login com credenciais de usuário privilegiado | US-001 | 1.01 → 2.01 | Desenhado | Após "Entrar", a secretária chega ao Painel |
| Login com informação faltando ou incorreta | US-001 | — | Não desenhado | O IFML-01 prevê a mensagem de erro sob o formulário, mas o estado de erro não foi exportado |
| Login de usuário não privilegiado | US-001 | 1.01 | Parcial | A tela informa que o acesso é restrito por perfil, mas não há estado de recusa desenhado |

## Divergências e achados

| ID | Divergência | Telas | Tratamento proposto |
|---|---|---|---|
| W-01 | O link "Esqueci a senha" e a opção "Manter conectada neste terminal" não têm história de usuário. | 1.01 | Registrar a história de recuperação de senha ou retirar o link do protótipo |
| W-02 | A história fala em "login"; a tela pede "Matrícula". | 1.01 | Registrar no glossário que o login da secretária é a matrícula do funcionário |

## Veja também

- [Wireframes: todas as áreas](../../README.md)
- [Índice das telas](<../0 - Índice.md>)
- [Site map](../../../site-map.md)
- [Protótipo: revisão de usabilidade e pendências](../../../README.md)
- [IFML](../../../ifml/README.md)
- [Histórias de usuário](../../../../03-requisitos/historias-de-usuario.md)
