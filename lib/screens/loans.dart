import 'package:fintech_001/screens/apply_loan.dart';
import 'package:flutter/material.dart';

import 'assets/constants.dart';

class LoanScreen extends StatefulWidget {
  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppConstants.buildCustomAppBar('Loans', context),
          _buildSlidesSection(),
          _buildCurrentLoansSection(),
        ],
      ),
    );
  }

  Widget _buildSlidesSection() {
    return Container(
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildSlideCard(
              'Education Loan',
              'Some bank/insurance policy for loan ',
              'imgs/elimisha.jpg',
              'Apply'),
          _buildSlideCard('Bike Loan', 'Some bank/insurance policy for loan',
              'imgs/kcb.png', 'Apply'),
          _buildSlideCard('Home Loan', 'Some bank/insurance policy for loan',
              'imgs/kcb.png', 'Apply'),
          // Add more slide cards as needed
        ],
      ),
    );
  }

  Widget _buildSlideCard(
      String title, String description, String imagePath, String btn_title) {
    return Container(
      width: 300.0,
      margin: EdgeInsets.all(8.0),
      child: Card(
        elevation: 3.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              height: MediaQuery.of(context).size.height * 0.07,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(description),
                  SizedBox(height: 4),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplyLoanPage()),
                        );
                      },
                      child: Text(btn_title))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentLoansSection() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildLoanCard(
            'Home Loan',
            'KSH 200,000',
            '15 years',
            '5%',
            'KSH 1,555',
          ),
          _buildLoanCard(
            'Car Loan',
            'KSH 30,000',
            '5 years',
            '3.5%',
            'KSH 545',
          ),
          // Add more current loans as needed
        ],
      ),
    );
  }

  Widget _buildLoanCard(
      String title, String amount, String period, String rate, String emi) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Loan Amount: $amount'),
                Text('Period: $period'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Interest Rate: $rate'),
                Text('EMI: $emi'),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle "View Statement" button click
                    print('View Statement Button Pressed for $title');
                  },
                  child: Text('View Statement'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle "View Statement" button click
                    print('Settle loan for $title');
                  },
                  child: Text('Settle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
