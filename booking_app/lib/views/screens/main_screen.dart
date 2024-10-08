import 'package:flutter/material.dart';
import 'package:booking_app/views/screens/nav_screens/account_screen.dart';
import 'package:booking_app/views/screens/nav_screens/history_screen.dart';
import 'package:booking_app/views/screens/nav_screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 1;
  final List<Widget> _pages = [HomeScreen(), HistoryScreen(), AccountScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home.png',
                width: 25,
              ),
              label: "Booking"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/cart.png',
                width: 25,
              ),
              label: "History"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/user.png',
                width: 25,
              ),
              label: "Account"),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
