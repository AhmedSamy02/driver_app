import 'package:draggable_home/draggable_home.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:driver_app/models/vehicle.dart';
import 'package:driver_app/services/get_vehicles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _pageSize = 5;
  final PagingController<int, Vehicle> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    CurrentUser().setUser(
      id: '1',
      name: 'John Doe',
      email: 'nname18@1.com',
      username: 'johndoe',
      token:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.IvNMTuvnTZJLLNf56lzhlX_rlVPh05KNEh-N0BDob9c.eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
    );
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Vehicle> newItems =
          await GetVehicles.getVehicles(_pageSize, pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      appBarColor: Colors.blueAccent[700],
      curvedBodyRadius: 25,
      headerExpandedHeight: 0.3,
      alwaysShowLeadingAndAction: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Logout',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        )
      ],
      headerWidget: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF01B1ED), Color(0xFF014AFF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 9,
                child: SvgPicture.asset(
                  'assets/images/driver.svg',
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  CurrentUser().name!,
                  style: GoogleFonts.ptSerif(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      centerTitle: false,
      title: Text(
        'Driver App',
        style: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.w500),
      ),
      body: [
        PagedListView<int, Vehicle>(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.045),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Vehicle>(
            itemBuilder: (context, item, index) {
              return Padding(
                padding:const  EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: HomeScreenCard(vehicle: item),
              );
            },
            firstPageProgressIndicatorBuilder: (context) => Center(
              child: SpinKitSpinningLines(
                color: Colors.blueAccent[700]!,
              ),
            ),
            newPageProgressIndicatorBuilder: (context) => Center(
              child: SpinKitSpinningLines(
                color: Colors.blueAccent[700]!,
              ),
            ),
            noItemsFoundIndicatorBuilder: (context) => SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      'Waiting',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 4 / 5,
                      child: Text(
                        'Waiting to be assigned a vehicle. Please check back later.',
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_gas_station_rounded,
                            color: Colors.grey,
                            size: 26,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${vehicle.fuelLevel!}%',
                            style: GoogleFonts.roboto(
                              color: Colors.grey,
                              fontSize: 16,
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

class HomeScreenButton extends StatelessWidget {
  const HomeScreenButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blueAccent[700],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              'View',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.blueAccent[700],
                size: 17,
              ),
            ),
          )
        ],
      ),
    );
  }
}
