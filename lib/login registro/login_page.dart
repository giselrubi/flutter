import 'package:flutter/material.dart';
import 'custom_clipper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInputFields(context),
            _buildSocialLogins(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputFields(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperWidget(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple,
              Color.fromARGB(155, 20, 30, 230),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "Bienvenidos al paraíso",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 60),
              _buildTextField(
                  controller: emailController,
                  icon: Icons.person_outline,
                  hint: "Correo"),
              const SizedBox(height: 20),
              _buildTextField(
                  controller: passwordController,
                  icon: Icons.lock_outline,
                  hint: "Contraseña",
                  isPassword: true),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _login();
                },
                child: const Text("LOGIN"),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _forgotPassword,
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLogins() {
    return Column(
      children: [
        const Text(
          "Or sign in with",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: _signInWithGoogle,
                icon: Image.asset("assets/images/google.png"),
                iconSize: 40,
              ),
              IconButton(
                onPressed: _signInWithFacebook,
                icon: Image.asset("assets/images/facebook.png"),
                iconSize: 40,
              ),
              IconButton(
                onPressed: _signInWithTwitter,
                icon: Image.asset("assets/images/twitter.png"),
                iconSize: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, required IconData icon, required String hint, bool isPassword = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      obscureText: isPassword,
    );
  }

  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    // Lógica para iniciar sesión
    print("Email: $email, Password: $password");
  }

  void _forgotPassword() {
    // Lógica para recuperar contraseña
    print("Forgot password pressed");
  }

  void _signInWithGoogle() {
    // Lógica para iniciar sesión con Google
    print("Sign in with Google pressed");
  }

  void _signInWithFacebook() {
    // Lógica para iniciar sesión con Facebook
    print("Sign in with Facebook pressed");
  }

  void _signInWithTwitter() {
    // Lógica para iniciar sesión con Twitter
    print("Sign in with Twitter pressed");
  }
}
