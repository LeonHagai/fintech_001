import 'package:flutter/material.dart';

import 'assets/constants.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String username;
  late String secondaryEmail;
  late String secondaryMobile;

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppConstants.buildCustomAppBar('Profile', context),
            _buildImageSection(),
            _buildPrimaryInfoSection(),
            _buildChangeInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60.0,
            backgroundImage:
                AssetImage('imgs/avatar.png'), // Replace with your image path
          ),
          SizedBox(height: 8.0),
          ElevatedButton.icon(
            onPressed: () {
              // Handle update image button click
              print('Update Image');
            },
            icon: Icon(Icons.photo_camera),
            label: Text('Update Image'),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryInfoSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Primary Information',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          ListTile(
            title: Text('Username'),
            subtitle: Text(username),
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text('john.doe@example.com'),
          ),
          ListTile(
            title: Text('Mobile'),
            subtitle: Text('+254 123-456-7890'),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildChangeInfoSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Change Information',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            initialValue: username,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextFormField(
            initialValue: secondaryEmail,
            decoration: InputDecoration(labelText: 'Secondary Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            initialValue: secondaryMobile,
            decoration: InputDecoration(labelText: 'Secondary Mobile'),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle update information button click
              print('Update Information');
            },
            child: Text('Update Information'),
          ),
        ],
      ),
    );
  }
}
