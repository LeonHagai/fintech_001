import 'dart:convert';

import 'package:fintech_001/screens/fund_trans.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Members.dart';
import '../models/chama.dart';
import 'package:http/http.dart' as http;

import 'conn.dart';
import 'conn_select.dart';

class ChamaDetailsScreen extends StatefulWidget {
  final String username;
  final int? chamaId;
  final String? name;
  final String? reg;
  final String? chair;
  final String? contri;
  final String? max;
  final String? rep;
  final String? treasurer;

  ChamaDetailsScreen(
      {super.key,
      required this.chamaId,
      required this.username,
      this.name,
      this.reg,
      this.chair,
      this.contri,
      this.max,
      this.rep,
      this.treasurer});

  @override
  _ChamaDetailsScreenState createState() => _ChamaDetailsScreenState();
}

class _ChamaDetailsScreenState extends State<ChamaDetailsScreen> {
  late int chamaId;
  late String? name;
  late String? reg;
  late String? chair;
  late String? contri;
  late String? max;
  late String? rep;
  late String? treasurer;
  late String username;

  late Future<List<Members>> futureMembers;
  @override
  void initState() {
    super.initState();
    username = widget.username;
    chamaId = widget.chamaId!;
    name = widget.name!;
    reg = widget.reg!;
    chair = widget.chair!;
    contri = widget.contri!;
    max = widget.max!;
    rep = widget.rep!;
    treasurer = widget.treasurer!;
    _fetchChamaMembers();
  }

  Future<List<Members>?> _fetchChamaMembers() async {
    const url = 'https://introtech.co.ke/projects/fintech/api/chama.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'action': 'GET_MEMBERS_BY_CHAMA',
        'chama_id': chamaId.toString(),
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      if (response.body == 'DoesntExist') {
      } else {
        return jsonData.map((json) => Members.fromJson(json)).toList();
      }
      return null;
    } else {
      throw Exception('Failed to load chamas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chama Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              height: MediaQuery.of(context).size.height * 0.2,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailsRow(label: 'Name :', value: name!),
                  DetailsRow(label: 'Chairman :', value: chair ?? ''),
                  DetailsRow(label: 'Representative :', value: rep!),
                  DetailsRow(label: 'Treasurer :', value: treasurer!),
                  DetailsRow(label: 'Reg No :', value: reg ?? ''),
                  DetailsRow(label: 'Contribution :', value: contri!),
                  DetailsRow(label: 'Curr Bal :', value: "KSH 0.00"),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              height: MediaQuery.of(context).size.height * 0.14,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle button 1 tap
                        },
                        icon: const Icon(Icons.auto_graph_outlined),
                        label: const Text('Disbursements'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(50, 30)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle button 3 tap
                        },
                        icon: const Icon(Icons.money_off),
                        label: const Text('Statement'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(50, 30)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FundTransferPage(
                                username: username,
                                category: 'chama',
                                name: '',
                                bal: '',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Deposit'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(50, 30)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContactSelectionScreen(username: username)),
                          );
                        },
                        icon: const Icon(Icons.accessibility_new),
                        label: const Text('Invite'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(50, 30)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Text(
              "Members",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'ariel',
                color: Color.fromARGB(255, 104, 17, 255),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.48,
                child: FutureBuilder<List<Members>?>(
                  future: _fetchChamaMembers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final member = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to memberDetailsScreen
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
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name: ${member.name}",
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          "ID No: ${member.userId ?? 'N/A'}", // Use null check operator (??) to provide a default value if userId is null
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          "Phone: ${member.contact ?? 'N/A'}", // Use null check operator (??) to provide a default value if contact is null
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Loan Lmt: KSH 0.00",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          "Address: ${member.address ?? 'N/A'}", // Use null check operator (??) to provide a default value if address is null
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        const Text(
                                          "Status: Active", // Use null check operator (?.) to avoid accessing createdAt if it's null
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return Center(child: Text('No data available'));
                    }
                    // By default, show a loading spinner.
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class DetailsRow extends StatelessWidget {
  final String label;
  final String value;

  DetailsRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }
}
