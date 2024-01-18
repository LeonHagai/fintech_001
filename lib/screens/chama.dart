import 'package:flutter/material.dart';

import 'add_chama.dart';
import 'assets/constants.dart';

class ChamaPage extends StatefulWidget {
  @override
  State<ChamaPage> createState() => _ChamaPageState();
}

class _ChamaPageState extends State<ChamaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          AppConstants.buildCustomAppBar('Chama(s)', context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildSearchField(),
            ),
            _buildTopSection(),
            _buildJoinedChamasSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddChamaPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Chama',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Handle search button click
            print('Search Button Clicked');
          },
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
    );
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

  Widget _buildJoinedChamasSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Joined Chamas',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          _buildChamaItem('ABC', 'Jan 1, 2022', '100', '5000', '20'),
          _buildChamaItem('XYZ', 'Feb 15, 2022', '150', '3000', '15'),
          // Add more joined chama items as needed
        ],
      ),
    );
  }

  Widget _buildChamaItem(String chamaName, String joinedDate,
      String monthlyContribution, String collectedToDate, String noMembers) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chamaName,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Members: $noMembers'),
                Text('Joined Date: $joinedDate'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Contribution: KSH $collectedToDate'),
                Text('Monthly: KSH $monthlyContribution'),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle "View Statement" button click
                print('View Statement Button Pressed for $chamaName');
              },
              child: Text('View Statement'),
            ),
          ],
        ),
      ),
    );
  }
}
