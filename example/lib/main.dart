import 'package:flutter/material.dart';
import 'package:password_check/password_check.dart';

void main() => runApp(const PasswordCheckerExampleApp());

class PasswordCheckerExampleApp extends StatelessWidget {
  const PasswordCheckerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Password Check Example',
      home: PasswordCheckerExampleScreen(),
    );
  }
}

class PasswordCheckerExampleScreen extends StatefulWidget {
  const PasswordCheckerExampleScreen({super.key});

  @override
  State<PasswordCheckerExampleScreen> createState() =>
      _PasswordCheckerExampleScreenState();
}

class _PasswordCheckerExampleScreenState
    extends State<PasswordCheckerExampleScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _advancedController = TextEditingController();
  bool isPasswordValid = false;
  bool _showAdvanced = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _advancedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Checker Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite sua senha',
              ),
            ),
            const SizedBox(height: 20),
            PasswordChecklist(
              controller: _passwordController,
              minCharacters: 6,
              checkOnlyNumbers: true,
              itemSpacing: 12,
              validColor: Colors.teal,
              invalidColor: Colors.orange.shade700,
              padding: const EdgeInsets.all(8),
              onValidationChanged: (isValid) {
                setState(() {
                  isPasswordValid = isValid;
                });
              },
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Mostrar customização avançada'),
              value: _showAdvanced,
              onChanged: (v) => setState(() => _showAdvanced = v),
            ),
            if (_showAdvanced) ...[
              const SizedBox(height: 16),
              _buildAdvancedExample(),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: isPasswordValid ? () {} : null,
              child: Text(
                isPasswordValid ? 'Continuar' : 'Preencha os requisitos',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Exemplo com itemBuilder e customIconBuilder',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _advancedController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Senha com layout customizado',
              ),
            ),
            const SizedBox(height: 12),
            PasswordChecklist(
              controller: _advancedController,
              minCharacters: 4,
              checkEightCharacters: true,
              checkNumber: true,
              checkUppercase: true,
              checkLowercase: true,
              checkSpecialCharacter: false,
              checkOnlyNumbers: false,
              ruleOrder: const [
                PasswordRuleType.minCharacters,
                PasswordRuleType.uppercase,
                PasswordRuleType.lowercase,
                PasswordRuleType.number,
              ],
              customIconBuilder: (ruleId, isValid) => Icon(
                isValid ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 18,
                color: isValid ? Colors.green : Colors.grey,
              ),
              validTextStyle: const TextStyle(fontWeight: FontWeight.w600),
              invalidTextStyle: TextStyle(color: Colors.grey.shade700),
              onValidationChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
