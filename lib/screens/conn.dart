
import 'package:flutter/material.dart';

class ConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Page'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF003366), Color(0xFF005599)],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTopSection(context),
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildTopSection(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: LoremIpsumWidget(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle invite button click
                  print('Invite Button Clicked');
                },
                child: Text('Invite'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          _buildConnectionCard('John Doe', '123-456-7890', 'Connected'),
          SizedBox(width: 16.0),
          _buildConnectionCard('Jane Smith', '987-654-3210', 'Pending'),
        ],
      ),
    );
  }

  Widget _buildConnectionCard(String name, String mobile, String status) {
    return Expanded(
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: $name'),
              Text('Mobile: $mobile'),
              Text('Status: $status'),
            ],
          ),
        ),
      ),
    );
  }
}

class LoremIpsumWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        textAlign: TextAlign.justify,
      ),
    );
  }
}