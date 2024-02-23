import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailedRichText extends StatelessWidget {
  const FailedRichText({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Message:',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                color: Colors.red,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: ' $message',
                  style: GoogleFonts.roboto(
                    color: Colors.redAccent[100],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
