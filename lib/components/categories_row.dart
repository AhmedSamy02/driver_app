import 'package:driver_app/components/category_divider.dart';
import 'package:driver_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'P - Pending',
            style: GoogleFonts.roboto(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          const CategoryDivider(),
          Text(
            'W - Work in Progress',
            style: GoogleFonts.roboto(
              color: kWorkingColor,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          const CategoryDivider(),
          Text(
            'C - Completed',
            style: GoogleFonts.roboto(
              color: kCompletedColor,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          const CategoryDivider(),
          Text(
            'F - Failed',
            style: GoogleFonts.roboto(
              color: kFailedColor,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
