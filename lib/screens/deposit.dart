import 'package:flutter/material.dart';

class DepositScreen extends StatefulWidget {
  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
   List<DepositDetails> deposits = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit'),
        elevation: 10,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDepositSection(
            title: 'Current Deposit',
            deposits: [
              DepositDetails(
                duration: '6 months',
                endDate: 'Dec 31, 2022',
                amount: 'KSH 10,000',
                rate: '5%',
                status: 'Active',
              ),
              // Add more current deposit details as needed
            ],
          ),
          _buildDepositSection(
            title: 'Completed Deposit',
            deposits: [
              DepositDetails(
                duration: '12 months',
                endDate: 'Dec 31, 2021',
                amount: 'KSH 15,000',
                rate: '4%',
                status: 'Completed',
              ),
              // Add more completed deposit details as needed
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDepositModal(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildDepositSection(
      {required String title, required List<DepositDetails> deposits}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Column(
            children: deposits.map((deposit) {
              return _buildDepositCard(deposit);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDepositCard(DepositDetails deposit) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deposit Duration: ${deposit.duration}',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('End Date: ${deposit.endDate}'),
                Text('Amount: ${deposit.amount}'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Percentage Rate: ${deposit.rate}'),
                Text('Status: ${deposit.status}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
  void _showAddDepositModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Deposit',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              // Add your form fields for adding a new deposit here
              // For example:
              TextFormField(
                decoration: InputDecoration(labelText: 'Deposit Duration'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'End Date'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Percentage Rate'),
              ),
              SizedBox(height: 9,),
              ElevatedButton(
                onPressed: () {
                  // Handle the form submission and add the new deposit
                  setState(() {
                    deposits.add(DepositDetails(
                      duration: 'Sample Duration',
                      endDate: 'Sample End Date',
                      amount: 'Sample Amount',
                      rate: 'Sample Rate',
                      status: 'Active',
                    ));
                  });
                  Navigator.pop(context); // Close the modal
                },
                child: Text('Add Deposit'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DepositDetails {
  final String duration;
  final String endDate;
  final String amount;
  final String rate;
  final String status;

  DepositDetails({
    required this.duration,
    required this.endDate,
    required this.amount,
    required this.rate,
    required this.status,
  });
}
