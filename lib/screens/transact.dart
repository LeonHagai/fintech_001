import 'package:flutter/material.dart';

import 'assets/constants.dart';
import 'assets/trans_card.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
          AppConstants.buildCustomAppBar('Transactions || Statement', context),
            _buildSectionControl(),
            _buildTransactionList(),
            Container(
              padding: EdgeInsets.all(16.0),
              child: OutlinedButton(
                onPressed: () {
                  // Add your print functionality here
                  print('Print Button Pressed');
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                ),
                child: Text(
                  'Print',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionControl() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: TextField(
              controller: startDateController,
              decoration: InputDecoration(
                labelText: 'Start Date',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              keyboardType: TextInputType.datetime,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: TextField(
              controller: endDateController,
              decoration: InputDecoration(
                labelText: 'End Date',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              keyboardType: TextInputType.datetime,
            ),
          ),
          SizedBox(width: 16.0),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform search based on start_date and end_date
              print('Search Button Pressed');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.56,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return TransactionCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
