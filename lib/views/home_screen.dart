import 'package:draggable_home/draggable_home.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:driver_app/models/user.dart';
import 'package:flutter/material.dart';
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
  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    CurrentUser().setUser(
      id: '1',
      name: 'John Doe',
      email: 'nname18@1.com',
      username: 'johndoe',
      token: 'wea.0asdada3dwda.wqe.aseaasr.asdasd',
    );
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<User> newItems =
          []; //await RemoteApi.getBeerList(pageKey, _pageSize);
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
      curvedBodyRadius: 20,
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
                flex: 7,
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
      title: Text(
        'Driver App',
        style: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.w500),
      ),
      body: [
        Container(
          height: 200,
          color: Colors.red,
        ),
        Container(
          height: 200,
          color: Colors.green,
        ),
        Container(
          height: 200,
          color: Colors.blue,
        ),
        Container(
          height: 200,
          color: Colors.black,
        ),
        Container(
          height: 200,
          color: Colors.purple,
        ),

        // PagedListView<int, User>(
        //   pagingController: _pagingController,
        //   builderDelegate: PagedChildBuilderDelegate<User>(
        //     itemBuilder: (context, item, index) {
        //       return Container();
        //     },
        //   ),
        // ),
      ],
    );
  }
}
