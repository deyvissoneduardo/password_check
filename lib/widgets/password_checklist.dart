import 'package:flutter/material.dart';

import '../src/password_rule.dart';
import '../src/validation_item.dart';

/// Widget de checklist para validação de senha em tempo real.
///
/// Exibe regras configuráveis e indica visualmente quais foram atendidas.
/// Suporta customização de cores, mensagens, ícones e layout.
///
/// Example:
/// ```dart
/// PasswordChecklist(
///   controller: myController,
///   minCharacters: 8,
///   onValidationChanged: (valid) => setState(() => _isValid = valid),
/// )
/// ```
class PasswordChecklist extends StatefulWidget {
  /// Controller do campo de senha.
  final TextEditingController controller;

  /// Callback chamado quando o status de validação muda.
  final ValueChanged<bool> onValidationChanged;

  /// Verifica comprimento mínimo. Default: true.
  final bool checkEightCharacters;

  /// Verifica caractere especial. Default: true.
  final bool checkSpecialCharacter;

  /// Verifica presença de número. Default: true.
  final bool checkNumber;

  /// Verifica letra maiúscula. Default: true.
  final bool checkUppercase;

  /// Verifica letra minúscula. Default: true.
  final bool checkLowercase;

  /// Rejeita senhas compostas apenas por números. Default: false.
  /// Since 2.0.0
  final bool checkOnlyNumbers;

  /// Comprimento mínimo quando [checkEightCharacters] é true. Default: 8.
  final int minCharacters;

  /// Regex para caracteres especiais. Default: [!@#\$%^&*(),.?":{}|<>]
  /// Since 2.0.0
  final RegExp? specialCharactersRegex;

  /// Cor quando a regra está satisfeita. Default: Colors.green.
  final Color? validColor;

  /// Cor quando a regra não está satisfeita. Default: Colors.red.
  final Color? invalidColor;

  /// Mensagem para comprimento mínimo.
  final String? eightCharactersMessage;

  /// Mensagem para caractere especial.
  final String? specialCharacterMessage;

  /// Mensagem para número.
  final String? numberMessage;

  /// Mensagem para maiúscula.
  final String? uppercaseMessage;

  /// Mensagem para minúscula.
  final String? lowercaseMessage;

  /// Mensagem quando a senha é apenas números. Since 2.0.0
  final String? onlyNumbersMessage;

  /// Ícone único para todos os itens. Se [customIconBuilder] existir,
  /// este é ignorado.
  final Widget? customIcon;

  /// Ícone customizado por regra. Since 2.0.0
  final Widget? Function(String ruleId, bool isValid)? customIconBuilder;

  /// Espaço entre itens. Default: 8.0. Since 2.0.0
  final double itemSpacing;

  /// Estilo do texto quando válido. Since 2.0.0
  final TextStyle? validTextStyle;

  /// Estilo do texto quando inválido. Since 2.0.0
  final TextStyle? invalidTextStyle;

  /// Builder customizado para cada item. Se retornar não-nulo,
  /// substitui o layout padrão. Since 2.0.0
  final Widget? Function(PasswordRuleItem item)? itemBuilder;

  /// Padding interno do container. Since 2.0.0
  final EdgeInsetsGeometry? padding;

  /// Margem externa do container. Since 2.0.0
  final EdgeInsetsGeometry? margin;

  /// Alinhamento transversal da coluna. Since 2.0.0
  final CrossAxisAlignment crossAxisAlignment;

  /// Alinhamento principal da coluna. Since 2.0.0
  final MainAxisAlignment mainAxisAlignment;

  /// Ordem das regras exibidas. Se null, usa a ordem padrão. Since 2.0.0
  final List<PasswordRuleType>? ruleOrder;

  static const String _defaultSpecialRegex = r'[!@#$%^&*(),.?":{}|<>]';

  const PasswordChecklist({
    super.key,
    required this.controller,
    required this.onValidationChanged,
    this.checkEightCharacters = true,
    this.checkSpecialCharacter = true,
    this.checkNumber = true,
    this.checkUppercase = true,
    this.checkLowercase = true,
    this.checkOnlyNumbers = false,
    this.minCharacters = 8,
    this.specialCharactersRegex,
    this.validColor,
    this.invalidColor,
    this.eightCharactersMessage,
    this.specialCharacterMessage,
    this.numberMessage,
    this.uppercaseMessage,
    this.lowercaseMessage,
    this.onlyNumbersMessage,
    this.customIcon,
    this.customIconBuilder,
    this.itemSpacing = 8.0,
    this.validTextStyle,
    this.invalidTextStyle,
    this.itemBuilder,
    this.padding,
    this.margin,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.ruleOrder,
  }) : super();

  /// Ordem padrão das regras.
  static List<PasswordRuleType> get defaultRuleOrder => [
        PasswordRuleType.minCharacters,
        PasswordRuleType.specialCharacter,
        PasswordRuleType.number,
        PasswordRuleType.uppercase,
        PasswordRuleType.lowercase,
        PasswordRuleType.notOnlyNumbers,
      ];

  @override
  State<PasswordChecklist> createState() => _PasswordChecklistState();
}

class _PasswordChecklistState extends State<PasswordChecklist> {
  bool _hasMinCharacters = false;
  bool _hasSpecialCharacter = false;
  bool _hasNumber = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _isOnlyNumbers = false;

  RegExp get _specialRegex =>
      widget.specialCharactersRegex ??
      RegExp(PasswordChecklist._defaultSpecialRegex);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkPassword);
    _checkPassword();
  }

  void _checkPassword() {
    final password = widget.controller.text;

    setState(() {
      if (widget.checkEightCharacters) {
        _hasMinCharacters = password.length >= widget.minCharacters;
      }
      if (widget.checkSpecialCharacter) {
        _hasSpecialCharacter = _specialRegex.hasMatch(password);
      }
      if (widget.checkNumber) {
        _hasNumber = RegExp(r'\d').hasMatch(password);
      }
      if (widget.checkUppercase) {
        _hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      }
      if (widget.checkLowercase) {
        _hasLowercase = RegExp(r'[a-z]').hasMatch(password);
      }
      if (widget.checkOnlyNumbers) {
        _isOnlyNumbers =
            password.isNotEmpty && RegExp(r'^\d+$').hasMatch(password);
      }
    });

    final checks = <bool>[
      if (widget.checkEightCharacters) _hasMinCharacters,
      if (widget.checkSpecialCharacter) _hasSpecialCharacter,
      if (widget.checkNumber) _hasNumber,
      if (widget.checkUppercase) _hasUppercase,
      if (widget.checkLowercase) _hasLowercase,
      if (widget.checkOnlyNumbers) !_isOnlyNumbers,
    ];
    final isValid = checks.isEmpty || checks.every((c) => c);

    widget.onValidationChanged(isValid);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkPassword);
    super.dispose();
  }

  List<_RuleConfig> _getOrderedRules() {
    final rules = <_RuleConfig>[];

    void add(PasswordRuleType type, bool enabled, bool value, String message) {
      if (enabled) {
        rules.add(_RuleConfig(type: type, isValid: value, message: message));
      }
    }

    add(
      PasswordRuleType.minCharacters,
      widget.checkEightCharacters,
      _hasMinCharacters,
      widget.eightCharactersMessage ??
          PasswordChecklistMessages.minCharacters(widget.minCharacters),
    );
    add(
      PasswordRuleType.specialCharacter,
      widget.checkSpecialCharacter,
      _hasSpecialCharacter,
      widget.specialCharacterMessage ??
          PasswordChecklistMessages.specialCharacter,
    );
    add(
      PasswordRuleType.number,
      widget.checkNumber,
      _hasNumber,
      widget.numberMessage ?? PasswordChecklistMessages.number,
    );
    add(
      PasswordRuleType.uppercase,
      widget.checkUppercase,
      _hasUppercase,
      widget.uppercaseMessage ?? PasswordChecklistMessages.uppercase,
    );
    add(
      PasswordRuleType.lowercase,
      widget.checkLowercase,
      _hasLowercase,
      widget.lowercaseMessage ?? PasswordChecklistMessages.lowercase,
    );
    add(
      PasswordRuleType.notOnlyNumbers,
      widget.checkOnlyNumbers,
      !_isOnlyNumbers,
      widget.onlyNumbersMessage ?? PasswordChecklistMessages.notOnlyNumbers,
    );

    final order = widget.ruleOrder ?? PasswordChecklist.defaultRuleOrder;
    final orderMap = {for (var i = 0; i < order.length; i++) order[i]: i};
    rules.sort((a, b) {
      final ia = orderMap[a.type] ?? 999;
      final ib = orderMap[b.type] ?? 999;
      return ia.compareTo(ib);
    });

    return rules;
  }

  @override
  Widget build(BuildContext context) {
    final rules = _getOrderedRules();
    final children = <Widget>[];

    for (var i = 0; i < rules.length; i++) {
      if (i > 0) {
        children.add(SizedBox(height: widget.itemSpacing));
      }
      children.add(_buildItem(rules[i]));
    }

    Widget content = Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisAlignment: widget.mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );

    if (widget.padding != null || widget.margin != null) {
      content = Container(
        padding: widget.padding,
        margin: widget.margin,
        child: content,
      );
    }

    return content;
  }

  Widget _buildItem(_RuleConfig config) {
    final color = config.isValid
        ? (widget.validColor ?? Colors.green)
        : (widget.invalidColor ?? Colors.red);

    final item = PasswordRuleItem(
      ruleType: config.type,
      message: config.message,
      isValid: config.isValid,
      effectiveColor: color,
    );

    final customWidget = widget.itemBuilder?.call(item);
    if (customWidget != null) {
      return customWidget;
    }

    final icon = _buildIcon(config.type, config.isValid, color);
    final textStyle = _buildTextStyle(config.isValid, color);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            config.message,
            style: textStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(PasswordRuleType type, bool isValid, Color color) {
    final builder = widget.customIconBuilder;
    if (builder != null) {
      final custom = builder(type.name, isValid);
      if (custom != null) return custom;
    }

    if (widget.customIcon != null) {
      return widget.customIcon!;
    }

    return Checkbox(
      value: isValid,
      onChanged: null,
      checkColor: color,
      activeColor: color,
      fillColor: WidgetStatePropertyAll<Color>(color.withAlpha(38)),
      side: BorderSide(color: color),
    );
  }

  TextStyle _buildTextStyle(bool isValid, Color color) {
    final base = isValid
        ? (widget.validTextStyle ??
            TextStyle(color: color, fontWeight: FontWeight.bold))
        : (widget.invalidTextStyle ?? TextStyle(color: color));

    return base.color != null ? base : base.copyWith(color: color);
  }
}

class _RuleConfig {
  final PasswordRuleType type;
  final bool isValid;
  final String message;

  _RuleConfig({
    required this.type,
    required this.isValid,
    required this.message,
  });
}
