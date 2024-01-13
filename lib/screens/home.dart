import 'package:flutter/material.dart';
import 'account.dart';
import 'notification.dart';
import '../assets/general.dart';

class HomeScreen extends StatelessWidget {
  final List<String> serviceTitles = [
    'Account',
    'Bill Pay',
    'Scan and ...',
    'Statement',
    'Funds Transfer',
    'Savings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            // Top Section
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF003366), Color(0xFF005599)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'BrandName',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.5),
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationsScreen()),
                            );
                          },
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Total Balance: \$1,000,000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    "Services",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
            ),
            // Banner Section (Placeholder Content)
            Expanded(
              child: Container(
                padding: EdgeInsets.all(13.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: MediaQuery.of(context).size.width * 0.01,
                    mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
                  ),
                  itemCount: serviceTitles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Handle the click event for each service square
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountScreen()),
                          );
                        } else {
                          print("Baado");
                        }
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
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
                        child: Center(
                          child: Text(
                            serviceTitles[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    "Latest Transaction",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                  GestureDetector(
                    onTap: () {
                      showStatementModal(context);
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
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
            )
          ],
        ),
      ),
    );
  }
}

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