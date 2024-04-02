import 'dart:convert';

import 'package:fintech_001/screens/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Chama.dart';
import 'home.dart';
import 'loans.dart';
import 'mpesa.dart';
import 'port.dart';

class MyHomePage extends StatefulWidget {
  final String username;

  const MyHomePage({super.key, required this.username});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String username;
  late String name;
  late String bal;

  late Future<List<Chama>> futureChama;
  @override
  void initState() {
    super.initState();
    username = widget.username;
    futureChama = getMemberByUserId();
  }

  int _currentIndex = 0;

  Future<List<Chama>> getMemberByUserId() async {
    print("Something");
    const url = 'https://introtech.co.ke/projects/fintech/api/members.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'action': 'GET_MEMBER_BY_USERID',
        'userid': username,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      print(jsonData);
      return jsonData.map((json) => Chama.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chamas');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(username: username),
      MpesaPage(),
      LoanScreen(),
      PortfolioPage()
    ];
    return Scaffold(
      body: Flexible(child: _pages[_currentIndex]),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.077,
        child: BottomNavigationBar(
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
      ),
    );
  }
}
