import 'dart:developer';

import 'package:_qurinom_chat_app/features/auth/view_model/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController(text: 'swaroop.vass@gmail.com');
  final pass = TextEditingController(text: '@Tyrion99');
  String role = 'vendor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/chats');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: email,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: pass,
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
                          DropdownMenuItem(
                            value: 'vendor',
                            child: Text('Vendor'),
                          ),
                          DropdownMenuItem(
                            value: 'customer',
                            child: Text('Customer'),
                          ),
                        ],
                        onChanged:
                            (v) => setState(() => role = v ?? 'customer'),
                        decoration: const InputDecoration(labelText: 'Role'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed:
                          state is AuthLoading
                              ? null
                              : () => context.read<AuthCubit>().login(
                                email.text.trim(),
                                pass.text,
                                role,
                              ),
                      child:
                          state is AuthLoading
                              ? const CircularProgressIndicator()
                              : const Text('Sign in'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
