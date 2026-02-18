import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'abc_view.dart';
import 'animal_view.dart';
import 'num_view.dart';
import 'vehicles.dart';

class LevelView extends StatelessWidget {
  final String name;

  const LevelView({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8E7),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              Positioned(
                  bottom: 50,
                  left: -30,
                  child: Image.asset("assets/image/Group 13.png", width: 150)),
              Positioned(
                  top: 150,
                  right: -20,
                  child: Image.asset("assets/image/Group 15.png", width: 120)),
              Column(
                children: [
                  const SizedBox(height: 20),
                  _buildUnitCard(),
                  const SizedBox(height: 40),
                  _buildLessonCategories(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnitCard() {
    return SizedBox(
      width: double.infinity,
      height: 230,
      child: Stack(
        children: [
          Positioned(
            top: 40,
            left: 40,
            right: 40,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xffFFD8A9),
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffFFB347),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  )
                ],
                border: Border.all(color: Colors.orange, width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Unit 1",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events, color: Colors.amber, size: 28),
                      SizedBox(width: 10),
                      Text("1/4 Completed",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/image/horse.png",
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCategories(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 25,
      runSpacing: 25,
      children: [
        _buildCategory(
          context,
          "assets/image/abc.png",
          "ABC Letter",
          Colors.pinkAccent.shade100,
          Colors.pink.shade400,
              () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const AbcView()));
            speakLetterAndWord("ABC Letter");
          },
        ),
        _buildCategory(
          context,
          "assets/image/number.png",
          "Number",
          Colors.lightBlue.shade200,
          Colors.blue.shade400,
              () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const NumberView()));
            speakLetterAndWord("Number");
          },
        ),
        _buildCategory(
          context,
          "assets/image/animal.png",
          "Animal",
          Colors.greenAccent.shade100,
          Colors.green.shade400,
              () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AnimalView()));
            speakLetterAndWord("Animal");
          },
        ),
        _buildCategory(
          context,
          "assets/image/vehicle.png",
          "Vehicles",
          Colors.orangeAccent.shade100,
          Colors.orange.shade400,
              () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const VehiclesView()));
            speakLetterAndWord("Vehicles");
          },
        ),
      ],
    );
  }

  Widget _buildCategory(BuildContext context, String iconPath, String title,
      Color startColor, Color endColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [startColor, endColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Image.asset(iconPath, height: 80),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Future<void> speakLetterAndWord(String word) async {
    final FlutterTts tts = FlutterTts();
    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.4);
    await tts.speak(word);
  }
}
