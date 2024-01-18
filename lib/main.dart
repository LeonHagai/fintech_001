import 'package:fintech_001/screens/assets/constants.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
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

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopSection(context),
          _buildBottomSection(context),
        ],
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: PageView(
        children: [
          _buildSlide('imgs/fin_harmony.json', 'Financial Harmony, Community Prosperity',
              'Harmonize your finances for the prosperity of your community. Our SACCOS and financial solutions create a symphony of stability, growth, and shared success.', context),
          _buildSlide('imgs/phone_hand.json', 'Unlock Prosperity, Secure Tomorrow',
              'Unlock the doors to prosperity and secure your financial tomorrow. Our SACCOS and financial solutions are designed to safeguard your dreams and create a path to wealth.', context),
          _buildSlide('imgs/anim_1.json', 'Building Wealth, Building Trust',
              '"Build wealth while building trust. Our SACCOS and financial solutions prioritize transparency and integrity, ensuring a trustworthy partnership in your financial journey.', context),
          _buildSlide('imgs/anim_2.json', 'Investing in Your Tomorrow, Today',
              'Our SACCOS and financial solutions pave the way for a brighter tomorrow. Start investing in your future today with personalized financial strategies that stand the test of time.', context),
          _buildSlide('imgs/anim_3.json', 'Savings Redefined, Dreams Realized',
              'Experience the power of smart finance that strengthens communities. Our SACCOS and financial solutions foster economic growth, ensuring a resilient and prosperous society.', context),
        ],
      ),
    );
  }

  Widget _buildSlide(String lottie, String title, String text, context ) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottie,
            height: MediaQuery.of(context).size.height * 0.56,
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
