import 'package:flutter/material.dart';

const Color kPrimary = Color(0xFF6C63FF);
const Color kBackground = Color(0xFFF5F5F7);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'DMSans'),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // App icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 32),
              ),
              const SizedBox(height: 28),
              // Headline
              const Text(
                'Welcome\nback 👋',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to continue to your account',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF888899),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 32),
              // Email field
              _buildLabel('EMAIL'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _emailController,
                hint: 'hello@email.com',
                prefixIcon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              // Password field
              _buildLabel('PASSWORD'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _passwordController,
                hint: '••••••••',
                prefixIcon: Icons.lock_outline_rounded,
                obscure: _obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: const Color(0xFFB0B0C8),
                    size: 20,
                  ),
                ),
              ),
              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: kPrimary,
                    padding: const EdgeInsets.only(top: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot password?',
                    style:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Sign In button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Divider
              Row(
                children: const [
                  Expanded(child: Divider(color: Color(0xFFE0E0EC))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or continue with',
                      style: TextStyle(
                          fontSize: 12, color: Color(0xFFB0B0C8)),
                    ),
                  ),
                  Expanded(child: Divider(color: Color(0xFFE0E0EC))),
                ],
              ),
              const SizedBox(height: 20),
              // Social buttons
              Row(
                children: [
                  Expanded(
                    child: _buildSocialButton(
                      label: 'Google',
                      icon: Icons.g_mobiledata_rounded,
                      iconColor: const Color(0xFF4285F4),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSocialButton(
                      label: 'Applex',
                      icon: Icons.apple_rounded,
                      iconColor: const Color(0xFF1A1A2E),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Sign up
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                        fontSize: 13, color: Color(0xFF999AAA)),
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: const TextStyle(
                          color: kPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Color(0xFF555570),
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4E4EF), width: 1.5),
      ),
      child: Focus(
        child: Builder(builder: (context) {
          final focused = Focus.of(context).hasFocus;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: focused ? kPrimary : const Color(0xFFE4E4EF),
                width: 1.5,
              ),
              boxShadow: focused
                  ? [
                BoxShadow(
                  color: kPrimary.withOpacity(0.10),
                  blurRadius: 0,
                  spreadRadius: 3,
                )
              ]
                  : [],
            ),
            child: TextFormField(
              controller: controller,
              obscureText: obscure,
              keyboardType: keyboardType,
              style: const TextStyle(
                  fontSize: 14, color: Color(0xFF1A1A2E)),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                    fontSize: 14, color: Color(0xFFB0B0C8)),
                prefixIcon: Icon(prefixIcon,
                    color: focused ? kPrimary : const Color(0xFFB0B0C8),
                    size: 20),
                suffixIcon: suffixIcon,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14, horizontal: 4),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE4E4EF), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333355)),
            ),
          ],
        ),
      ),
    );
  }
}