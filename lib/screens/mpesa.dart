import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class MpesaPage extends StatefulWidget {
  @override
  _MpesaPageState createState() => _MpesaPageState();
}

class _MpesaPageState extends State<MpesaPage> {
  Future<void> startCheckout(
      {required String userPhone, required double amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: "174379",
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: amount,
              partyA: userPhone,
              partyB: "174379",
              callBackURL: Uri(
                  scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
              accountReference: "shoe",
              phoneNumber: userPhone,
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "purchase",
              passKey: 'APigULQBmSVtvdd5gE5QaYxiyzGIkLYPrgnXc7onA0dAgjR5');

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      //You can check sample parsing here -> https://github.com/keronei/Mobile-Demos/blob/mpesa-flutter-client-app/lib/main.dart

      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());

      /*
      Other 'throws':
      1. Amount being less than 1.0
      2. Consumer Secret/Key not set
      3. Phone number is less than 9 characters
      4. Phone number not in international format(should start with 254 for KE)
       */
    }
  }

  List<Map<String, dynamic>> itemsOnSale = [
    {
      "image": "imgs/saf.png",
      "itemName": """Mpesa to Wan acc.""",
      "price": 1.0
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.brown[450], primarySwatch: Colors.brown),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mpesa Tranfer'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 4.0,
              child: Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Color.fromARGB(255, 32, 133, 52)),
                height: MediaQuery.of(context).size.height * 0.35,
                //color: Colors.brown,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Image.asset(
                        itemsOnSale[index]["image"],
                        fit: BoxFit.contain,
                      ),
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.95,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            itemsOnSale[index]["itemName"],
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ),
                        Text(
                          "Ksh. " + itemsOnSale[index]["price"].toString(),
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                            ),
                            onPressed: () async {
                              var providedContact =
                                  await _showTextInputDialog(context);

                              if (providedContact != null) {
                                if (providedContact.isNotEmpty) {
                                  startCheckout(
                                      userPhone: providedContact,
                                      amount: itemsOnSale[index]["price"]);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Empty Number!'),
                                          content: Text(
                                              "You did not provide a number to be charged."),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: const Text("Cancel"),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        );
                                      });
                                }
                              }
                            },
                            child: const Text("Mobile"))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: itemsOnSale.length,
        ),
      ),
    );
  }

  final _textFieldController = TextEditingController();

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('M-Pesa Number'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "+254..."),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text('Proceed'),
                onPressed: () =>
                    Navigator.pop(context, _textFieldController.text),
              ),
            ],
          );
        });
  }
}