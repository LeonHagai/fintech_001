import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/Kin.dart';
import '../services/DBHelper.dart';
import 'add_kin.dart';
import 'assets/constants.dart'; // Import your database helper class
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class KinsPage extends StatefulWidget {
  final String username;

  const KinsPage({super.key, required this.username});
  @override
  _KinsPageState createState() => _KinsPageState();
}

DatabaseHelper helper = DatabaseHelper.instance;

class _KinsPageState extends State<KinsPage> {
  late Future<List<Kin>> futureKin;
  late String username;

  @override
  void initState() {
    super.initState();
    username = widget.username;
    futureKin = fetchKin();
  }

  Future<List<Kin>> fetchKin() async {
    const url = 'https://introtech.co.ke/projects/fintech/api/kins.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'action': 'GET_BY_ID',
        'userid': username,
      },
    );
    

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Kin.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Kins', context),
          _buildBody(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddKinPage(username: username)),
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: FutureBuilder<List<Kin>>(
          future: fetchKin(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final kin = snapshot.data![index];
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kin.name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                kin.email,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                kin.address,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 8.0),
                              Text(
                                kin.relationship,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              GestureDetector(
                                onTap: () {
                                  launchUrl(Uri.parse('tel:${kin.contact}'));
                                },
                                child: Text(
                                  kin.contact,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
