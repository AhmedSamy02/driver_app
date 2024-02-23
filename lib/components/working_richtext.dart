import 'package:driver_app/models/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkingRichText extends StatelessWidget {
  const WorkingRichText({
    super.key,
    required Order order,
  }) : _order = order;

  final Order _order;

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
                  text: '50 minutes',
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
                  text: '12:00 PM',
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
                  text: '12:00 PM',
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
                  text: '12:12 PM',
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
