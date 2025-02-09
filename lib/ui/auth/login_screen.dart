import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jstock/controller/AuthController.dart';
import 'package:jstock/ui/widgets/textFieldcustom.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/icon/logo.png',
                  width: 128,
                  height: 128,
                  fit: BoxFit.cover, // Menambahkan fit jika perlu
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),

              // Username Input
              Textfieldcustom(
                controller: usernameController,
                hintText: "Username",
                icon: Icons.person,
                obscureText: false,
              ),
              const SizedBox(height: 20),

              // Password Input
              Textfieldcustom(
                controller: passwordController,
                hintText: "Password",
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 30),

              // Login Button
              Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : _buildLoginButton()),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Login Button
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          authController.login(
            usernameController.text.trim(),
            passwordController.text.trim(),
          );
        },
        child: const Text(
          'Login',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
