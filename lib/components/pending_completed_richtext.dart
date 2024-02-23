import 'package:driver_app/models/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedPendingRichText extends StatelessWidget {
  const CompletedPendingRichText({
    super.key,
    required this.order,
    required this.completed,
  });

  final Order order;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: completed
                  ? '\nEstimated Deprature Time: '
                  : '\nEstimated Arrival Time: ',
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
              text: completed
                  ? '\nActual Deprature Time: '
                  : '\nActual Arrival Time: ',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                color: Colors.grey,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: completed ? '12:00 PM' : '-',
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
