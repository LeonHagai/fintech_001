

import 'package:flutter/material.dart';

void showStatementModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statement for January 2024',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              _buildDummyTransaction('Transaction AS5623ZV', 'Transfer to Saving Account', 'KSH 100.00'),
              _buildDummyTransaction('Transaction HJ7812RT', 'Bought Spare at JakomSpares', '(KSH 50.00)'),
              _buildDummyTransaction('Transaction KJ85126PO', 'Transfer to Equity Acc: xxxx-xxxx-xxxx-7812', 'KSH 75.00'),
              // Add more dummy transactions as needed
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildDummyTransaction(String title, String description, String amount) {
  return ListTile(
    title: Text(title),
    subtitle: Text(description),
    trailing: Text(amount),
  );
}