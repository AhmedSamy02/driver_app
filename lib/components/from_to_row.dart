import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FromToRow extends StatelessWidget {
  const FromToRow({
    super.key,
    required this.from,
    required this.svg,
  });
  final String from;
  final String svg;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 22),
            child: SvgPicture.asset('assets/images/$svg.svg'),
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              from,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
