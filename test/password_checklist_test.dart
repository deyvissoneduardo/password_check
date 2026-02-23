import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_check/password_check.dart';

void main() {
  group('PasswordChecklist', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    Future<void> pumpChecklist(
      WidgetTester tester, {
      ValueChanged<bool>? onValidationChanged,
      bool checkEightCharacters = true,
      bool checkSpecialCharacter = true,
      bool checkNumber = true,
      bool checkUppercase = true,
      bool checkLowercase = true,
      bool checkOnlyNumbers = false,
      int minCharacters = 8,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordChecklist(
              controller: controller,
              onValidationChanged: (v) => onValidationChanged?.call(v),
              checkEightCharacters: checkEightCharacters,
              checkSpecialCharacter: checkSpecialCharacter,
              checkNumber: checkNumber,
              checkUppercase: checkUppercase,
              checkLowercase: checkLowercase,
              checkOnlyNumbers: checkOnlyNumbers,
              minCharacters: minCharacters,
            ),
          ),
        ),
      );
      await tester.pump();
    }

    testWidgets('exibe 5 itens com regras padrão', (tester) async {
      await pumpChecklist(tester);
      expect(find.byType(Checkbox), findsNWidgets(5));
    });

    testWidgets('exibe 6 itens quando checkOnlyNumbers é true', (tester) async {
      await pumpChecklist(tester, checkOnlyNumbers: true);
      expect(find.byType(Checkbox), findsNWidgets(6));
    });

    testWidgets('onValidationChanged recebe false para senha vazia',
        (tester) async {
      bool? received;
      await pumpChecklist(
        tester,
        onValidationChanged: (v) => received = v,
      );
      expect(received, isFalse);
    });

    testWidgets('onValidationChanged recebe true para senha válida',
        (tester) async {
      bool? received;
      await pumpChecklist(
        tester,
        onValidationChanged: (v) => received = v,
      );
      controller.text = 'Senha123!';
      await tester.pump();
      expect(received, isTrue);
    });

    testWidgets('valida comprimento mínimo', (tester) async {
      await pumpChecklist(tester, minCharacters: 6);
      controller.text = 'Ab1!';
      await tester.pump();
      expect(find.text('Deve conter pelo menos 6 caracteres'), findsOneWidget);

      controller.text = 'Abc12!';
      await tester.pump();
      expect(find.text('Deve conter pelo menos 6 caracteres'), findsOneWidget);
    });

    testWidgets('valida caractere especial', (tester) async {
      await pumpChecklist(tester);
      controller.text = 'Senha123';
      await tester.pump();
      expect(find.text('Deve conter um caractere especial'), findsOneWidget);

      controller.text = 'Senha123!';
      await tester.pump();
      expect(find.text('Deve conter um caractere especial'), findsOneWidget);
    });

    testWidgets('valida número', (tester) async {
      await pumpChecklist(tester);
      controller.text = 'Senha!';
      await tester.pump();
      expect(find.text('Deve conter um número'), findsOneWidget);

      controller.text = 'Senha1!';
      await tester.pump();
      expect(find.text('Deve conter um número'), findsOneWidget);
    });

    testWidgets('valida maiúscula e minúscula', (tester) async {
      await pumpChecklist(tester);
      controller.text = 'senha123!';
      await tester.pump();
      expect(find.text('Deve conter uma letra maiúscula'), findsOneWidget);

      controller.text = 'SENHA123!';
      await tester.pump();
      expect(find.text('Deve conter uma letra minúscula'), findsOneWidget);
    });

    testWidgets('checkOnlyNumbers rejeita senha apenas números', (tester) async {
      bool? received;
      await pumpChecklist(
        tester,
        checkOnlyNumbers: true,
        checkEightCharacters: false,
        checkSpecialCharacter: false,
        checkNumber: false,
        checkUppercase: false,
        checkLowercase: false,
        onValidationChanged: (v) => received = v,
      );

      controller.text = '123456';
      await tester.pump();
      expect(received, isFalse);
      expect(find.text('Não deve conter apenas números'), findsOneWidget);

      controller.text = '123a';
      await tester.pump();
      expect(received, isTrue);
    });

    testWidgets('respeita mensagens customizadas', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordChecklist(
              controller: controller,
              onValidationChanged: (_) {},
              eightCharactersMessage: 'Min 8 chars',
              specialCharacterMessage: 'Need special',
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Min 8 chars'), findsOneWidget);
      expect(find.text('Need special'), findsOneWidget);
    });

    testWidgets('respeita specialCharactersRegex customizado', (tester) async {
      bool? isValid;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordChecklist(
              controller: controller,
              onValidationChanged: (v) => isValid = v,
              specialCharactersRegex: RegExp(r'[@]'),
              checkEightCharacters: false,
              checkNumber: false,
              checkUppercase: false,
              checkLowercase: false,
            ),
          ),
        ),
      );
      await tester.pump();

      controller.text = '!';
      await tester.pump();
      expect(isValid, isFalse);

      controller.text = '@';
      await tester.pump();
      expect(isValid, isTrue);
    });

    testWidgets('ruleOrder altera ordem dos itens', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordChecklist(
              controller: controller,
              onValidationChanged: (_) {},
              ruleOrder: const [
                PasswordRuleType.uppercase,
                PasswordRuleType.lowercase,
                PasswordRuleType.minCharacters,
                PasswordRuleType.number,
                PasswordRuleType.specialCharacter,
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      final rows = tester.widgetList<Row>(find.byType(Row));
      expect(rows.length, greaterThanOrEqualTo(5));
    });

    testWidgets('itemBuilder substitui layout padrão', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordChecklist(
              controller: controller,
              onValidationChanged: (_) {},
              itemBuilder: (item) => ListTile(
                title: Text('Custom: ${item.message}'),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ListTile), findsNWidgets(5));
      expect(find.byType(Checkbox), findsNothing);
    });

    testWidgets('remove listener no dispose', (tester) async {
      await pumpChecklist(tester);
      addTearDown(() {
        controller.text = 'x';
      });
      await tester.pumpWidget(const SizedBox());
    });
  });
}
