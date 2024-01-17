
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
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
          child: _buildForgotPasswordForm(),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormField('Email', 'Enter your email', TextInputType.emailAddress),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle reset password button click
              print('Reset Password Button Clicked');
            },
            child: Text('Reset Password'),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint, TextInputType inputType) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      keyboardType: inputType,
    );
  }
}