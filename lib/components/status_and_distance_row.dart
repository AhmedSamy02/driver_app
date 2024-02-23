import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusAndDistanceRow extends StatelessWidget {
  const StatusAndDistanceRow({
    super.key,
    required this.char,
    required this.charColor,
    required this.distance,
  });

  final String char;
  final String distance;
  final Color charColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(char,
            style: GoogleFonts.roboto(
              color: charColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 6),
          child: SvgPicture.asset('assets/images/distance.svg'),
        ),
        SizedBox(
          width: 75,
          child: Text('$distance km',
              style: GoogleFonts.ptSerif(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
                fontSize: 17,
              )),
        ),
      ],
    );
  }
}
