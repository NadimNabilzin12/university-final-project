import 'package:finalproject/view/signin_view.dart';
import 'package:flutter/material.dart';
import '../widget/but_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF5E1),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildWelcomeText(),
            const SizedBox(height: 30),
            _buildMainBanner(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: const [
        Text(
          "Hi, Little Learner!",
          style: TextStyle(
            fontFamily: "Summary Notes DEMO",
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Color(0xffFF8C94),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Eduguest",
          style: TextStyle(
            fontFamily: "Summary Notes DEMO",
            fontSize: 70,
            fontWeight: FontWeight.bold,
            color: Color(0xffFFA45C),
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Let's explore the fun world of learning!",
          style: TextStyle(
            fontFamily: "Summary Notes DEMO",
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xff6A5ACD),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMainBanner(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffFFD8B1), Color(0xffFFB6C1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _circleIcon("assets/image/student.png", Color(0xffFFD700)),
                    const SizedBox(width: 20),
                    _circleIcon("assets/image/student.png", Color(0xff87CEFA)),
                    const SizedBox(width: 20),
                    _circleIcon("assets/image/student.png", Color(0xffFF69B4)),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Where Learning is Fun!",
                  style: TextStyle(
                    fontFamily: "Summary Notes DEMO",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFFFFFF),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xffFF9A8B), Color(0xffFF6A88)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                    child: const Text(
                      "Let's Start!",
                      style: TextStyle(
                        fontFamily: "Summary Notes DEMO",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _circleIcon(String imagePath, Color bgColor) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
