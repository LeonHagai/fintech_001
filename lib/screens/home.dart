import 'package:fintech_001/screens/assets/constants.dart';
import 'package:fintech_001/screens/bill_pay.dart';
import 'package:fintech_001/screens/deposit.dart';
import 'package:flutter/material.dart';
import 'assets/trans_card.dart';
import 'account.dart';
import 'chama.dart';
import 'conn.dart';
import 'notification.dart';
import 'loans.dart';
import 'transact.dart';

class HomeScreen extends StatelessWidget {
  final List<String> serviceTitles = [
    'Account',
    'Connection',
    'Chama',
    'Deposit',
    'GBV',
    'Insurance',
    'Loans',
    'Bill Pay',
    'Statement',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _appDrawer(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            // Top Section
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppConstants.primaryDarkColor,
                    AppConstants.primaryLightColor
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
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
                    'Total Balance: KSH 1,000,000',
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
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConnectionPage()),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChamaPage()),
                          );
                        } else if (index == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DepositScreen()),
                          );
                        } else if (index == 6) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoanScreen()),
                          );
                        } else if (index == 7) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayUtilitiesPage()),
                          );
                        } else if (index == 8) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionScreen()),
                          );
                        } else {
                          print("Baado");
                        }
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: AppConstants
                                .borderColor, // Change this to your desired border color
                            width:
                                2.0, // Change this to your desired border width
                          ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionScreen()),
                      );
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
                    height: MediaQuery.of(context).size.height * 0.30,
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

  Widget _appDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Top Section
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('imgs/avatar.png'),
                ),
                SizedBox(height: 8),
                Text(
                  'Jane',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Second Section - Navigation Pages
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Navigate to Profile page or perform related actions
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Guarantors'),
            onTap: () {
              // Navigate to Guarantors page or perform related actions
              Navigator.pop(context); // Close the drawer
            },
          ),
          // Third Section - Logout
          Spacer(), // Add space to push Logout to the bottom
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Perform logout actions
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
