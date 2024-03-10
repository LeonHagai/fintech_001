import 'package:flutter/material.dart';

import 'assets/constants.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ConnectionPage extends StatefulWidget {
  final String username;

  const ConnectionPage({super.key, required this.username});
  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  late String username;
  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  Future<void> _requestContactsPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      // Permission to access contacts is already granted
      return;
    }

    // If permission is not granted, request it
    if (status == PermissionStatus.denied) {
      status = await Permission.contacts.request();
    }

    // If permission is denied, show a dialog or message
    if (status.isDenied) {
      // Show a dialog or message to inform the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permission Required'),
            content: Text('Please grant permission to access contacts.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  openAppSettings();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<List<Map<String, String>>> _getContacts() async {
    await _requestContactsPermission();

    List<Map<String, String>> contactList = [];

    // Permission granted, proceed to access contacts
    if (await Permission.contacts.isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();

      // Iterate through contacts and extract name and number
      for (Contact contact in contacts) {
        String name = contact.displayName ?? '';
        print("Something");
        print(name);
        // String number = contact.phones.isNotEmpty ? contact.phones.first.value : '';

        // Add name and number to the contact list
        // contactList.add({'name': name, 'number': number});
      }
    }

    return contactList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Connect Friends', context),
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
                  _getContacts();
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
      child: const Text(
        'Empower your friends and family with the connection they need. 😊',
        textAlign: TextAlign.justify,
      ),
    );
  }
}
