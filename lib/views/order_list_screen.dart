import 'package:driver_app/components/back_button_with_text.dart';
import 'package:driver_app/components/category_divider.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String _vehicleTitle = '';
  @override
  Widget build(BuildContext context) {
    _vehicleTitle = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFF0047FF), Color(0xFF00B3EC)],
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButtonWithText(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/driver.svg',
                            width: 30,
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: SvgPicture.asset(
                              'assets/images/car.svg',
                              width: 30,
                              height: 37,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            CurrentUser().name!,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              _vehicleTitle,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: IntrinsicHeight(
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
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}


