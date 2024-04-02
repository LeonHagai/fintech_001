import 'package:fintech_001/screens/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import '../models/Members.dart';

class FundTransferPage extends StatefulWidget {
  final String username;
  final String category;
  final String name;  
  final String bal;


  const FundTransferPage({super.key, required this.username, required this.category, required this.name, required this.bal});
  @override
  _FundTransferPageState createState() => _FundTransferPageState();
}

class _FundTransferPageState extends State<FundTransferPage> {
  late String username;
  late String name;
  late String category;
  late String bal;
  TextEditingController controllerGrpName = TextEditingController();  
  TextEditingController controllerAmntGrp = TextEditingController();
  TextEditingController controllerPrsnTo = TextEditingController();
  TextEditingController controllerAmntPrsn = TextEditingController();

  String selectedTransactionType = '';
  bool isError = false;

  final TextEditingController personPhoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    username = widget.username;
    category = widget.category;
    bal = widget.bal;
    name = widget.name;
  }

  Future<void> lipaNaMpesa(context) async {
    dynamic transactionInitialisation;

    String phoneNumber = personPhoneController.text;
    phoneNumber = phoneNumber.substring(1);

    MpesaFlutterPlugin.setConsumerKey(
        'APigULQBmSVtvdd5gE5QaYxiyzGIkLYPrgnXc7onA0dAgjR5');
    MpesaFlutterPlugin.setConsumerSecret(
        'd7QWMozfZYhD1EqM71k7UzjyNeESUH5oBUKChP6zpkUJDQstiDkmN8sgwuEvSdq8');

    try {
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: double.parse(amountController.text),
        partyA: "254$phoneNumber",
        partyB: "174379",
        callBackURL: Uri(
          scheme: 'http',
          host: 'mpesa-requestbin.herokuapp.com',
          path: '/sno353sn',
        ),
        accountReference: username,
        phoneNumber: "254${personPhoneController.text}",
        baseUri: Uri(scheme: 'http', host: 'sandbox.safaricom.co.ke'),
        transactionDesc: "transfer",
        passKey:
            "dytLc3tryDExEH8cb643MzE+hl44JqRcKM2qVv3Jzx61N/FoPb5NSIh/dwncGLY1/npOYq06yffewWkuH+DpQWAmLkGVASwxrL0kJ4gtNiCVuf5qvqV3Z0knsS3KuocEcoCXXC9sICLV3F0wHOkeypjRa1BTzbnDFyc2263bXHMzghVtkaMvbN/MtnHiR7+FBuwNBoUhiwJh6DAtcVgLp/P8Ku4pJpot7czk3+CLlyDSPestOSZQfZfaU8CqPPRcdPzJNnpqhmucTfk6seK4RCKp6+nXb75/wZrHZ3c9AcHSmJZCD9W6FTIkRRDmx/hE9rp/83tDOrkMDhoajXyBAA==",
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"transaction result: $transactionInitialisation"'),
        ),
      );
      return transactionInitialisation;
    } catch (e) {
      print("Caught Exception" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Fund Transfer', context),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.015,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.17,
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Text(
                    'Group Name: $name',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'ID: $username',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Bal: KSH: $bal.00',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          
          _buildTopSection(),
          if (selectedTransactionType == 'group')
            _buildGroupTransferForm()
          else if (selectedTransactionType == 'individual')
            _buildIndividualTransferForm(),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
            onPressed: () {
              setState(() {
                selectedTransactionType = 'group';
              });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.blue),
            ),
            child: Text(
              'Group',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                selectedTransactionType = 'individual';
              });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.green),
            ),
            child: Text(
              'Individual',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupTransferForm() {
    // Customize this section for the group transfer form
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Deposit: Free/=',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          // Add your group transfer form fields here
          // For example:
          CustomTextField(controller: controllerGrpName, labelText: "Group ID", hintText: "Group ID", keyboardType: TextInputType.text),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          CustomTextField(controller: controllerAmntGrp, labelText: "Amount Sending to Grouo", hintText: "Group Amount", keyboardType: TextInputType.text),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: () {
              // Handle group transfer submission
              print('Group Transfer Submitted');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualTransferForm() {
    // Customize this section for the individual transfer form
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Inter-Transfer: Free/=',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          TextField(
            controller: personPhoneController,
            decoration: InputDecoration(
              labelText: "Person ID:",
              hintText: "Type ID, wait to confirm.",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                    color: isError
                        ? Colors.red
                        : Colors
                            .black), // Change border color based on input length
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          CustomTextField(
            controller: amountController,
            labelText: "Ksh:",
            hintText: "Enter amount.",
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: () {
              if (personPhoneController.text.isNotEmpty) {
                print(personPhoneController.text);

                if (personPhoneController.text.length < 9) {
                  isError = true;
                } else {
                  print(personPhoneController.text);
                  lipaNaMpesa(context);
                }
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text('Welcome!'),
                //   ),
                // );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All Fields are required!'),
                  ),
                );
              }
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}
