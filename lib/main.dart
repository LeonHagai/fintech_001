import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/register.dart';

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
        primarySwatch: Colors.blue,
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
          _buildSlide(Icons.star, 'Slide 1', 'Lorem ipsum dolor sit amet.'),
          _buildSlide(
              Icons.favorite, 'Slide 2', 'Consectetur adipiscing elit.'),
          _buildSlide(
              Icons.send, 'Slide 3', 'Sed do eiusmod tempor incididunt.'),
          _buildSlide(
              Icons.search, 'Slide 4', 'Ut labore et dolore magna aliqua.'),
          _buildSlide(
              Icons.thumb_up, 'Slide 5', 'Quis nostrud exercitation ullamco.'),
        ],
      ),
    );
  }

  Widget _buildSlide(IconData icon, String title, String text) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60.0,
            color: Colors.blue,
          ),
          SizedBox(height: 16.0),
          Text(
            title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
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
