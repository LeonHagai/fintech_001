
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: 01/01/2022',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Description: Dummy Transaction',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Amount: \$100.00',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
