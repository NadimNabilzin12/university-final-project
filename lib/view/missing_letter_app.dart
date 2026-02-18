import 'package:flutter/material.dart';

void main() {
  runApp(const MissingLetterApp());
}

class MissingLetterApp extends StatelessWidget {
  const MissingLetterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Missing Letter Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MissingLetterScreen(),
    );
  }
}

class MissingLetterScreen extends StatefulWidget {
  const MissingLetterScreen({super.key});

  @override
  State<MissingLetterScreen> createState() => _MissingLetterScreenState();
}

class _MissingLetterScreenState extends State<MissingLetterScreen> {
  String currentWord = "APPLE";
  String displayedWord = "APPL_";
  String missingLetter = "E";


  List<String> letterOptions = ["A", "B", "C", "D", "E", "F"];

  bool isCorrect = false;
  bool showFeedback = false;

  List<List<int>> hintGrid = [
    [0, 1, 0],
    [1, 2, 1],
  ];

  void checkAnswer(String selectedLetter) {
    setState(() {
      isCorrect = selectedLetter == missingLetter;
      showFeedback = true;

      if (isCorrect) {
        displayedWord = currentWord;
      }
    });


    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showFeedback = false;
        if (isCorrect) {

          resetGame();
        }
      });
    });
  }

  void resetGame() {
    setState(() {
      currentWord = "APPLE";
      displayedWord = "APPL_";
      missingLetter = "E";
      isCorrect = false;
      showFeedback = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete the Missing Letter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Let's complete the missing letter",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            Text(
              displayedWord.split('').join('    '),
              style: const TextStyle(fontSize: 40, letterSpacing: 10),
            ),

            const SizedBox(height: 30),

            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    const TableCell(child: Center(child: Text('A'))),
                    ...hintGrid[0]
                        .map((num) => TableCell(
                            child: Center(child: Text(num.toString()))))
                        .toList(),
                  ],
                ),
                TableRow(
                  children: [
                    const TableCell(child: Center(child: Text(''))),
                    ...hintGrid[1]
                        .map((num) => TableCell(
                            child: Center(child: Text(num.toString()))))
                        .toList(),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: letterOptions
                  .map((letter) => ElevatedButton(
                        onPressed: () => checkAnswer(letter),
                        child:
                            Text(letter, style: const TextStyle(fontSize: 20)),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 20),

            if (showFeedback)
              Text(
                isCorrect ? "Correct!" : "Try again",
                style: TextStyle(
                  color: isCorrect ? Colors.green : Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: resetGame,
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
