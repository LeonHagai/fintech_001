import 'package:fintech_001/screens/chama.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'assets/constants.dart';

class AddChamaPage extends StatefulWidget {
  final String username;

  const AddChamaPage({super.key, required this.username});
  @override
  State<AddChamaPage> createState() => _AddChamaPageState();
}

class _AddChamaPageState extends State<AddChamaPage> {
  late String username;

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  TextEditingController chamaNameController = TextEditingController();
  TextEditingController maxNoController = TextEditingController();
  TextEditingController contriAmntController = TextEditingController();
  TextEditingController chairController = TextEditingController();
  TextEditingController treasurerController = TextEditingController();
  TextEditingController repController = TextEditingController();

  Future<void> addChama(context) async {
    const url = 'https://introtech.co.ke/projects/fintech/api/chama.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'action': 'REGISTER_CHAMA',
        'userid': username,
        'chama_name': chamaNameController.text,
        'max_members': maxNoController.text,
        'contri_amnt': contriAmntController.text,
        'chair': chairController.text,
        'treasurer': treasurerController.text,
        'rep': repController.text,
      },
    );
    print(response.body);
    
    if (response.statusCode == 200) {
      if (response.body == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChamaPage(
                    username: username,
                  )),
        );
      } else if (response.body == 'Exists') {
        AppConstants.showAlert(context, "Chama Already Exists.");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Chama registration unsuccessfull!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Add Chama', context),
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
          _buildFormField('Chama Name', 'Enter your chama name',
              TextInputType.text, chamaNameController),
          _buildFormField('Max No. Members', 'Enter maximum no of members.',
              TextInputType.number, maxNoController),
          _buildFormField('Contribution Amount', 'Enter amount',
              TextInputType.phone, contriAmntController),
          _buildFormField('Chairperson', 'Enter chair person name.',
              TextInputType.emailAddress, chairController),
          _buildFormField('Treasurer', 'Enter treasurer name.',
              TextInputType.visiblePassword, treasurerController),
          _buildFormField('Representative', 'Enter rep name.',
              TextInputType.visiblePassword, repController),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (chamaNameController.text.isEmpty ||
                  maxNoController.text.isEmpty ||
                  contriAmntController.text.isEmpty ||
                  chairController.text.isEmpty ||
                  treasurerController.text.isEmpty ||
                  repController.text.isEmpty) {
                // Show alert if any field is empty
                AppConstants.showAlert(context, "Please fill in all fields.");
              } else {
                addChama(context);
              }
            },
            child: Text('Add Chama'),
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
