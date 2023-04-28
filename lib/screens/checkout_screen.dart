import 'dart:convert';

import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/models/shipping.dart';
import 'package:ecom_app/screens/choose_payment_method.dart';
import 'package:ecom_app/services/shipping_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> cartItems;
  const CheckoutScreen({super.key, required this.cartItems});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {


  final name = TextEditingController();

  final email = TextEditingController();

  final adress = TextEditingController();



  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    //_scaffoldKey.currentState!.showSnackBar(_snackBar);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.redAccent,
        leading: Text(''),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: ListView(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(
                  left: 28.0, top: 28.0, right: 28.0, bottom: 14.0),
              child: Text('Shipping Address',
                  style:
                      TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
            ),
            const Divider(
              height: 5.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: name,
                decoration: const InputDecoration(
                    hintText: 'Enter your name', labelText: 'Enter your name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                decoration: const InputDecoration(
                    hintText: 'Enter your email address',
                    labelText: 'Enter your email address'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: adress,
                maxLines: 3,
                decoration:
                    const InputDecoration(hintText: 'Address', labelText: 'Address'),
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 320.0,
                  height: 45.0,
                  child: ElevatedButton(

                    onPressed: () {
                      var shipping = Shipping();
                      shipping.name = name.text;
                      shipping.email = email.text;
                      shipping.adress = adress.text;
                      _shipping(context, shipping);
                    },
                    child: const Text('Continue to Payment',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _shipping(context, Shipping shipping) async {
    var shippingService = ShippingService();
    var shippingData = await shippingService.addShipping(shipping);
    var result =await json.decode(shippingData.body);

    if (result['result'] == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChoosePaymentOption(
                    cartItems: widget.cartItems,
                  )));
    } else {
      _showSnackMessage(const Text('Failed to add shipping', style: TextStyle(color: Colors.red),));
    }
  }

  // Future<void> _shipping(BuildContext context, Shipping shipping) async {
  //   try {
  //     var shippingService = ShippingService();
  //     var shippingData = await shippingService.addShipping(shipping);
  //     var result = json.decode(shippingData.body) as Map<String, dynamic>;
  //
  //     if (result['result'] == true) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PaymentScreen(
  //             cartItems: widget.cartItems,
  //             paymentType: '',
  //           ),
  //         ),
  //       );
  //     } else {
  //       _showSnackbarMessage(
  //         context,
  //         const Text(
  //           'Failed to add shipping',
  //           style: TextStyle(color: Colors.red),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     _showSnackbarMessage(
  //       context,
  //       const Text(
  //         'An error occurred while adding shipping.',
  //         style: TextStyle(color: Colors.red),
  //       ),
  //     );
  //   }
  // }
  //
  // void _showSnackbarMessage(BuildContext context, Widget message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: message,
  //     ),
  //   );
  // }


}
