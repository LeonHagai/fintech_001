import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/chama.dart';
import 'add_chama.dart';
import 'assets/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'chama_details.dart';

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

  final List<Map<String, String>> carouselData = [
    {
      'image': 'imgs/chama_bg.jpg',
      'description': 'Kibuye Maendeleo',
    },
    {
      'image': 'imgs/chama_bg_2.jpg',
      'description': 'Pamoja Group',
    },
    {
      'image': 'imgs/chama_bg_3.jpg',
      'description': 'Dreamers',
    },
    {
      'image': 'imgs/chama_bg_4.jpg',
      'description': 'Hapa Kazi 2',
    },
    // Add more items as needed
  ];

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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    "Popular",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            _buildTopSection(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              margin: EdgeInsets.only(top: 10),
              child: const Row(
                children: [
                  Text(
                    "Your Chamas",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
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
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 0, 0, 0)
                .withOpacity(0.5)), // Thin block border
        borderRadius: BorderRadius.circular(
            8.0), // Optional: Adjust border radius as needed
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 255, 255)
                .withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: Offset(0, 3), // Shadow offset
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.6,
      margin: EdgeInsets.fromLTRB(20, 3, 20, 0),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: carouselData.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item[
                        'image']!, // Replace 'image' with the key containing the image path in your item map
                    height: MediaQuery.of(context).size.height *
                        0.18, // Adjust height as needed
                    width: MediaQuery.of(context).size.width * 0.6,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20),
                  Text(
                    item['description']!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildJoinedChamasSection() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: FutureBuilder<List<Chama>>(
          future: getChamaByUserId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final chama = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChamaDetailsScreen(
                            chamaId: chama.id,
                            name: chama.name,
                            reg: chama.identifier,
                            chair: chama.chair,
                            contri: chama.contribution.toString(),
                            max: chama.maxNo.toString(),
                            rep: chama.rep,                            
                            treasurer: chama.treasurer, username: username,

                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            return const Center(child: CircularProgressIndicator());
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
