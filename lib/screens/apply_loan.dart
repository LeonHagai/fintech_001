import 'package:flutter/material.dart';
import 'assets/constants.dart';

class ApplyLoanPage extends StatefulWidget {
  @override
  State<ApplyLoanPage> createState() => _ApplyLoanPageState();
}

class _ApplyLoanPageState extends State<ApplyLoanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppConstants.buildCustomAppBar('Apply Loan', context),
            _buildTopImage(),
            _buildTextArea(),
            _buildPersonalDetailsSection(),
            _buildLoanForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopImage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.155,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('imgs/elimisha.jpg'), // Replace with your image path
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildTextArea() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _buildPersonalDetailsSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Details',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('Name: John Doe'),
                    SizedBox(height: 16.0),
                    Text('Email: john.doe@example.com'),
                  ],
                ),
              ),
              SizedBox(width: 16.0), // Add some spacing between columns
              Expanded(
                child: Column(
                  children: [
                    Text('ID: 12345'),
                    SizedBox(height: 16.0),
                    Text('Phone: +254 123-456-7890'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoanForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Loan Application Form',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Reason for Loan',
              hintText: 'Enter the reason for your loan',
            ),
            maxLines: 3,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle form submission
              print('Loan Application Submitted');
            },
            child: Text('I am Interested'),
          ),
        ],
      ),
    );
  }
}
