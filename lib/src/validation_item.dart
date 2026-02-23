import 'package:flutter/material.dart';

import 'password_rule.dart';

/// Contexto passado para [PasswordChecklist.itemBuilder].
///
/// Permite controle total do layout de cada item da checklist.
///
/// Since 2.0.0
class PasswordRuleItem {
  /// Identificador da regra.
  final PasswordRuleType ruleType;

  /// Mensagem exibida para esta regra.
  final String message;

  /// Se a regra está satisfeita.
  final bool isValid;

  /// Cor padrão (valid ou invalid) que seria usada.
  final Color effectiveColor;

  const PasswordRuleItem({
    required this.ruleType,
    required this.message,
    required this.isValid,
    required this.effectiveColor,
  });

  /// ID string da regra para comparação.
  String get ruleId => ruleType.name;
}
