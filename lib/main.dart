import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fintech_001/screens/assets/constants.dart';
import 'package:flutter/material.dart';
import 'fl.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:url_launcher/url_launcher.dart';

import 'services/DBHelper.dart';

DatabaseHelper helper = DatabaseHelper.instance;

void initializeDatabaseFactory() {
  sqflite_ffi.databaseFactory = sqflite_ffi.databaseFactoryFfi;
}

void main() {
  // Initialize the sqflite database factory
  helper.database;
  runApp(MyApp());
  checkInternetConnectivity();
}

void checkInternetConnectivity() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    print('No internet connection.');
  } else if (connectivityResult == ConnectivityResult.mobile) {
    print('Mobile data connection available.');
  } else if (connectivityResult == ConnectivityResult.wifi) {
    print('WiFi connection available.');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinTech A001',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('No Internet Connection'),
              content: Text('Please check your internet connection.'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            _buildTopSection(context),
            _buildBottomSection(context),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.06, // 20% from the top
          left: 16.0, // Adjust as needed
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccordionScreen()),
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.green, // Example background color
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    'Financial Literacy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse('https://introtech.co.ke/projects/fintech'));                  
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue, // Example background color
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    'Website',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: PageView(
        children: [
          _buildSlide(
              'imgs/fin_harmony.json',
              'Financial Harmony, Community Prosperity',
              'Harmonize your finances for the prosperity of your community. Our SACCOS and financial solutions create a symphony of stability, growth, and shared success.',
              context),
          _buildSlide(
              'imgs/phone_hand.json',
              'Unlock Prosperity, Secure Tomorrow',
              'Unlock the doors to prosperity and secure your financial tomorrow. Our SACCOS and financial solutions are designed to safeguard your dreams and create a path to wealth.',
              context),
          _buildSlide(
              'imgs/anim_1.json',
              'Building Wealth, Building Trust',
              '"Build wealth while building trust. Our SACCOS and financial solutions prioritize transparency and integrity, ensuring a trustworthy partnership in your financial journey.',
              context),
          _buildSlide(
              'imgs/anim_2.json',
              'Investing in Your Tomorrow, Today',
              'Our SACCOS and financial solutions pave the way for a brighter tomorrow. Start investing in your future today with personalized financial strategies that stand the test of time.',
              context),
          _buildSlide(
              'imgs/anim_3.json',
              'Savings Redefined, Dreams Realized',
              'Experience the power of smart finance that strengthens communities. Our SACCOS and financial solutions foster economic growth, ensuring a resilient and prosperous society.',
              context),
        ],
      ),
    );
  }

  Widget _buildSlide(String lottie, String title, String text, context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottie,
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.height * 0.7,
            repeat: true,
            reverse: false,
            animate: true,
          ),
          const SizedBox(height: 5.0),
          Text(
            title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Login'),
          ),
          SizedBox(height: 16.0),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
