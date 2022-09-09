import 'package:flutter/material.dart';
import "app_bar.dart";
import "package:restaurant_app/constants.dart";
import "package:restaurant_app/pages/main/home/home_page.dart";
import "package:restaurant_app/pages/main/order/order_page.dart";
import "package:restaurant_app/pages/main/account/account_page.dart";
import "package:restaurant_app/pages/main/reservations/reservations_page.dart";
import "package:provider/provider.dart";

import 'app_state.dart';

class BasePage extends StatefulWidget {

  const BasePage({Key? key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  int pageIndex = 0;
  List<Widget> pageWidgets = [];
  List<BottomNavigationBarItem> pageNavigationItems = [];
  Map<String, PageData> pageDatas = {};


  final PageController _pageController = PageController();



  @override
  Widget build(BuildContext context) {
    AppState appStateProvider = Provider.of<AppState>(context);

    pageDatas = {
      "Home" :        const PageData(page: HomePage(),          navigationItem: BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home")),
      "Order" :       const PageData(page: OrderPage(),         navigationItem: BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Order")),
      "Reservation" : const PageData(page: ReservationsPage(),  navigationItem: BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Reservations")),
      "Account" :     const PageData(page: AccountPage(),       navigationItem: BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account")),
    };

    updateAvailablePages(appStateProvider.appModeActive);


    return Scaffold(
      appBar: MainAppBar(mainColor: Palette.lightOne, logoColor: Palette.darkOne),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: ((int newPageIndex) {
            setState(() {
              pageIndex = newPageIndex;
            });
          }),
          children: pageWidgets,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Palette.lightTwo),
        child: BottomNavigationBar(
          selectedItemColor: Palette.accent,
          unselectedItemColor: Palette.darkOne,
          showUnselectedLabels: true,
          unselectedIconTheme: const IconThemeData(size: 30),
          selectedIconTheme: const IconThemeData(size: 35),
          currentIndex: pageIndex,
          type: BottomNavigationBarType.fixed,
          items: pageNavigationItems,
          onTap: ((int itemIndex) {
            setState(() {
              pageIndex = itemIndex;
            });
            _pageController.animateToPage(pageIndex, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
          }),
        ),
      ),
    );
  }

  //
  void transferPageData() {
    pageNavigationItems.clear();
    pageWidgets.clear();
    pageDatas.forEach(
      (key, pageData) {
        pageNavigationItems.add(pageData.navigationItem);
        pageWidgets.add(pageData.page);
      }
    );
  }

  //Removes reservation data if in app mode.
  void updateAvailablePages(bool appModeActive) {
    if(!appModeActive){
      pageDatas.remove("Reservation");
    }
    setState(() {
      transferPageData();
    });
  }
}

class PageData {
  final Widget page;
  final BottomNavigationBarItem navigationItem;
  const PageData({required this.page, required this.navigationItem});
}
