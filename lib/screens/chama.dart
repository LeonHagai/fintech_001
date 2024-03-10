import 'package:flutter/material.dart';

import 'add_chama.dart';
import 'assets/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChamaPage extends StatefulWidget {
  final String username;

  const ChamaPage({super.key, required this.username});
  @override
  State<ChamaPage> createState() => _ChamaPageState();
}

class _ChamaPageState extends State<ChamaPage> {
  late String username;
  late Future<List<Chama>> futureChama;

  Future<List<Chama>> getChamaByUserId() async {
    const url = 'https://introtech.co.ke/projects/fintech/api/chama.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'action': 'GET_CHAMA_BY_USERID',
        'userid': username,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Chama.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chamas');
    }
  }

  @override
  void initState() {
    super.initState();
    username = widget.username;
    futureChama = getChamaByUserId();
  }

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
            MaterialPageRoute(
                builder: (context) => AddChamaPage(username: username)),
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
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: FutureBuilder<List<Chama>>(
          future: getChamaByUserId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final chama = snapshot.data![index];
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
                                "Name: ${chama.name}",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "Reg No: ${chama.identifier}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "Chair: ${chama.chair}",
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
                              Text(
                                "Contri: KSH ${chama.contribution}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "Max No: ${chama.maxNo}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "Rep: ${chama.rep}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green,
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
            return const CircularProgressIndicator();
          },
        ),
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

class Chama {
  final int id;
  final String identifier;
  final String name;
  final int userId;
  final int maxNo;
  final int contribution;
  final String chair;
  final String treasurer;
  final String rep;
  final DateTime dateCreated;

  const Chama({
    required this.id,
    required this.identifier,
    required this.name,
    required this.userId,
    required this.maxNo,
    required this.contribution,
    required this.chair,
    required this.treasurer,
    required this.rep,
    required this.dateCreated,
  });

  factory Chama.fromJson(Map<String, dynamic> json) {
    return Chama(
      id: int.parse(json['id']),
      identifier: json['identifier'],
      name: json['name'],
      userId: int.parse(json['userid']),
      maxNo: int.parse(json['max_no']),
      contribution: int.parse(json['contribution']),
      chair: json['chair'],
      treasurer: json['treasurer'],
      rep: json['rep'],
      dateCreated: DateTime.parse(json['date_created']),
    );
  }
}
