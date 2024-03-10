import 'package:flutter/material.dart';

import 'add_chama.dart';
import 'assets/constants.dart';

class AddGuarantorPage extends StatefulWidget {
  @override
  State<AddGuarantorPage> createState() => _AddGuarantorPageState();
}

List<Map<String, dynamic>> contactsData = [
  {
    'name': 'Brian Ouma',
    'phone': '07898989',
    'imageUrl': 'imgs/avatar.png',
  },
  {
    'name': 'Edwin Guru',
    'phone': '456-789-0123',
    'imageUrl': 'imgs/avatar.png',
  },
  {
    'name': 'Michael Johnson',
    'phone': '789-012-3456',
    'imageUrl': 'imgs/avatar.png',
  },
  {
    'name': 'Michaveiale Thinking',
    'phone': '789-012-3456',
    'imageUrl': 'imgs/avatar.png',
  },
  // Add more contact data as needed
];

class _AddGuarantorPageState extends State<AddGuarantorPage> {
  List<Contact> contacts = contactsData.map((data) {
    return Contact(
      name: data['name'],
      phone: data['phone'],
      imageUrl: data['imageUrl'],
    );
  }).toList();
  List<Contact> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
  }

  void filterContacts(String query) {
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
              contact.name.toLowerCase().contains(query.toLowerCase()) ||
              contact.phone.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppConstants.buildCustomAppBar('Select Guarantor', context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildSearchField(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: filteredContacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage(filteredContacts[index].imageUrl),
                    ),
                    title: Text(filteredContacts[index].name),
                    subtitle: Text(filteredContacts[index].phone),
                    trailing: Checkbox(
                      value: filteredContacts[index].isSelected,
                      onChanged: (value) {
                        setState(() {
                          filteredContacts[index].isSelected = value!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle submit button click
                  List<Contact> selectedContacts =
                      contacts.where((contact) => contact.isSelected).toList();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('${selectedContacts.length} : contacts selected as guarantors. Processing Begun.'),
                    ),
                  );
                },
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: filterContacts,
      decoration: InputDecoration(
        hintText: 'Search Name, Phone No',
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
}

class Contact {
  final String name;
  final String phone;
  final String imageUrl;
  bool isSelected;

  Contact({
    required this.name,
    required this.phone,
    required this.imageUrl,
    this.isSelected = false,
  });
}
