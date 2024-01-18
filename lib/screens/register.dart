import 'package:flutter/material.dart';

import 'assets/constants.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Register', context),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: _buildRegisterForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormField('Full Name', 'Enter your full name, as in ID',
              TextInputType.text),
          _buildFormField('ID', 'Enter your ID number.', TextInputType.text),
          _buildFormField('Mobile', 'Enter your mobile number, primary no.',
              TextInputType.phone),
          _buildFormField('Email', 'Enter your email, primary email',
              TextInputType.emailAddress),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle register button click
              print('Register Button Clicked');
            },
            child: Text('Register'),
          ),
          SizedBox(height: 9,),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Already have an Account, Login...'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint, TextInputType inputType) {
    return Container(
      margin: EdgeInsets.all(8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        keyboardType: inputType,
      ),
    );
  }
}
