import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


import 'assets/constants.dart';

class PortfolioPage extends StatelessWidget {
  // Example data, replace with your actual data
  final List<Transaction> transactions = [
    Transaction('Transaction 1', 500),
    Transaction('Transaction 2', 800),
    Transaction('Transaction 3', 300),
    Transaction('Transaction 4', 1000),
    Transaction('Transaction 5', 600),
    // Add more transactions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          AppConstants.buildCustomAppBar('Finance Portfolio', context),
            Text(
              'Top 5 Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Display the bar chart
            Container(
              height:  MediaQuery.of(context).size.height * 0.3,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  maxY: 1200,
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: _buildBarGroups(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return transactions
        .map(
          (transaction) => BarChartGroupData(
            x: transactions.indexOf(transaction),
            barRods: [
              BarChartRodData(
                toY: transaction.amount.toDouble(),
                color: Colors.blue,
              ),
            ],
          ),
        )
        .toList();
  }
}

class Transaction {
  final String name;
  final double amount;

  Transaction(this.name, this.amount);
}


  Widget _buildTopSection() {
    return Container(
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildTrendingChamaSlide('Chama 1'),
          _buildTrendingChamaSlide('Chama 2'),
          _buildTrendingChamaSlide('Chama 3'),
          // Add more trending chama slides as needed
        ],
      ),
    );
  }

  Widget _buildTrendingChamaSlide(String chamaName) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.all(8.0),
      child: Card(
        elevation: 3.0,
        child: Center(
          child: Text(
            chamaName,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }