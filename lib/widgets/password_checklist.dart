import 'package:flutter/material.dart';

class PasswordChecklist extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<bool> onValidationChanged;
  final bool checkEightCharacters;
  final bool checkSpecialCharacter;
  final bool checkNumber;
  final bool checkUppercase;
  final bool checkLowercase;
  final int minCharacters;
  final Color? validColor;
  final Color? invalidColor;
  final String? eightCharactersMessage;
  final String? specialCharacterMessage;
  final String? numberMessage;
  final String? uppercaseMessage;
  final String? lowercaseMessage;
  final Widget? customIcon;

  const PasswordChecklist({
    Key? key,
    required this.controller,
    required this.onValidationChanged,
    this.checkEightCharacters = true,
    this.checkSpecialCharacter = true,
    this.checkNumber = true,
    this.checkUppercase = true,
    this.checkLowercase = true,
    this.minCharacters = 8,
    this.validColor,
    this.invalidColor,
    this.eightCharactersMessage,
    this.specialCharacterMessage,
    this.numberMessage,
    this.uppercaseMessage,
    this.lowercaseMessage,
    this.customIcon,
  }) : super(key: key);

  @override
  PasswordChecklistState createState() => PasswordChecklistState();
}

class PasswordChecklistState extends State<PasswordChecklist> {
  bool hasEightCharacters = false;
  bool hasSpecialCharacter = false;
  bool hasNumber = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool isOnlyNumbers = false;
  bool isNumberSequence = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkPassword);
  }

  void _checkPassword() {
    final password = widget.controller.text;

    setState(() {
      if (widget.checkEightCharacters) {
        hasEightCharacters = password.length >= widget.minCharacters;
      }
      if (widget.checkSpecialCharacter) {
        hasSpecialCharacter =
            RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
      }
      if (widget.checkNumber) {
        hasNumber = RegExp(r'\d').hasMatch(password);
      }
      if (widget.checkUppercase) {
        hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      }
      if (widget.checkLowercase) {
        hasLowercase = RegExp(r'[a-z]').hasMatch(password);
      }
    });

    final isValid = [
      if (widget.checkEightCharacters) hasEightCharacters,
      if (widget.checkSpecialCharacter) hasSpecialCharacter,
      if (widget.checkNumber) hasNumber,
      if (widget.checkUppercase) hasUppercase,
      if (widget.checkLowercase) hasLowercase,
    ].every((check) => check);

    widget.onValidationChanged(isValid);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkPassword);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.checkEightCharacters)
          _buildValidationItem(
              widget.eightCharactersMessage ??
                  'Deve conter pelo menos ${widget.minCharacters} caracteres',
              hasEightCharacters),
        if (widget.checkSpecialCharacter)
          _buildValidationItem(
              widget.specialCharacterMessage ??
                  'Deve conter um caractere especial',
              hasSpecialCharacter),
        if (widget.checkNumber)
          _buildValidationItem(
              widget.numberMessage ?? 'Deve conter um número', hasNumber),
        if (widget.checkUppercase)
          _buildValidationItem(
              widget.uppercaseMessage ?? 'Deve conter uma letra maiúscula',
              hasUppercase),
        if (widget.checkLowercase)
          _buildValidationItem(
              widget.lowercaseMessage ?? 'Deve conter uma letra minúscula',
              hasLowercase),
      ],
    );
  }

  Widget _buildValidationItem(String text, bool isValid) {
    final color = isValid
        ? widget.validColor ?? Colors.green
        : widget.invalidColor ?? Colors.red;

    return Row(
      children: [
        widget.customIcon != null
            ? widget.customIcon!
            : Checkbox(
                value: isValid,
                onChanged: null,
                checkColor: color,
                activeColor: color,
                fillColor:
                    MaterialStatePropertyAll<Color>(color.withOpacity(.15)),
                side: BorderSide(color: color),
              ),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: isValid ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
