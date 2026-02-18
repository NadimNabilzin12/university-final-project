import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  String textBut;
  MyButton({super.key, required this.textBut});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Image(
          fit: BoxFit.fill,
          image: AssetImage(
            "assets/image/but.png",
          ),
        ),
        Positioned(
            child: Text(
          textBut,
          style: const TextStyle(
              fontFamily: "Summary Notes DEMO",
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ))
      ],
    );
  }
}
