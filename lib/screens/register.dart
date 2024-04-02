import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'assets/constants.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();
  TextEditingController cnfm_pswdController = TextEditingController();
  bool _isLoading = false;

  Future<void> registerUser(context) async {
    const url = 'https://introtech.co.ke/projects/fintech/api/users.php';
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    final response = await http.post(
      Uri.parse(url),
      body: {
        'action': 'ADD_USER',
        'name': nameController.text,
        'idnum': idController.text,
        'phone': mobileController.text,
        'pswd': pswdController.text,
      },
    );

    if (response.statusCode == 200) {
      if (response.body == 'success') {
        AppConstants.showAlert(context, "Registration Succesfull.");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        setState(() {
          _isLoading = false; // Set loading state to true
        });
      } else if (response.body == 'duplicate') {
        AppConstants.showAlert(context, "User Already Exists.");
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
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Register', context),
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: _buildRegisterForm()),
                ),
              ),
              if (_isLoading) CircularProgressIndicator(),
            ],
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
              TextInputType.text, nameController),
          _buildFormField('ID', 'Enter your ID number.', TextInputType.number,
              idController),
          _buildFormField('Mobile', 'Enter your mobile number, primary no.',
              TextInputType.phone, mobileController),
          _buildFormField('Email', 'Enter your email, primary email',
              TextInputType.emailAddress, emailController),
          _buildFormField('Password', 'Enter your email, primary email',
              TextInputType.visiblePassword, pswdController),
          _buildFormField('Confirm Password', 'Enter your email, primary email',
              TextInputType.visiblePassword, cnfm_pswdController),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty ||
                  idController.text.isEmpty ||
                  mobileController.text.isEmpty ||
                  emailController.text.isEmpty ||
                  pswdController.text.isEmpty ||
                  cnfm_pswdController.text.isEmpty) {
                // Show alert if any field is empty
                AppConstants.showAlert(context, "Please fill in all fields.");
              } else if (pswdController.text != cnfm_pswdController.text) {
                AppConstants.showAlert(context, "Passwords do not match.");
              } else {
                registerUser(context);
              }
            },
            child: Text('Register'),
          ),
          SizedBox(
            height: 9,
          ),
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

  Widget _buildFormField(String label, String hint, TextInputType inputType,
      TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(8),
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
        validator: (value) {
          if (value!.isEmpty) {
            return 'This field is required.';
          }
          return null;
        },
      ),
    );
  }
}
