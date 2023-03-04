import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onClick;
  final IconData icon;
  final String title;
  const ActionButtons({
    super.key,
    required this.onClick,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
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
