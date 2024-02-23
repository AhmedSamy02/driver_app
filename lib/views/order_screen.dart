import 'package:driver_app/components/back_button_with_text.dart';
import 'package:driver_app/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var order = ModalRoute.of(context)!.settings.arguments as Order;
    return Scaffold(
      body: SlidingUpPanel(
        panelBuilder: () {
          return Center(
            child: Text("This is the sliding Widget"),
          );
        },
        maxHeight: MediaQuery.of(context).size.height * 7 / 8,
        minHeight: MediaQuery.of(context).size.height * 1 / 8,
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xFF0047FF), Color(0xFF00B3EC)],
                  ),
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      const BackButtonWithText(),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            'Order Details',
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 7,
              child: BlurHash(
                hash:
                    '|6PG:90uIdr|EzOHI.TeN#IzMz\$@=n=:=st2SKNbo?N80@NjR~s%t7wIxa=.tMAN5cXVRqRkSdVsNYjUOjNiS%j;wZslnOPAjf=DNXE*SLafs9sqEASRxC#8xIV{e,k7jc\$x%1R:wHr^I_RjRknm-SIms;OmV?t8M|wIw^',
              ),
            )
          ],
        ),
      ),
    );
  }
}
