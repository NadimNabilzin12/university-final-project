import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'comblet_level.dart';

class NumberView extends StatefulWidget {
  const NumberView({super.key});

  @override
  _NumberViewState createState() => _NumberViewState();
}

class _NumberViewState extends State<NumberView> {
  int _currentIndex = 0;
  final FlutterTts _flutterTts = FlutterTts();

  final List<Map<String, String>> _numbers = [
    {'number': '1', 'word': 'One', 'image': 'assets/image/numbers/one.png'},
    {'number': '2', 'word': 'Two', 'image': 'assets/image/numbers/tow.png'},
    {'number': '3', 'word': 'Three', 'image': 'assets/image/numbers/three.png'},
    {'number': '4', 'word': 'Four', 'image': 'assets/image/numbers/four.png'},
    {'number': '5', 'word': 'Five', 'image': 'assets/image/numbers/five.png'},
    {'number': '6', 'word': 'Six', 'image': 'assets/image/numbers/six.png'},
    {'number': '7', 'word': 'Seven', 'image': 'assets/image/numbers/seven.png'},
    {'number': '8', 'word': 'Eight', 'image': 'assets/image/numbers/eight.png'},
    {'number': '9', 'word': 'Nine', 'image': 'assets/image/numbers/nine.png'},
    {'number': '10', 'word': 'Ten', 'image': 'assets/image/numbers/ten.png'},
  ];

  void _nextNumber() {
    if (_currentIndex < _numbers.length - 1) {
      setState(() => _currentIndex++);
      _speakCurrentNumber();
    } else {
      _speak("Excellent!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CombletLevel()),
      );
    }
  }

  void _previousNumber() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _speakCurrentNumber();
    }
  }

  void _speakCurrentNumber() {
    _speak(_numbers[_currentIndex]['word']!);
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final currentNumber = _numbers[_currentIndex];
    return Scaffold(
      backgroundColor: const Color(0xffFFF4E1),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildHeader(),
            const SizedBox(height: 30),
            _buildNumberDisplay(currentNumber),
            _buildNumberWordWithSound(),
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
          "Let's Learn Numbers!",
          style: TextStyle(
            fontFamily: "Summary Notes DEMO",
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Tap the number or press the speaker!",
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

  Widget _buildNumberDisplay(Map<String, String> currentNumber) {
    return GestureDetector(
      onTap: _speakCurrentNumber,
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.yellow.shade200,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            currentNumber['image']!,
            height: 160,
          ),
        ),
      ),
    );
  }

  Widget _buildNumberWordWithSound() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _numbers[_currentIndex]['word']!,
            style: const TextStyle(
              fontFamily: "Summary Notes DEMO",
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Color(0xffF39C12),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.volume_up, size: 40, color: Colors.blueAccent),
            onPressed: _speakCurrentNumber,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _numbers.length,
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
              onPressed: _previousNumber,
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
            onPressed: _nextNumber,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 6,
            ),
            child: Text(
              _currentIndex != _numbers.length - 1 ? "Next" : "Done",
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
