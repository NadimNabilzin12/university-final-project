import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_view.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _agreeToTerms = false;

  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasSymbol = false;
  bool hasMinLength = false;

  bool showPassword = false;
  bool showConfirmPassword = false;

  bool passwordsMatch = true;

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
            colors: [
              Color(0xff4A00E0),
              Color(0xff8E2DE2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            children: [
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                        controller: _fatherNameController,
                        label: "Father’s Name",
                        icon: Icons.person,
                        validator: (value) =>
                        value!.isEmpty ? "Please enter father’s name" : null,
                      ),

                      const SizedBox(height: 20),

                      _buildField(
                        controller: _emailController,
                        label: "Email or Username",
                        icon: Icons.email,
                        validator: (value) {
                          if (value!.isEmpty) return "Please enter email";
                          if (!value.contains('@') || !value.contains('.com')) {
                            return "Email must contain @ and .com";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      _buildField(
                        controller: _phoneController,
                        label: "Phone (+123...)",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) return "Please enter phone number";
                          if (!value.startsWith('+')) {
                            return "Phone must start with +";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      _buildField(
                        controller: _passwordController,
                        label: "Password",
                        icon: Icons.lock,
                        obscureText: !showPassword,
                        onChanged: _checkPassword,
                        showToggle: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) return "Please enter password";
                          if (!hasUppercase ||
                              !hasNumber ||
                              !hasSymbol ||
                              !hasMinLength) {
                            return "Password does not meet criteria";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10),
                      _buildPasswordCriteria(),

                      const SizedBox(height: 20),

                      _buildField(
                        controller: _confirmPasswordController,
                        label: "Confirm Password",
                        icon: Icons.lock_outline,
                        obscureText: !showConfirmPassword,
                        onChanged: _checkConfirmPassword,
                        showToggle: () {
                          setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) return "Please confirm password";
                          if (!passwordsMatch) return "Passwords do not match";
                          return null;
                        },
                      ),

                      if (!passwordsMatch)
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Passwords do not match",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Checkbox(
                            activeColor: const Color(0xff8E2DE2),
                            value: _agreeToTerms,
                            onChanged: (value) {
                              setState(() {
                                _agreeToTerms = value!;
                              });
                            },
                          ),
                          const Expanded(
                            child: Text(
                              'I agree to Terms & Conditions',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8E2DE2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: _submitForm,
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const LoginPage()),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff8E2DE2)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
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
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? showToggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 28, color: const Color(0xff8E2DE2)),
        suffixIcon: showToggle != null
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: showToggle,
        )
            : null,
        labelText: label,
        labelStyle: const TextStyle(fontSize: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
          const BorderSide(color: Color(0xff8E2DE2), width: 3),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordCriteria() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _criteriaRow("At least 1 uppercase letter", hasUppercase),
        _criteriaRow("At least 1 number", hasNumber),
        _criteriaRow("At least 1 symbol", hasSymbol),
        _criteriaRow("Minimum 8 characters", hasMinLength),
      ],
    );
  }

  Widget _criteriaRow(String text, bool valid) {
    return Row(
      children: [
        Icon(
          valid ? Icons.check_circle : Icons.radio_button_unchecked,
          color: valid ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _fatherNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
