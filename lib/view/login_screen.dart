import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(
    text: 'swaroop.vass@gmail.com',
  );
  final _passWordController = TextEditingController(text: '@Tyrion99');
  String role = 'vendor';

  @override
  void dispose() {
    _emailController.dispose();
    _passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passWordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: role,
                    items: const [
                      DropdownMenuItem(value: 'vendor', child: Text('Vendor')),
                      DropdownMenuItem(
                        value: 'customer',
                        child: Text('Customer'),
                      ),
                    ],
                    onChanged: (v) => setState(() => role = v ?? 'customer'),
                    decoration: const InputDecoration(labelText: 'Role'),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: null, child: const Text('Sign in')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
