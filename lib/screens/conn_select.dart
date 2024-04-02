import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactSelectionScreen extends StatefulWidget {
  final String username;

  const ContactSelectionScreen({super.key, required this.username});
  @override
  _ContactSelectionScreenState createState() => _ContactSelectionScreenState();
}

class _ContactSelectionScreenState extends State<ContactSelectionScreen> {
  late String username;
  List<Contact> _contacts = [];
  List<Contact> _selectedContacts = []; // List to store selected contacts
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    username = widget.username;
    setState(() {
      _isLoading = true; // Set loading state to true
    });
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts.toList();
      _isLoading = false; // Set loading state to true
    });
  }

  void _handleSelection() {
    for (var contact in _selectedContacts) {
      print('Selected Contact: ${contact.displayName}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected Contact: ${contact.displayName}'),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Contacts'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              Contact contact = _contacts[index];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contact.displayName ?? ''),
                    Text(
                      "0789898989", // You can replace this with the actual phone number from the contact
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                trailing: Checkbox(
                  value: _selectedContacts
                      .contains(contact), // Check if contact is selected
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        _selectedContacts
                            .add(contact); // Add contact to selected list
                      } else {
                        _selectedContacts.remove(
                            contact); // Remove contact from selected list
                      }
                    });
                  },
                ),
              );
            },
          ),
          if (_isLoading) CircularProgressIndicator(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSelection,
        child: Icon(Icons.check),
      ),
    );
  }
}
