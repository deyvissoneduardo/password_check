# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

## [2.0.0] - 2025-02-23

### Added

- `checkOnlyNumbers` e `onlyNumbersMessage` para rejeitar senhas compostas apenas por números
- `customIconBuilder` para ícone customizado por regra
- `itemSpacing` para espaçamento entre itens (default: 8.0)
- `validTextStyle` e `invalidTextStyle` para customização de estilo de texto
- `itemBuilder` para controle total do layout de cada item
- `padding` e `margin` para layout do container
- `crossAxisAlignment` e `mainAxisAlignment` da coluna
- `ruleOrder` para ordem customizada das regras
- `specialCharactersRegex` para regex configurável de caracteres especiais
- Enums `PasswordRuleType` e classe `PasswordRuleItem` exportados
- Classe `PasswordChecklistMessages` com mensagens padrão em pt-BR

### Changed

- Validação inicial executada em `initState` para estado correto ao montar
- Ordem padrão das regras centralizada em `PasswordChecklist.defaultRuleOrder`

### Fixed

- Implementação de `checkOnlyNumbers` e `onlyNumbersMessage` (documentados no README 1.x mas ausentes no código)

## [1.0.0] - Data anterior

### Added

- Widget `PasswordChecklist` com validação em tempo real
- Regras: comprimento mínimo, caractere especial, número, maiúscula, minúscula
- Customização de cores, mensagens e ícone único
