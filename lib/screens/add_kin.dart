import 'package:fintech_001/screens/kin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'assets/constants.dart';

class AddKinPage extends StatefulWidget {
  final String username;

  const AddKinPage({super.key, required this.username});
  @override
  State<AddKinPage> createState() => _AddKinPageState();
}

class _AddKinPageState extends State<AddKinPage> {
  late String username;

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController repController = TextEditingController();

  Future<void> addKin(context) async {
    const url = 'https://introtech.co.ke/projects/fintech/api/kins.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'action': 'ADD_KIN',
        'userid': username,
        'name': nameController.text,
        'address': addressController.text,
        'contact': contactController.text,
        'email': emailController.text,
        'relationship': relationController.text,
      },
    );
    if (response.statusCode == 200) {
      if (response.body == 'success') {
        AppConstants.showAlert(context, "Kin registration Succesfull.");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KinsPage(username: username,)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kin registration unsuccessfull!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Add Kin', context),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, child: _buildRegisterForm()),
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
          _buildFormField('Name', "Enter your kin's name",
              TextInputType.text, nameController),
          _buildFormField('Address', 'Enter Address.',
              TextInputType.text, addressController),
          _buildFormField('Phone', 'Enter Contact',
              TextInputType.phone, contactController),
          _buildFormField('Email', 'Enter Email.',
              TextInputType.emailAddress, emailController),
          _buildFormField('Relation', 'Enter Relation to person.',
              TextInputType.text, relationController),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty ||
                  addressController.text.isEmpty ||
                  contactController.text.isEmpty ||
                  emailController.text.isEmpty ||
                  relationController.text.isEmpty) {
                // Show alert if any field is empty
                AppConstants.showAlert(context, "Please fill in all fields.");
              } else {
                addKin(context);
              }
            },
            child: Text('Add Kin'),
          ),
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
