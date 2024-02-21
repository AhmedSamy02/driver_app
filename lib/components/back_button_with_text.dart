import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackButtonWithText extends StatelessWidget {
  const BackButtonWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            Text(
              'Back',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
