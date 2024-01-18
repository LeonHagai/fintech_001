import 'package:fintech_001/screens/assets/general.dart';
import 'package:flutter/material.dart';

import 'assets/constants.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountScreen> {
  String selectedAccount = 'Deposit Acc'; // Default selected account

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Account Info.', context),
          Center(
            child: DropdownButton<String>(
              value: selectedAccount,
              onChanged: (String? newValue) {
                setState(() {
                  selectedAccount = newValue!;
                });
              },
              items: <String>['Deposit Acc', 'Saving Acc']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),              
              style: TextStyle(
                color: Color.fromARGB(255, 34, 6, 175), // Text color
                fontSize: 16.0,
              ),
              icon: Icon(
                Icons.arrow_drop_down, // Dropdown arrow icon
                color: Color.fromARGB(255, 243, 121, 33),
              ),
              elevation: 4, // Dropdown elevation
              underline: Container(
                height: 2,
                color: Color.fromARGB(255, 0, 0, 0), // Underline color
              ),
            ),
          ),
          SizedBox(height: 20.0),
          selectedAccount == 'Deposit Acc'
              ? DepositAccountInfo()
              : SavingAccountInfo(),
        ],
      ),
    );
  }
}

class DepositAccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.blue[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deposit Account Information',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text('Account Number: XXXX-XXXX-XXXX-1234'),
              Text('Balance: KSH 10,000'),
              // Add more deposit account details as needed
            ],
          ),
        ),
        SizedBox(height: 10.0),
        OutlinedButton(
          onPressed: () {
            // Implement view statement functionality
            showStatementModal(context);
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.blue),
          ),
          child: Text('View Statement'),
        ),
      ],
    );
  }
}

class SavingAccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.green[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saving Account Information',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text('Account Number: XXXX-XXXX-XXXX-5678'),
              Text('Balance: KSH 5,000'),
              // Add more saving account details as needed
            ],
          ),
        ),
        SizedBox(height: 10.0),
        OutlinedButton(
          onPressed: () {
            // Implement view statement functionality
            showStatementModal(context);
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.green),
          ),
          child: Text('View Statement'),
        ),
      ],
    );
  }
}