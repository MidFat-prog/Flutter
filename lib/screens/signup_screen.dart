import 'package:flutter/material.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/CustomButton.dart';
import '../theme/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Create a new account to get started',
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
              const SizedBox(height: 28),

              CustomTextField(
                label: 'Full Name',
                hint: 'John Doe',
                controller: _nameController,
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 18),

              CustomTextField(
                label: 'Email',
                hint: 'you@example.com',
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18),

              CustomTextField(
                label: 'Password',
                hint: 'Create a password',
                controller: _passwordController,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 18),

              CustomTextField(
                label: 'Confirm Password',
                hint: 'Re-enter your password',
                controller: _confirmController,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 28),

              CustomButton(
                text: 'Sign Up',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}