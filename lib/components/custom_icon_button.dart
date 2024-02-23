import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.color,
    required this.icon,
  });
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: CircleBorder(side: BorderSide(color: color)),
          padding: const EdgeInsets.all(0)),
    );
  }
}
