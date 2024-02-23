import 'dart:async';

import 'package:driver_app/components/application_small_appbar.dart';
import 'package:driver_app/components/custom_button.dart';
import 'package:driver_app/components/custom_icon_button.dart';
import 'package:driver_app/components/failed_richtext.dart';
import 'package:driver_app/components/order_id_row.dart';
import 'package:driver_app/components/pending_completed_richtext.dart';
import 'package:driver_app/components/status_and_distance_row.dart';
import 'package:driver_app/components/working_richtext.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/models/detail.dart';
import 'package:driver_app/models/order.dart';
import 'package:driver_app/services/get_order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  double _minHeight = 0.0;
  double _maxHeight = 0.0;
  late Order _order ;
  String? _char;
  Color? _charColor;
  @override
  void didChangeDependencies() {
    _minHeight = MediaQuery.of(context).size.height * 3 / 16;
    _maxHeight = MediaQuery.of(context).size.height * 7 / 8;
    _order = ModalRoute.of(context)!.settings.arguments as Order;
    _future =
        GetOrderDetails.getOrderDetails(_order.orderId!, _order.vehicleId!);
    Map<String, Color> stat = orderStatus(_order.status!);
    _charColor = stat.values.first;
    _char = stat.keys.first[0];
    super.didChangeDependencies();
  }

  Future<List<Detail>>? _future;
  final Detail _dummy = Detail(
    status: 'Working',
    estimatedA: '1990-01-01 00:00:00.000000',
    duration: '0 hours',
    estimatedD: '1990-01-01 00:00:00.000000',
    actualA: '1990-01-01 00:00:00.000000',
    actualD: '1990-01-01 00:00:00.000000',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: false,
        blur: 2,
        progressIndicator: SpinKitSpinningLines(
          color: Colors.blueAccent[700]!,
        ),
        child: SlidingUpPanel(
          onPanelOpened: () {
            setState(() {
              _future = GetOrderDetails.getOrderDetails(
                  _order.orderId!, _order.vehicleId!);
            });
          },
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          panelBuilder: () {
            return Column(
              children: [
                SizedBox(
                  height: _minHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: OrderIdRow(orderId: _order.orderId!),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: StatusAndDistanceRow(
                                  char: _char!,
                                  charColor: _charColor!,
                                  distance: _order.distance!.toString()),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: _whichButton(_order.status!),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _maxHeight - _minHeight,
                  child: FutureBuilder<List<Detail>>(
                    future: _future,
                    initialData: [
                      _dummy,
                      _dummy,
                    ],
                    builder: (context, snapshot) {
                      if (snapshot.hasError &&
                          snapshot.error is TimeoutException) {
                        return Center(
                          child: Text(
                            'Connection Timeout',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        );
                      } else {
                        return Skeletonizer(
                          enabled: snapshot.data![0].estimatedA ==
                              '1990-01-01 00:00:00.000000',
                          effect: ShimmerEffect(baseColor: Colors.grey[300]!),
                          child: ListView.separated(
                            padding: const EdgeInsets.only(top: 30),
                            itemBuilder: (context, index) {
                              var item = snapshot.data![index];
                              Map<String, Color> stat =
                                  orderStatus(item.status!);
                              var charColor = stat.values.first;
                              var char = stat.keys.first[0];
                              return ListTile(
                                title: Text(
                                  _order.to!,
                                  style: GoogleFonts.roboto(
                                    fontSize: 17,
                                    color: Colors.black54,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: _whichRichText(char, item),
                                leading: SizedBox(
                                  width: 60,
                                  child: Text(
                                    char,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.beVietnamPro(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 45,
                                      color: charColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(
                              thickness: 1.5,
                              indent: 20,
                              endIndent: 20,
                            ),
                            itemCount: snapshot.data!.length,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
          maxHeight: _maxHeight,
          minHeight: _minHeight,
          body: const Column(
            children: [
              Expanded(
                child: ApplicationSmallAppbar(),
              ),
              Expanded(
                flex: 7,
                child: BlurHash(
                  hash:
                      '|6PG:90uIdr|EzOHI.TeN#IzMz\$@=n=:=st2SKNbo?N80@NjR~s%t7wIxa=.tMAN5cXVRqRkSdVsNYjUOjNiS%j;wZslnOPAjf=DNXE*SLafs9sqEASRxC#8xIV{e,k7jc\$x%1R:wHr^I_RjRknm-SIms;OmV?t8M|wIw^',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _whichRichText(String status, Detail detail) {
    switch (status) {
      case 'C':
        return CompletedPendingRichText(detail: detail, completed: true);
      case 'P':
        return CompletedPendingRichText(detail: detail, completed: false);
      case 'W':
        return WorkingRichText(detail: detail);
      default:
        return FailedRichText(message: detail.message!);
    }
  }

  Widget _whichButton(String status) {
    switch (status) {
      case 'Completed':
        return CustomButton(
          title: 'Completed',
          color: Colors.greenAccent[700]!,
          onPressed: null,
          icon: null,
        );
      case 'Pending':
        return CustomButton(
          title: 'Start Order',
          color: kWorkingColor,
          onPressed: () {
            //TODO: Implement Start Order
          },
          icon: FontAwesomeIcons.car,
        );
      case 'Working':
        return Row(
          children: [
            const Expanded(
              flex: 1,
              child: CustomIconButton(
                color: kWorkingColor,
                icon: Icons.navigation_outlined,
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CustomButton(
                  title: 'Finish',
                  color: kCompletedColor,
                  onPressed: () {
                    Navigator.pushNamed(context, kQrScreen,arguments: _order);
                  },
                  icon: FontAwesomeIcons.check,
                ),
              ),
            ),
          ],
        );
      default:
        return const CustomButton(
          title: 'Failed',
          color: kFailedColor,
          onPressed: null,
          icon: null,
        );
    }
  }
}


