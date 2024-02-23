import 'package:driver_app/components/back_button_with_text.dart';
import 'package:driver_app/components/categories_row.dart';
import 'package:driver_app/components/from_to_row.dart';
import 'package:driver_app/components/custom_button.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:driver_app/models/order.dart';
import 'package:driver_app/services/get_orders_by_vehicle_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String _vehicleTitle = '';
  String _vehicleId = '';
  static const _pageSize = 5;
  bool _initial = true;
  final PagingController<int, Order> _pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Order> newItems = await GetOrdersByVehicleId.getOrders(
        _pageSize,
        pageKey,
        _vehicleId,
      );
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
    if (_initial) {
      _initial = false;
      var list = ModalRoute.of(context)!.settings.arguments as List<String?>;
      _vehicleTitle = list[1]!;
      _vehicleId = list[0]!;
      _pagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
    }
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
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: CategoriesRow(),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.76,
              child: RefreshIndicator(
                onRefresh: () async {
                  _pagingController.refresh();
                },
                child: PagedListView<int, Order>(
                  padding: const EdgeInsets.all(16),
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Order>(
                    itemBuilder: (context, item, index) {
                      Map<String, Color> stat = _orderStatus(item.status!);
                      var charColor = stat.values.first;
                      var btnColor = stat.values.last;
                      var char = stat.keys.first[0];
                      var text = stat.keys.last;
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            kOrderScreen,
                            arguments: item,
                          );
                        },
                        child: Card(
                          elevation: 6,
                          child: Container(
                            color: Colors.grey[100],
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.275,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(22.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: SvgPicture.asset(
                                            'assets/images/briefcase.svg'),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            '#${item.orderId!}',
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
                                  ),
                                ),
                                FromToRow(
                                  from: item.from!,
                                  svg: 'from',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: FromToRow(
                                    from: item.to!,
                                    svg: 'to',
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 22.0,
                                    bottom: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(char,
                                          style: GoogleFonts.roboto(
                                            color: charColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 6),
                                        child: SvgPicture.asset(
                                            'assets/images/distance.svg'),
                                      ),
                                      SizedBox(
                                        width: 75,
                                        child: Text('${item.distance} km',
                                            style: GoogleFonts.ptSerif(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            )),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            child: CustomButton(
                                              title: text,
                                              color: btnColor,
                                              onPressed: (){
                                                Navigator.pushNamed(
                                                  context,
                                                  kOrderScreen,
                                                  arguments: item,
                                                );
                                              
                                              },
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
                          'Error fetching orders',
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Map<String, Color> _orderStatus(String status) {
    //? Charachter and its color - String and button color
    switch (status) {
      case 'Pending':
        return {'P': Colors.grey, 'Start': Colors.blueAccent[700]!};
      case 'Completed':
        return {'C': kCompletedColor, 'Review': kCompletedColor};
      case 'Failed':
        return {'F': kFailedColor, 'Review': kFailedColor};
      default:
        return {'W': kWorkingColor, 'Details': Colors.yellow[800]!};
    }
  }
}
