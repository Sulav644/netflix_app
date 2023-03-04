import 'package:flutter/material.dart';

class MovieNetFlixActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onClick;
  const MovieNetFlixActionButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(title)
        ],
      ),
    );
  }
}
