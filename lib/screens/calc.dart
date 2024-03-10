import 'package:fintech_001/screens/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LoanCalcScreen extends StatefulWidget {
  @override
  _LoanCalcScreenState createState() => _LoanCalcScreenState();
}

class _LoanCalcScreenState extends State<LoanCalcScreen> {
  int selectedLoanType = 1; // Default selected loan type

  late Widget loanForm;
  @override
  Widget build(BuildContext context) {
    // Conditionally select the loan form based on the chosen loan type
    switch (selectedLoanType) {
      case 1:
        loanForm = PersonalLoanForm();
        break;
      case 2:
        loanForm = BusinessLoanForm();
        break;
      case 3:
        loanForm = HomeLoanForm();
        break;
      case 4:
        loanForm = EducationLoanForm();
        break;
      default:
        // Show a placeholder widget if the loan type is invalid
        loanForm = Container(
          alignment: Alignment.center,
          child: Text('Invalid Loan Type'),
        );
    }

    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Calculator', context),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LoanTypeButton(
                title: "Basic",
                isSelected: selectedLoanType == 1,
                onPressed: () {
                  setState(() {
                    selectedLoanType = 1;
                  });
                  print(selectedLoanType);
                },
                loanType: 1,
              ),
              LoanTypeButton(
                title: 'Business',
                isSelected: selectedLoanType == 2,
                onPressed: () {
                  setState(() {
                    selectedLoanType = 2;
                  });
                  print(selectedLoanType);
                },
                loanType: 2,
              ),
              LoanTypeButton(
                title: 'House',
                isSelected: selectedLoanType == 3,
                onPressed: () {
                  setState(() {
                    selectedLoanType = 3;
                  });
                  print(selectedLoanType);
                },
                loanType: 3,
              ),
              LoanTypeButton(
                title: "Education",
                isSelected: selectedLoanType == 4,
                onPressed: () {
                  setState(() {
                    selectedLoanType = 4;
                  });
                  print(selectedLoanType);
                },
                loanType: 4,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: loanForm,
          )
        ],
      ),
    );
  }
}

class LoanTypeButton extends StatelessWidget {
  final int loanType;
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const LoanTypeButton({
    required this.loanType,
    required this.title,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            isSelected ? MaterialStateProperty.all(Colors.blue) : null,
      ),
      child: Text(title),
    );
  }
}

// MediaQuery.of(context).size.width * 0.3)
class PersonalLoanForm extends StatefulWidget {
  @override
  State<PersonalLoanForm> createState() => _PersonalLoanFormState();
}

class _PersonalLoanFormState extends State<PersonalLoanForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _salaryController = TextEditingController();
  bool _isNetSalary = false;
  bool _includeNssf = false;
  bool _includeNhif = false;
  bool _includeHousingLevy = false;
  double _result = 0.0;
  @override
  void dispose() {
    _salaryController.dispose();
    super.dispose();
  }

  void _calculatePaye() {
    // Perform PAYE calculation logic here
    double salary = double.tryParse(_salaryController.text) ?? 0;
    if (!_isNetSalary &&
        !_includeNssf &&
        !_includeNhif &&
        !_includeHousingLevy) {
      setState(() {
        // Assign calculated PAYE value to _result
        _result = (salary - 700) * 0.15; // Example calculation
      });
    } else if (_isNetSalary &&
        !_includeNssf &&
        !_includeNhif &&
        !_includeHousingLevy) {
      setState(() {
        // Assign calculated PAYE value to _result
        _result = (salary) * 0.15; // Example calculation
      });
    }
  }

  void _showModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _salaryController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Monthly Salary'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your monthly salary';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Text('Salary Type: '),
                    Radio(
                      value: false,
                      groupValue: _isNetSalary,
                      onChanged: (value) {
                        setState(() {
                          _isNetSalary = value!;
                        });
                      },
                    ),
                    Text('Net'),
                    Radio(
                      value: true,
                      groupValue: _isNetSalary,
                      onChanged: (value) {
                        setState(() {
                          _isNetSalary = value!;
                        });
                      },
                    ),
                    Text('Basic'),
                  ],
                ),
                SizedBox(height: 16.0),
                CheckboxListTile(
                  title: Text('Include NSSF'),
                  value: _includeNssf,
                  onChanged: (value) {
                    setState(() {
                      _includeNssf = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Include NHIF'),
                  value: _includeNhif,
                  onChanged: (value) {
                    setState(() {
                      _includeNhif = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Include Housing Levy'),
                  value: _includeHousingLevy,
                  onChanged: (value) {
                    setState(() {
                      _includeHousingLevy = value!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculatePaye();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Calculate PAYE'),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Result: $_result',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build the personal loan form here

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.5,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          items: [
            Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Text("KRA : Tax Bands and Rates"),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Tax Bands')),
                            DataColumn(label: Text('Annual')),
                            DataColumn(label: Text('Monthly')),
                            DataColumn(label: Text('Tax Rate')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('On the first')),
                              DataCell(Text('Shs. 288,000')),
                              DataCell(Text('Shs. 24,000')),
                              DataCell(Text('10%')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('On the next')),
                              DataCell(Text('Shs. 100,000')),
                              DataCell(Text('Shs. 8,333')),
                              DataCell(Text('25%')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('On the next')),
                              DataCell(Text('Shs. 5,612,000')),
                              DataCell(Text('Shs. 467,667')),
                              DataCell(Text('30%')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('On the next')),
                              DataCell(Text('Shs. 3,600,000')),
                              DataCell(Text('Shs. 300,000')),
                              DataCell(Text('32.5%')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('On all income in excess of')),
                              DataCell(Text('Shs. 9,600,000')),
                              DataCell(Text('Shs. 32,333')),
                              DataCell(Text('35%')),
                            ]),
                            // Add more rows as needed
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Text("NSSF Contribution Rates, 2024"),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('Lower Limit (Tier 1)')),
                              DataCell(Text('Shs.7,000')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Ttl Contribution by Employee')),
                              DataCell(Text('Shs. 420')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Ttl Contribution by Employer')),
                              DataCell(Text('Shs. 420')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Ttl Tier 1 NSSF Contributions')),
                              DataCell(Text('Shs. 840')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Upper Limit (Tier 2)')),
                              DataCell(Text('Shs. 36,000')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  'Contribution on Upper Limit(6% of upper Limit less Lower Limit)')),
                              DataCell(Text('Shs. 29,000')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Ttl Contribution by Employee')),
                              DataCell(Text('Shs.1,740')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Ttl Contribution by Employer')),
                              DataCell(Text('Shs. 1,740')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Ttl Tier 2 NSSF Contributions')),
                              DataCell(Text('Shs. 3,480')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Ttl NSSF Contributions')),
                              DataCell(Text('Shs. 4,320')),
                            ]),
                            // Add more rows as needed
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  Text("Other deductions, 2024"),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('NHIF')),
                              DataCell(Text('Shs.500 - Shs. 1,700')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Housing Levy')),
                              DataCell(Text('3% Salary')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Insurance Relief')),
                              DataCell(Text(
                                  '15%(Insurance Premiums + NHIF Contri)')),
                            ]),
                            // Add more rows as needed
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            _showModal();
          },
          child: Text('Paye'),
        )
      ],
    );
  }
}

class BusinessLoanForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Build the business loan form here
    return Text('Business Loan Form');
  }
}

class HomeLoanForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Build the home loan form here
    return Text('Home Loan Form');
  }
}

class EducationLoanForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Build the education loan form here
    return Text('Education Loan Form');
  }
}
