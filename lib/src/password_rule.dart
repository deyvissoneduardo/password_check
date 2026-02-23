/// Identificadores das regras de validação de senha.
///
/// Usado para [PasswordChecklist.ruleOrder] e [PasswordChecklist.customIconBuilder].
///
/// Since 2.0.0
enum PasswordRuleType {
  /// Comprimento mínimo de caracteres.
  minCharacters,

  /// Presença de caractere especial.
  specialCharacter,

  /// Presença de número.
  number,

  /// Presença de letra maiúscula.
  uppercase,

  /// Presença de letra minúscula.
  lowercase,

  /// Senha não pode ser apenas números.
  notOnlyNumbers,
}

/// Mensagens padrão em português (pt-BR).
///
/// Since 2.0.0
class PasswordChecklistMessages {
  const PasswordChecklistMessages._();

  /// Mensagem para comprimento mínimo.
  static String minCharacters(int min) =>
      'Deve conter pelo menos $min caracteres';

  /// Mensagem para caractere especial.
  static const String specialCharacter = 'Deve conter um caractere especial';

  /// Mensagem para número.
  static const String number = 'Deve conter um número';

  /// Mensagem para maiúscula.
  static const String uppercase = 'Deve conter uma letra maiúscula';

  /// Mensagem para minúscula.
  static const String lowercase = 'Deve conter uma letra minúscula';

  /// Mensagem para não apenas números.
  static const String notOnlyNumbers = 'Não deve conter apenas números';
}
