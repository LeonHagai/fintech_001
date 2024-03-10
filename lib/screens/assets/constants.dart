import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Color.fromARGB(255, 86, 26, 21);
  static const Color primaryLightColor = Color.fromARGB(255, 165, 57, 57);
  static const Color primaryDarkColor = Color.fromARGB(255, 68, 9, 3);
  static const Color accentColor = Colors.blueAccent;
  static const Color borderColor = Color.fromARGB(255, 41, 13, 13);

  // Fonts
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  static void showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Widget Decoration
  static BoxDecoration defaultBoxDecoration = BoxDecoration(
    color: accentColor,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: borderColor,
      width: 2.0,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  );

  static Container buildCustomAppBar(String title, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.fromLTRB(6, 25, 4, 6),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppConstants.primaryDarkColor,
            AppConstants.primaryLightColor,
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // Add more widgets or actions here if needed
            ],
          ),
        ],
      ),
    );
  }
}
