import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fintech_001/screens/forgotpswd.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'homeland.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController pswdController = TextEditingController();
  bool _isLoading = false;

  String generateRandomToken() {
    const String validChars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final Random random = Random();
    String token = '';

    for (int i = 0; i < 10; i++) {
      int randomIndex = random.nextInt(validChars.length);
      token += validChars[randomIndex];
    }

    return token;
  }

  Future<void> loginUser(context) async {
    const url = 'https://introtech.co.ke/projects/fintech/api/users.php';

    // Dismiss keyboard when tapping outside text field
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    final response = await http.post(
      Uri.parse(url),
      body: {
        'action': 'LOGIN_MOBILE_USER',
        'idnum': nameController.text,
        'pswd': pswdController.text,
      },
    );

    if (response.statusCode == 200) {
      if (response.body == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(username: nameController.text)),
        );
      } else if (response.body == 'error') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error Login!'),
          ),
        );
        setState(() {
          _isLoading = false; // Set loading state to true
        });
      } else if (response.body == 'pswd_err') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Credentials!'),
          ),
        );
        setState(() {
          _isLoading = false; // Set loading state to true
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something Went Wrong!'),
          ),
        );
        setState(() {
          _isLoading = false; // Set loading state to true
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User registration unsuccessfull!'),
        ),
      );
      setState(() {
        _isLoading = false; // Set loading state to true
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFormField('ID No.', 'Enter your username or email',
                  TextInputType.number, nameController),
              _buildFormField('Password', 'Enter your password',
                  TextInputType.visiblePassword, pswdController),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  loginUser(context);
                },
                child: const Text('Login'),
              ),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  );
                },
                child: const Text('Forgot Password?'),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Your password is personal. Fintech won't contact you for it.",
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 3,
                pause: Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ],
          ),
          if (_isLoading) const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint, TextInputType inputType,
      TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(9),
      child: TextFormField(
        controller: controller,
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
        obscureText: label.toLowerCase().contains('password'),
      ),
    );
  }
}
