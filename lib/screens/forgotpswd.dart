import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          _buildFormField('Email', 'Enter your email',
              TextInputType.emailAddress, emailController),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: emailController.text,
                queryParameters: {
                  'subject': 'Hello from Flutter',
                  'body': 'This is a test email sent from a Flutter app.',
                },
              );
              launchUrl(emailLaunchUri);
            },
            child: Text('Reset Password: Email'),
          ),
          ElevatedButton(
            onPressed: () {
              sendEmail(context);
            },
            child: Text('Reset Password: PHP'),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint, TextInputType inputType,
      TextEditingController controller) {
    return TextFormField(
      controller: controller,
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

  Future<void> sendEmail(context) async {
    const url = 'https://introtech.co.ke/projects/fintech/api/users.php';
    print(emailController.text);
    final response = await http.post(
      Uri.parse(url),
      body: {
        'action': 'SEND_EMAIL_PSWD',
        'email': emailController.text,
      },
    );

    if (response.statusCode == 200) {
      if (response.body == 'success') {}
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password Reset Unsuccessfull!'),
        ),
      );
    }
  }
}
