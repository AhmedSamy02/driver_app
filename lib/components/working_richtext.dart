import 'package:driver_app/models/detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkingRichText extends StatelessWidget {
  const WorkingRichText({
    super.key,
    required this.detail,
  });

  final Detail detail;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: '\nDuration: ',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                color: Colors.grey,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: detail.duration,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ]),
          TextSpan(
              text: '\nEstimated Deprature Time: ',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                color: Colors.grey,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: detail.estimatedD,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ]),
          TextSpan(
              text: '\nActual Deprature Time: ',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                color: Colors.grey,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: '-',
                  style: GoogleFonts.roboto(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ]),
          TextSpan(
              text: '\nEstimated Arrival Time: ',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                color: Colors.grey,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: detail.estimatedA,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ]),
          TextSpan(
              text: '\nActual Arrival Time: ',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                color: Colors.grey,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: detail.actualA,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[600],
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
