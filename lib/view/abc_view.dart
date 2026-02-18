import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'comblet_level.dart';

class AbcView extends StatefulWidget {
  const AbcView({super.key});

  @override
  _AbcViewState createState() => _AbcViewState();
}

class _AbcViewState extends State<AbcView> {
  int _currentIndex = 0;
  final FlutterTts _flutterTts = FlutterTts();

  final List<Map<String, String>> _letters = List.generate(26, (index) {
    final char = String.fromCharCode(65 + index); // A-Z
    return {'letter': char, 'image': 'assets/image/ABC/$char.png'};
  });

  @override
  void initState() {
    super.initState();
    _speakCurrentLetter();
  }

  void _speakCurrentLetter() {
    _speak(_letters[_currentIndex]['letter']!);
  }

  void _nextCharacter() {
    if (_currentIndex < _letters.length - 1) {
      setState(() => _currentIndex++);
      _speakCurrentLetter();
    } else {
      _speak("Excellent!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CombletLevel()),
      );
    }
  }

  void _previousCharacter() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _speakCurrentLetter();
    }
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final currentLetter = _letters[_currentIndex];
    return Scaffold(
      backgroundColor: const Color(0xffFFF4E1),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildHeader(),
            const SizedBox(height: 30),
            _buildLetterDisplay(currentLetter),
            const SizedBox(height: 40),
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
          "Let's Learn ABC!",
          style: TextStyle(
            fontFamily: "Summary Notes DEMO",
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          "Tap the letter or press the speaker!",
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

  Widget _buildLetterDisplay(Map<String, String> currentLetter) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _speakCurrentLetter,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.yellow.shade200,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Center(
                child: Image.asset(
                  currentLetter['image']!,
                  height: 150,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          IconButton(
            onPressed: _speakCurrentLetter,
            icon: const Icon(
              Icons.volume_up,
              color: Colors.deepOrange,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (_currentIndex > 0)
          ElevatedButton(
            onPressed: _previousCharacter,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
          onPressed: _nextCharacter,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent.shade100,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 6,
          ),
          child: Text(
            _currentIndex != _letters.length - 1 ? "Next" : "Done",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
