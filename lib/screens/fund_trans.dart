import 'package:fintech_001/screens/assets/constants.dart';
import 'package:flutter/material.dart';

class FundTransferPage extends StatefulWidget {
  @override
  _FundTransferPageState createState() => _FundTransferPageState();
}

class _FundTransferPageState extends State<FundTransferPage> {
  String selectedTransactionType = ''; // 'group' or 'individual'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Fund Transfer', context),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.015,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.13,
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name: Otieno Oyoo',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'ID: 123456',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Bal: KSH: 1000.00',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          _buildTopSection(),
          if (selectedTransactionType == 'group')
            _buildGroupTransferForm()
          else if (selectedTransactionType == 'individual')
            _buildIndividualTransferForm(),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
            onPressed: () {
              setState(() {
                selectedTransactionType = 'group';
              });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.blue),
            ),
            child: Text(
              'Group',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                selectedTransactionType = 'individual';
              });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.green),
            ),
            child: Text(
              'Individual',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupTransferForm() {
    // Customize this section for the group transfer form
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Group Transfer Form',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          // Add your group transfer form fields here
          // For example:
          TextField(
            decoration: InputDecoration(labelText: 'Group Name'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: () {
              // Handle group transfer submission
              print('Group Transfer Submitted');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualTransferForm() {
    // Customize this section for the individual transfer form
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Individual Transfer Form',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          // Add your individual transfer form fields here
          // For example:
          TextField(
            decoration: InputDecoration(labelText: 'Recipient Name'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: () {
              // Handle individual transfer submission
              print('Individual Transfer Submitted');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
