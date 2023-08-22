import 'package:flutter/material.dart';

import '../../cart/cart_history_page.dart';
import '../../cart/cart_page.dart';
import '../../model/main_model/table_model.dart';
import '../home/homepage.dart';
import 'account/account_page.dart';
import 'table_page.dart';

class HomeNav extends StatefulWidget {
  final int initial;
  const HomeNav({
    Key? key,
    required this.initial,
  }) : super(key: key);

  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  // final int initial;
  int _selectedIndex = 0;
  List pages = [
    const HomePage(),
    const TablePAge(),
    const CartHistory(),
    CartPage(
      inddex: Tableid.tablee.length,
    ),
    AccountPage(),
  ];

  // _HomeNavState();

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.table_view),
            label: "Table",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.archive),
            label: "History",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.person),
            label: "Profiles",
          ),
        ],
      ),
    );
  }
}
