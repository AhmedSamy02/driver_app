import 'package:driver_app/components/home_button.dart';
import 'package:driver_app/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({
    super.key,
    required this.vehicle,
  });
  final Vehicle vehicle;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.fromLTRB(25, 15, 15, 10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset('assets/images/car.svg'),
                ),
                Center(
                  child: Text(
                    vehicle.title!,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                vehicle.address!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_gas_station_rounded,
                            color: Colors.grey,
                            size: 28,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '${vehicle.fuelLevel!}%',
                            style: GoogleFonts.roboto(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: HomeScreenButton(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
