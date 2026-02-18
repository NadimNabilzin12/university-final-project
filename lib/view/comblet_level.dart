import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CombletLevel extends StatefulWidget {
  const CombletLevel({super.key});

  @override
  _CombletLevelState createState() => _CombletLevelState();
}

class _CombletLevelState extends State<CombletLevel> {
  String name = "";

  @override
  void initState() {
    super.initState();
    _loadSavedName();
  }

  Future<void> _loadSavedName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('boy_name') ?? "Hero";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffFFF9E6), Color(0xffFFE2A0)],
          ),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),

              const Text(
                "🎉 YOU DID IT! 🎉",
                style: TextStyle(
                  fontFamily: "Summary Notes DEMO",
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFF542F),
                  shadows: [
                    Shadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              Center(
                child: SizedBox(
                  height: 400,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xffFFF5D1),
                          border: Border.all(
                              color: const Color(0xffFFC977), width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffFFC977),
                              blurRadius: 5,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              'Good job, $name!',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: "Summary Notes DEMO",
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4AA378),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'I\'m super proud of you!',
                              style: TextStyle(
                                fontFamily: "Summary Notes DEMO",
                                fontSize: 22,
                                color: Color(0xffFE8D43),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                    (index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Positioned(
                        top: -20,
                        child: Image(
                          image: AssetImage("assets/image/star.png"),
                          height: 140,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 50),

              Stack(
                alignment: Alignment.center,
                children: [
                  const Image(
                    image: AssetImage("assets/image/b.png"),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 60,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 90,
                        width: 240,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xffFF9A8B), Color(0xffFF6A88)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'BACK TO LEARNING',
                            style: TextStyle(
                              fontFamily: "Summary Notes DEMO",
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.95),
                              shadows: const [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Image.asset(
                "assets/image/confetti.png",
                height: 150,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
