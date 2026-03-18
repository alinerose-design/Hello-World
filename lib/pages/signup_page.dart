import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalController = TextEditingController();

  String? errorMessage;

  void _signUp() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postal = postalController.text.trim();

    final appState = context.read<AppState>();

    appState.signUp(
      name: name,
      email: email,
      password: password,
      address: address,
      city: city,
      postalCode: postal,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.08;

    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                  validator: (v) =>
                  v == null || v.isEmpty ? 'Entrez votre nom' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) =>
                  v == null || !v.contains('@') ? 'Entrez un email valide' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                  validator: (v) =>
                  v == null || v.isEmpty ? 'Entrez votre mot de passe' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Adresse'),
                  validator: (v) =>
                  v == null || v.isEmpty ? 'Entrez votre adresse' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'Ville'),
                  validator: (v) =>
                  v == null || v.isEmpty ? 'Entrez votre ville' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: postalController,
                  decoration: const InputDecoration(labelText: 'Code postal'),
                  validator: (v) =>
                  v == null || v.isEmpty ? 'Entrez votre code postal' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _signUp();
                    }
                  },
                  child: const Text('S\'inscrire'),
                ),
                if (errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}