import 'package:fintech_001/screens/assets/constants.dart';
import 'package:flutter/material.dart';

class AddChamaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _buildChamaForm(context),
      ),
    );
  }

  Widget _buildChamaForm(context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppConstants.buildCustomAppBar('Fund Transfer', context),
          _buildFormField('Chama Name', 'Enter chama name', TextInputType.text),
          _buildFormField('Max Members', 'Enter max number of members', TextInputType.number),
          _buildFormField('Contribution Amount', 'Enter monthly contribution', TextInputType.number),
          _buildFormField('Chairperson', 'Enter chairperson\'s name', TextInputType.text),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle form submission
              print('Chama Form Submitted');
            },
            child: Text('Add Chama'),
          ),
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
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        keyboardType: inputType,
      ),
    );
  }
}