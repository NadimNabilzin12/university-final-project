import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'comblet_level.dart';

class VehiclesView extends StatefulWidget {
  const VehiclesView({super.key});

  @override
  _VehiclesViewState createState() => _VehiclesViewState();
}

class _VehiclesViewState extends State<VehiclesView> {
  int _currentIndex = 0;
  final FlutterTts _flutterTts = FlutterTts();

  final List<Map<String, String>> _vehicles = [
    {'vehicle': 'Airplane', 'image': 'assets/image/vehicles/airplane.png'},
    {'vehicle': 'Bicycle', 'image': 'assets/image/vehicles/bicycle.png'},
    {'vehicle': 'Bus', 'image': 'assets/image/vehicles/bus.png'},
    {'vehicle': 'Motorcycle', 'image': 'assets/image/vehicles/motorcycle.png'},
    {'vehicle': 'Scooter', 'image': 'assets/image/vehicles/scooter.png'},
    {'vehicle': 'Train', 'image': 'assets/image/vehicles/train.png'},
  ];

  void _nextVehicle() {
    if (_currentIndex < _vehicles.length - 1) {
      setState(() => _currentIndex++);
      _speakCurrentVehicle();
    } else {
      _speak("Excellent!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CombletLevel()),
      );
    }
  }

  void _previousVehicle() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _speakCurrentVehicle();
    }
  }

  void _speakCurrentVehicle() {
    _speak(_vehicles[_currentIndex]['vehicle']!);
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final currentVehicle = _vehicles[_currentIndex];
    return Scaffold(
      backgroundColor: const Color(0xffE0F7FA),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildHeader(),
            const SizedBox(height: 30),
            _buildVehicleDisplay(currentVehicle),
            _buildVehicleNameWithSound(),
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
          "Let's Learn Vehicles!",
          style: TextStyle(
            fontFamily: "Summary Notes DEMO",
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Tap the vehicle or press the speaker!",
          style: TextStyle(
            fontFamily: "Summary Notes DEMO",
            fontSize: 20,
            color: Colors.tealAccent,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleDisplay(Map<String, String> currentVehicle) {
    return GestureDetector(
      onTap: _speakCurrentVehicle,
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.orange.shade200,
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
            currentVehicle['image']!,
            height: 160,
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleNameWithSound() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _vehicles[_currentIndex]['vehicle']!,
            style: const TextStyle(
              fontFamily: "Summary Notes DEMO",
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Color(0xff00897B),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.volume_up, size: 40, color: Colors.blueAccent),
            onPressed: _speakCurrentVehicle,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _vehicles.length,
            (index) => Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index
                ? Colors.tealAccent
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
              onPressed: _previousVehicle,
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
            onPressed: _nextVehicle,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 6,
            ),
            child: Text(
              _currentIndex != _vehicles.length - 1 ? "Next" : "Done",
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
