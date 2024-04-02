import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'assets/constants.dart';

class PayUtilitiesPage extends StatefulWidget {
  const PayUtilitiesPage({super.key});

  @override
  State<PayUtilitiesPage> createState() => _PayUtilitiesPageState();
}

class _PayUtilitiesPageState extends State<PayUtilitiesPage> {
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;

  final List<Map<String, String>> carouselData = [
    {
      'image': 'imgs/nhif.jpg',
      'description': 'Services at you finger tips.',
    },
    {
      'image': 'imgs/nhif2.jpg',
      'description': 'Another ad or service to highlight',
    },
    {
      'image': 'imgs/nhif3.jpg',
      'description': 'Lorem ipsum gutn lors kins main',
    },
    {
      'image': 'imgs/nhifreg.png',
      'description': 'Try NHIF registration online',
    },
    // Add more items as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('NHIF Services', context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.08,
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
                          offset: const Offset(0, 3), // Shadow offset
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: CustomTextField(
                            controller: searchController,
                            labelText: 'Verify Membership',
                            keyboardType: TextInputType.number,
                            hintText: 'Enter ID No.',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: ElevatedButton(
                            onPressed: () {
                              if (searchController.text == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('ID Required!'),
                                  ),
                                );

                                setState(() {
                                  _isLoading =
                                      false; // Set loading state to true
                                });
                              } else if (searchController.text.length < 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Kindly confirm ID!'),
                                  ),
                                );
                                setState(() {
                                  _isLoading =
                                      false; // Set loading state to true
                                });
                              } else {
                                setState(() {
                                  _isLoading =
                                      !_isLoading; // Set loading state to true
                                });
                              }
                            },
                            child: const Icon(Icons.search_off_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      children: [
                        if (_isLoading)
                          Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 0, 198, 10)
                                      .withOpacity(0.5)), // Thin block border
                              borderRadius: BorderRadius.circular(
                                  8.0), // Optional: Adjust border radius as needed
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)
                                          .withOpacity(0.5), // Shadow color
                                  spreadRadius: 2, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: const Offset(0, 3), // Shadow offset
                                ),
                              ],
                            ),
                            child: const CircularProgressIndicator(),
                          ),
                        const Text(
                          "Last Check: Dec 14, 2023",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ariel',
                            color: Colors.deepPurple,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.fromLTRB(15, 3, 15, 2),
                          height: MediaQuery.of(context).size.height * 0.08,
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
                                offset: const Offset(0, 3), // Shadow offset
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status: Active",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'ariel',
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Facility: Mediheal",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'ariel',
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Scheme: Edu Afya",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'ariel',
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Dependant: Clean Slate",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'ariel',
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Trending || Alerts || Notices",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ariel',
                            color: Colors.deepPurple,
                          ),
                        ),
                        _buildTopSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.85,
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
}
