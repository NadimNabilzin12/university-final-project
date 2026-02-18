import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'comblet_level.dart';

class AnimalView extends StatefulWidget {
  const AnimalView({super.key});

  @override
  _AnimalViewState createState() => _AnimalViewState();
}

class _AnimalViewState extends State<AnimalView> {
  int _currentIndex = 0;
  final FlutterTts _flutterTts = FlutterTts();

  final List<Map<String, String>> _animals = [
    {'name': 'Cat', 'image': 'assets/image/animal/cat.png'},
    {'name': 'Dog', 'image': 'assets/image/animal/dog.png'},
    {'name': 'Elephant', 'image': 'assets/image/animal/elephant.png'},
    {'name': 'Fox', 'image': 'assets/image/animal/fox.png'},
    {'name': 'Frog', 'image': 'assets/image/animal/Frog.png'},
    {'name': 'Giraffe', 'image': 'assets/image/animal/giraffa.png'},
    {'name': 'Gorilla', 'image': 'assets/image/animal/gorilla.png'},
    {'name': 'Lion', 'image': 'assets/image/animal/lion.png'},
    {'name': 'Monkey', 'image': 'assets/image/animal/monkey.png'},
    {'name': 'Mouse', 'image': 'assets/image/animal/mouse.png'},
    {'name': 'Pig', 'image': 'assets/image/animal/pig.png'},
    {'name': 'Sheep', 'image': 'assets/image/animal/sheep.png'},
    {'name': 'Snake', 'image': 'assets/image/animal/snake.png'},
    {'name': 'Turtle', 'image': 'assets/image/animal/turtle.png'},
  ];

  void _nextAnimal() {
    if (_currentIndex < _animals.length - 1) {
      setState(() => _currentIndex++);
      _speakCurrentAnimal();
    } else {
      _speak("Excellent!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CombletLevel()),
      );
    }
  }

  void _previousAnimal() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _speakCurrentAnimal();
    }
  }

  void _speakCurrentAnimal() {
    _speak(_animals[_currentIndex]['name']!);
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final currentAnimal = _animals[_currentIndex];
    return Scaffold(
      backgroundColor: const Color(0xffFFF4E1),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildHeader(),
            const SizedBox(height: 30),
            _buildAnimalDisplay(currentAnimal),
            _buildAnimalNameWithSound(),
            _buildIndicatorDots(),
            const SizedBox(height: 20),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: const [
        Text(
          "Let's Learn Animals!",
          style: TextStyle(
            fontFamily: "Summary Notes DEMO",
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Tap the animal or press the speaker!",
          style: TextStyle(
            fontFamily: "Summary Notes DEMO",
            fontSize: 20,
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimalDisplay(Map<String, String> currentAnimal) {
    return GestureDetector(
      onTap: _speakCurrentAnimal,
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.lightGreen.shade200,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            currentAnimal['image']!,
            height: 160,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimalNameWithSound() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _animals[_currentIndex]['name']!,
            style: const TextStyle(
              fontFamily: "Summary Notes DEMO",
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Color(0xff4AA378),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.volume_up, size: 40, color: Colors.blueAccent),
            onPressed: _speakCurrentAnimal,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _animals.length,
            (index) => Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index
                ? Colors.orangeAccent
                : Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentIndex > 0)
            ElevatedButton(
              onPressed: _previousAnimal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent.shade100,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
              ),
              child: const Text(
                "Previous",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ElevatedButton(
            onPressed: _nextAnimal,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 6,
            ),
            child: Text(
              _currentIndex != _animals.length - 1 ? "Next" : "Done",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
