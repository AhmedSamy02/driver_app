import 'package:driver_app/components/back_button_with_text.dart';
import 'package:driver_app/components/categories_row.dart';
import 'package:driver_app/components/from_to_row.dart';
import 'package:driver_app/components/custom_button.dart';
import 'package:driver_app/components/order_id_row.dart';
import 'package:driver_app/components/status_and_distance_row.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:driver_app/models/order.dart';
import 'package:driver_app/services/get_orders_by_vehicle_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  void didChangeDependencies() {
    var list = ModalRoute.of(context)!.settings.arguments as List<String?>;
    _vehicleTitle = list[1]!;
    _vehicleId = list[0]!;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                      Map<String, Color> stat = orderStatus(item.status!);
                      var charColor = stat.values.first;
                      var btnColor = stat.values.last;
                      var char = stat.keys.first[0];
                      var text = stat.keys.last;
                      return GestureDetector(
                        onTap: () {
                          var order = item;
                          order.vehicleId = _vehicleId;
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
                                  child: OrderIdRow(orderId: item.orderId!),
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
                                      StatusAndDistanceRow(
                                          char: char,
                                          charColor: charColor,
                                          distance: item.distance!.toString()),
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
                                              icon: FontAwesomeIcons.arrowRight,
                                              title: text,
                                              color: btnColor,
                                              onPressed: () {
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
}
