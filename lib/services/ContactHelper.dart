import 'dart:js';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../screens/conn_select.dart';

class ContactHelper {
  static Future<void> requestContactsPermission(BuildContext context) async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      // Permission granted, navigate to contact selection screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ContactSelectionScreen(username: '',)),
      );
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

  static Future<List<Map<String, String>>> getContacts(context) async {
    await requestContactsPermission(context);

    List<Map<String, String>> contactList = [];

    // Permission granted, proceed to access contacts
    if (await Permission.contacts.isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();

      // Iterate through contacts and extract name and number
      for (Contact contact in contacts) {
        String name = contact.displayName ?? '';
        // String number = contact.phones.isNotEmpty ? contact.phones.first.value : '';

        // Add name and number to the contact list
        // contactList.add({'name': name, 'number': number});
      }
    }

    return contactList;
  }
}
