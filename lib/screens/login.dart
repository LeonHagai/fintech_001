import 'package:fintech_001/screens/forgotpswd.dart';
import 'package:flutter/material.dart';

import 'homeland.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF003366), Color(0xFF005599)],
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: _buildLoginForm(context),
        ),
      ),
    );
  }

  Widget _buildLoginForm(context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormField('Username or Email', 'Enter your username or email', TextInputType.text),
          _buildFormField('Password', 'Enter your password', TextInputType.visiblePassword),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              
            },
            child: Text('Login'),
          ),
          SizedBox(height: 8.0),
          TextButton(
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                );
            },
            child: Text('Forgot Password?'),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint, TextInputType inputType) {
    return Container(
      margin: EdgeInsets.all(9),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        keyboardType: inputType,
        obscureText: label.toLowerCase().contains('password'),
      ),
    );
  }
}