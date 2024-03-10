import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fintech_001/screens/insurance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:fintech_001/screens/assets/constants.dart';
import 'package:fintech_001/screens/bill_pay.dart';
import 'package:fintech_001/screens/calc.dart';
import 'package:fintech_001/screens/deposit.dart';
import 'package:fintech_001/screens/login.dart';
import 'package:fintech_001/screens/profile.dart';
import 'package:flutter/material.dart';
import 'assets/trans_card.dart';
import 'account.dart';
import 'chama.dart';
import 'conn.dart';
import 'guarantors.dart';
import 'kin.dart';
import 'notification.dart';
import 'loans.dart';
import 'transact.dart';
import 'package:async/async.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAlertVisible = true;
  late String username;
  @override
  void initState() {
    super.initState();
    username = widget.username;
    Timer(const Duration(seconds: 10), () {
      setState(() {
        isAlertVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _appDrawer(context, username),
      body: Column(
        children: [
          Stack(children: [
            Visibility(
              visible: isAlertVisible,
              child: Container(
                color: Colors.amber, // Customize the color as needed
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Upcoming alerts shall be showcased here. Welcome to your aid in financial difference',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  setState(() {
                    isAlertVisible = false;
                  });
                },
              ),
            ),
          ]),
          YourBodyWidget(isAlertVisible: isAlertVisible, username: username),
        ],
      ),
    );
  }

  Widget _appDrawer(BuildContext context, String username) {
    return Drawer(
      child: Column(
        children: [
          // Top Section
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 150, 107, 91),
                  Color.fromARGB(255, 85, 54, 47)
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('imgs/avatar.png'),
                ),
                SizedBox(height: 8),
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // // Second Section - Navigation Pages
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(username: username)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Guarantors'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GuarantorsPage(username: username)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.face_2_sharp),
            title: Text('Kin'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => KinsPage(username: username)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate_outlined),
            title: Text('Calculator'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoanCalcScreen()),
              );
            },
          ),
          // Third Section - Logout
          const Spacer(), // Add space to push Logout to the bottom
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class YourBodyWidget extends StatefulWidget {
  final bool isAlertVisible;
  final String username;

  const YourBodyWidget({
    Key? key,
    required this.isAlertVisible,
    required this.username,
  }) : super(key: key);

  @override
  State<YourBodyWidget> createState() => _YourBodyWidgetState(isAlertVisible);
}

class _YourBodyWidgetState extends State<YourBodyWidget> {
  bool isHidden = true;
  bool isAlertVisible = true;
  late String username;

  _YourBodyWidgetState(this.isAlertVisible);

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  // Debounce the toggleVisibility function
  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  void initState() {
    super.initState();
    username = widget.username;
  }

  final List<String> serviceTitles = [
    'Chama',
    'Connection',
    'Insurance',
    'Loans',
    'Bill Pay',
  ];
  final List<Map<String, String>> carouselData = [
    {
      'animation': 'imgs/anim_3.json',
      'description': 'Savings Redefined, Dreams Realized',
    },
    {
      'animation': 'imgs/fin_harmony.json',
      'description': 'Financial Harmony, Community Prosperity',
    },
    {
      'animation': 'imgs/phone_hand.json',
      'description': 'Unlock Prosperity, Secure Tomorrow',
    },
    {
      'animation': 'imgs/anim_1.json',
      'description': 'Building Wealth, Building Trust',
    },
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isAlertVisible
          ? MediaQuery.of(context).size.height * 0.92
          : MediaQuery.of(context).size.height,
      child: Column(
        children: [
          // Top Section
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    Column(
                      children: [
                        Text(
                          'Hi, $username',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              isHidden
                                  ? 'Total Bal: KSH 0.0'
                                  : 'Total Bal: ***',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(width: 8.0), // Adjust spacing as needed
                            IconButton(
                              icon: Icon(
                                isHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: toggleVisibility,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
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
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.withOpacity(0.5)), // Thin block border
              borderRadius: BorderRadius.circular(
                  8.0), // Optional: Adjust border radius as needed
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(0, 3), // Shadow offset
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.25,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: carouselData.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          item['animation']!,
                          height: MediaQuery.of(context).size.height *
                              0.18, // Adjust height as needed
                          width: MediaQuery.of(context).size.width * 0.6,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 20),
                        Text(
                          item['description']!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
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
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          // Banner Section (Placeholder Content)
          Container(
            height: MediaQuery.of(context).size.height * 0.275,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChamaPage(username: username)),
                          );
                        },
                        child: CircleWidget(
                          imageUrl:
                              'https://introtech.co.ke/projects/fintech/images/1.png',
                          description: 'Widget 1',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ConnectionPage(username: username)),
                          );
                        },
                        child: CircleWidget(
                          imageUrl:
                              'https://introtech.co.ke/projects/fintech/images/2.png',
                          description: 'Widget 2',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoanScreen()),
                          );
                        },
                        child: CircleWidget(
                          imageUrl:
                              'https://introtech.co.ke/projects/fintech/images/3.png',
                          description: 'Widget 3',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayUtilitiesPage()),
                          );
                        },
                        child: CircleWidget(
                          imageUrl:
                              'https://introtech.co.ke/projects/fintech/images/nhif1.png',
                          description: 'Widget 5',
                        ),
                      ),
                    ],
                  ),
                ],
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
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
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
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.171,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
    ); // Your main content widget goes here
  }
}

class CircleWidget extends StatelessWidget {
  final String imageUrl;
  final String description;

  CircleWidget({required this.imageUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.135,
      width: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ],
      ),
    );
  }
}
