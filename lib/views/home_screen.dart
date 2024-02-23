import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:driver_app/components/home_card.dart';
import 'package:driver_app/components/refresh_comp.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:driver_app/models/vehicle.dart';
import 'package:driver_app/services/get_vehicles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
      },
      builder: (context, child, controller) {
        return CheckMarkIndicator(
          controller: _pagingController,
          child: child,
        );
      },
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        blur: 2,
        progressIndicator: const SpinKitSpinningLines(
          color: Colors.black,
          size: 90.0,
        ),
        color: Colors.black12,
        child: DraggableHome(
          appBarColor: Colors.blueAccent[700],
          curvedBodyRadius: 25,
          headerExpandedHeight: 0.3,
          alwaysShowLeadingAndAction: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.confirm,
                    text: 'Do you want to logout',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                    onConfirmBtnTap: () async {
                      setState(() {
                        _loading = true;
                      });
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      CurrentUser().token = null;
                      Navigator.pop(context);
                      Future.delayed(const Duration(seconds: 2), () {
                        
                        Navigator.pushReplacementNamed(context, kLoginScreen);
                      });
                    },
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                    confirmBtnColor: Colors.blueAccent[700]!,
                  );
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
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
                    flex: 5,
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
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.045),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Vehicle>(
                itemBuilder: (context, item, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            kOrderListScreen,
                            arguments: [
                              item.id,
                              item.title,
                            ],
                          );
                        },
                        child: HomeScreenCard(
                          vehicle: item,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              kOrderListScreen,
                              arguments: [
                                item.id,
                                item.title,
                              ],
                            );
                          },
                        )),
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
                firstPageErrorIndicatorBuilder: (context) {
                  return Center(
                    child: Text(
                      'Error fetching vehicles',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                      ),
                    ),
                  );
                },
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pagingController.dispose();
    super.dispose();
  }
}
