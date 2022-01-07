import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class GenderButton extends StatelessWidget {
  const GenderButton({required this.colour, required this.onPress});

  final Color colour;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 15,
        height: 15,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
      ),
    );
  }
}
