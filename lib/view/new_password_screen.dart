import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_view.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasSymbol = false;
  bool hasMinLength = false;
  bool passwordsMatch = true;

  bool showPassword = false;
  bool showConfirmPassword = false;

  void _checkPassword(String value) {
    setState(() {
      hasUppercase = value.contains(RegExp(r'[A-Z]'));
      hasNumber = value.contains(RegExp(r'\d'));
      hasSymbol = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      hasMinLength = value.length >= 8;

      passwordsMatch = _confirmPasswordController.text.isEmpty ||
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  void _checkConfirmPassword(String value) {
    setState(() {
      passwordsMatch = _passwordController.text == value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4A00E0), Color(0xff8E2DE2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  const Text(
                    "Eduguest",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        )
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildField(
                            controller: _passwordController,
                            label: "New Password",
                            icon: Icons.lock_reset_rounded,
                            obscureText: !showPassword,
                            onChanged: _checkPassword,
                            showToggle: () {
                              setState(() => showPassword = !showPassword);
                            },
                            validator: (value) {
                              if (value!.isEmpty) return "Please enter new password";
                              if (!hasUppercase || !hasNumber || !hasSymbol || !hasMinLength) {
                                return "Password does not meet criteria";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 15),
                          _buildPasswordCriteria(),

                          const SizedBox(height: 20),

                          _buildField(
                            controller: _confirmPasswordController,
                            label: "Confirm Password",
                            icon: Icons.lock_outline,
                            obscureText: !showConfirmPassword,
                            onChanged: _checkConfirmPassword,
                            showToggle: () {
                              setState(() => showConfirmPassword = !showConfirmPassword);
                            },
                            validator: (value) {
                              if (value!.isEmpty) return "Please confirm password";
                              if (!passwordsMatch) return "Passwords do not match";
                              return null;
                            },
                          ),

                          if (!passwordsMatch)
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                "Passwords do not match",
                                style: TextStyle(color: Colors.red, fontSize: 14),
                              ),
                            ),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff8E2DE2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                              ),
                              onPressed: _updatePassword,
                              child: const Text(
                                "Save Password",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    void Function(String)? onChanged,
    void Function()? showToggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xff8E2DE2)),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
          onPressed: showToggle,
        ),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xff8E2DE2), width: 2),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordCriteria() {
    return Column(
      children: [
        _criteriaRow("1 Uppercase letter", hasUppercase),
        _criteriaRow("1 Number", hasNumber),
        _criteriaRow("1 Symbol", hasSymbol),
        _criteriaRow("8 Characters", hasMinLength),
      ],
    );
  }

  Widget _criteriaRow(String text, bool valid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(valid ? Icons.check_circle : Icons.circle_outlined,
              size: 18, color: valid ? Colors.green : Colors.grey),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 14, color: valid ? Colors.green : Colors.grey[700])),
        ],
      ),
    );
  }

  Future<void> _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', _passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}