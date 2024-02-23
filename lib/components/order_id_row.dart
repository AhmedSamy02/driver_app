import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderIdRow extends StatelessWidget {
  const OrderIdRow({
    super.key,
    required this.orderId,
  });
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SvgPicture.asset('assets/images/briefcase.svg'),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              '#$orderId',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
