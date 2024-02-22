import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenButton extends StatelessWidget {
  const HomeScreenButton({
    super.key,
    required this.title,
    required this.color
  });
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              title,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.arrow_forward,
                color: color,
                size: 17,
              ),
            ),
          )
        ],
      ),
    );
  }
}
