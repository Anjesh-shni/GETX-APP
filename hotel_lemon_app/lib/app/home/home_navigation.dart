import 'package:flutter/material.dart';
import '../../features/presentation/cart_page/cart_history_page.dart';
import '../../features/presentation/cart_page/cart_page.dart';
import '../../features/presentation/home/homepage.dart';
import '../../features/presentation/account/account_page.dart';
import '../../features/presentation/reusable_widget/alert_dailouge.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({
    Key? key,
  }) : super(key: key);

  @override
  HomeNavState createState() => HomeNavState();
}

class HomeNavState extends State<HomeNav> {
  int _selectedIndex = 0;
  List pages = [
    const HomePage(),
    const CartHistory(),
    const CartPage(),
    const AccountPage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (builder) => dialogueButton(context),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green.shade100,
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profiles",
            ),
          ],
        ),
      ),
    );
  }
}
