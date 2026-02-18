import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/but_widget.dart';
import 'login_view.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _emailController.text = prefs.getString('email') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 420,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Image(
                      height: 1000,
                      fit: BoxFit.fill,
                      image: AssetImage("assets/image/x.png")),
                ),
                Positioned(
                  top: 80,
                  child: Text(
                    "Eduguest",
                    style: TextStyle(
                        fontFamily: "Summary Notes DEMO",
                        fontSize: 80,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
                Positioned(
                  top: 330,
                  child: Text(
                    "New Password",
                    style: TextStyle(
                        fontFamily: "Summary Notes DEMO",
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffEABC00)),
                  ),
                )
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Please Enter Your New Password',
                style: TextStyle(
                  fontFamily: "Summary Notes DEMO",
                  fontSize: 30,
                  color: Color(0xffEABC00),
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffEABC00), width: 2.0),
                      ),
                      suffixIcon: Image(
                        image: AssetImage("assets/image/eye-slash.png"),
                      ),
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffEABC00), width: 2.0),
                      ),
                      suffixIcon: Image(
                        image: AssetImage("assets/image/eye-slash.png"),
                      ),
                      labelText: 'Confirm New Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: MyButton(
                        textBut: "Submit",
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
