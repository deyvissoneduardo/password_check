# PasswordChecklist Widget

O widget `PasswordChecklist` em Flutter exibe regras de validação de senha em tempo real, indicando quais condições foram atendidas. Totalmente customizável em cores, mensagens, ícones e layout.

<table>
<tr>
<td>

[![Video 1](https://github.com/user-attachments/assets/663adf60-4b0d-4e85-997a-2ac43e85c273)](https://github.com/user-attachments/assets/663adf60-4b0d-4e85-997a-2ac43e85c273)

</td>
<td>

[![Video 2](https://github.com/user-attachments/assets/382d3e2e-fc8a-401d-94c1-726c9e8baa7b)](https://github.com/user-attachments/assets/382d3e2e-fc8a-401d-94c1-726c9e8baa7b)

</td>
</tr>
</table>

## Uso básico

```dart
PasswordChecklist(
  controller: myController,
  minCharacters: 8,
  onValidationChanged: (isValid) {
    setState(() => _isPasswordValid = isValid);
  },
)
```

## Parâmetros (versão 2.x)

| Parâmetro | Tipo | Padrão | Desde | Descrição |
|-----------|------|--------|-------|-----------|
| controller | TextEditingController | (obrigatório) | 1.0.0 | Controller do campo de senha |
| onValidationChanged | ValueChanged&lt;bool&gt; | (obrigatório) | 1.0.0 | Callback quando validação muda |
| checkEightCharacters | bool | true | 1.0.0 | Verifica comprimento mínimo |
| checkSpecialCharacter | bool | true | 1.0.0 | Verifica caractere especial |
| checkNumber | bool | true | 1.0.0 | Verifica número |
| checkUppercase | bool | true | 1.0.0 | Verifica maiúscula |
| checkLowercase | bool | true | 1.0.0 | Verifica minúscula |
| checkOnlyNumbers | bool | false | 2.0.0 | Rejeita senha apenas números |
| minCharacters | int | 8 | 1.0.0 | Comprimento mínimo |
| specialCharactersRegex | RegExp? | padrão | 2.0.0 | Regex para especiais |
| validColor | Color? | green | 1.0.0 | Cor quando válido |
| invalidColor | Color? | red | 1.0.0 | Cor quando inválido |
| eightCharactersMessage | String? | pt-BR | 1.0.0 | Mensagem comprimento |
| specialCharacterMessage | String? | pt-BR | 1.0.0 | Mensagem especial |
| numberMessage | String? | pt-BR | 1.0.0 | Mensagem número |
| uppercaseMessage | String? | pt-BR | 1.0.0 | Mensagem maiúscula |
| lowercaseMessage | String? | pt-BR | 1.0.0 | Mensagem minúscula |
| onlyNumbersMessage | String? | pt-BR | 2.0.0 | Mensagem apenas números |
| customIcon | Widget? | null | 1.0.0 | Ícone único para todos |
| customIconBuilder | Function? | null | 2.0.0 | Ícone por regra |
| itemSpacing | double | 8.0 | 2.0.0 | Espaço entre itens |
| validTextStyle | TextStyle? | null | 2.0.0 | Estilo texto válido |
| invalidTextStyle | TextStyle? | null | 2.0.0 | Estilo texto inválido |
| itemBuilder | Function? | null | 2.0.0 | Builder customizado |
| padding | EdgeInsetsGeometry? | null | 2.0.0 | Padding do container |
| margin | EdgeInsetsGeometry? | null | 2.0.0 | Margem do container |
| crossAxisAlignment | CrossAxisAlignment | start | 2.0.0 | Alinhamento transversal |
| mainAxisAlignment | MainAxisAlignment | start | 2.0.0 | Alinhamento principal |
| ruleOrder | List&lt;PasswordRuleType&gt;? | null | 2.0.0 | Ordem das regras |

## Compatibilidade com 1.x

A versão 2.0.0 é retrocompatível com 1.x. Parâmetros existentes mantêm o mesmo comportamento. Novos parâmetros são opcionais com defaults sensatos.

## Exemplos de customização

### Regex de caracteres especiais

```dart
PasswordChecklist(
  controller: controller,
  onValidationChanged: (_) {},
  specialCharactersRegex: RegExp(r'[!@#\$%&*]'),
)
```

### Ordem customizada das regras

```dart
import 'package:password_check/password_check.dart';

PasswordChecklist(
  controller: controller,
  onValidationChanged: (_) {},
  ruleOrder: [
    PasswordRuleType.uppercase,
    PasswordRuleType.lowercase,
    PasswordRuleType.number,
    PasswordRuleType.minCharacters,
    PasswordRuleType.specialCharacter,
  ],
)
```

### Ícone por regra

```dart
PasswordChecklist(
  controller: controller,
  onValidationChanged: (_) {},
  customIconBuilder: (ruleId, isValid) {
    return Icon(
      isValid ? Icons.check_circle : Icons.cancel,
      color: isValid ? Colors.green : Colors.red,
      size: 20,
    );
  },
)
```

### Builder customizado (controle total)

```dart
PasswordChecklist(
  controller: controller,
  onValidationChanged: (_) {},
  itemBuilder: (item) {
    return ListTile(
      leading: Icon(
        item.isValid ? Icons.done : Icons.pending,
        color: item.effectiveColor,
      ),
      title: Text(item.message),
    );
  },
)
```

### Internacionalização

```dart
PasswordChecklist(
  controller: controller,
  onValidationChanged: (_) {},
  eightCharactersMessage: 'At least 8 characters',
  specialCharacterMessage: 'One special character',
  numberMessage: 'One number',
  uppercaseMessage: 'One uppercase letter',
  lowercaseMessage: 'One lowercase letter',
  onlyNumbersMessage: 'Not only numbers',
)
```
