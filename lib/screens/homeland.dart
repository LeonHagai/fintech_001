import 'package:fintech_001/screens/assets/constants.dart';
import 'package:flutter/material.dart';

import 'fund_trans.dart';
import 'home.dart';
import 'loans.dart';
import 'port.dart';

class MyHomePage extends StatefulWidget {
  final String username;

  const MyHomePage({super.key, required this.username});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String username;
  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(username: username),
      FundTransferPage(),
      LoanScreen(),
      PortfolioPage()
    ];
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor:
            AppConstants.primaryLightColor, // Set the selected item color
        unselectedItemColor: Colors.grey, // Set the unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake_outlined),
            label: 'Transfer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Loans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Portfolio',
          ),
        ],
      ),
    );
  }
}
