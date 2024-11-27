import 'package:flutter/material.dart';
import 'package:password_check/password_check.dart';

void main() => runApp(const PasswordCheckerExampleApp());

class PasswordCheckerExampleApp extends StatelessWidget {
  const PasswordCheckerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PasswordCheckerExampleScreen(),
    );
  }
}

class PasswordCheckerExampleScreen extends StatefulWidget {
  const PasswordCheckerExampleScreen({super.key});

  @override
  PasswordCheckerExampleScreenState createState() =>
      PasswordCheckerExampleScreenState();
}

class PasswordCheckerExampleScreenState
    extends State<PasswordCheckerExampleScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Checker Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              onValidationChanged: (isValid) {
                setState(() {
                  isPasswordValid = isValid;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
