import 'package:flutter/material.dart';
import 'package:netflix_app/core/utils.dart';

class PressButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const PressButton({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                title.contains('save^'.capitalizeAndTrim())
                    ? Colors.orange
                    : Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ))),
        onPressed: onPressed,
        child: Text(title));
  }
}
