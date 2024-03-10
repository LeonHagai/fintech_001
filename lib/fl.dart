import 'package:flutter/material.dart';

class AccordionScreen extends StatelessWidget {
   final List<Map<String, String>> _titles = [
    {
      'title': 'What is Financial Literacy?',
      'description': 'Financial literacy is the ability to understand and manage your finances effectively.'
    },
    {
      'title': 'Importance of Financial Literacy?',
      'description': 'Financial literacy is important because it helps individuals make informed financial decisions, manage debt, and plan for the future.'
    },
    {
      'title': 'Benefits of Financial Literacy?',
      'description': 'The benefits of financial literacy include increased financial security, reduced stress, and the ability to achieve financial goals.'
    },
    {
      'title': 'SACCO as Financial Asset?',
      'description': 'A SACCO (Savings and Credit Cooperative Organization) is a financial institution that provides savings, credit, and other financial services to its members.'
    },
    {
      'title': 'Where Fintech comes in?',
      'description': 'Fintech plays a crucial role in empowering SACCOs and Chamas to achieve their objectives more efficiently, ultimately contributing to economic growth and prosperity in communities while enhancing financial literacy. These includes, accessibility, digital payment and transaction, risk management, financial inclusion, automation and efficiency...'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Literacy'),
      ),
      body: ListView.builder(
        itemCount: _titles.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(_titles[index]['title'] ?? ''),
            children: <Widget>[
              ListTile(
                title: Text(
                  _titles[index]['description'] ?? '',
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
