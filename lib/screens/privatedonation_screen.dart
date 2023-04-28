import 'dart:convert';

import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/models/upicategory.dart';
import 'package:ecom_app/screens/choose_payment_method.dart';
import 'package:ecom_app/services/privatedonation_service.dart';
import 'package:ecom_app/services/upicategory_service.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/models/privatedonation.dart';

class PrivateDonationScreen extends StatefulWidget {
  final List<Product> cartItems;
  const PrivateDonationScreen({super.key, required this.cartItems});

  @override
  State<PrivateDonationScreen> createState() => _PrivateDonationScreenState();
}

class _PrivateDonationScreenState extends State<PrivateDonationScreen> {

  final amount = TextEditingController();

  final cause = TextEditingController();

  final referral = TextEditingController();



  //******************************
  UpiCategory? _selectedCategory;

  UpiCategoryService _upicategoryService = UpiCategoryService();
  final List<UpiCategory> _upicategoryList = [];

  _getAllUpiCategories() async {
    var upiCategories = await _upicategoryService.getUpiCategories();
    var result = json.decode(upiCategories.body);
    result['data'].forEach((data) {
      var model = UpiCategory();
      model.id = data['id'];
      model.name = data['upiName'];
      print(_upicategoryList);
      setState(() {
        _upicategoryList.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllUpiCategories();
  }

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
              child: Text('Private Donation',
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
                controller: amount,
                decoration: const InputDecoration(
                    hintText: 'Enter amount', labelText: 'Enter amount'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(

                controller: cause,
                decoration: const InputDecoration(
                    hintText: 'Enter cause for donation',
                    labelText: 'Enter cause for donation'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: DropdownButton<UpiCategory>(
                hint: Text('Select Upi Type'),
                value: _selectedCategory, // The currently selected category
                items: _upicategoryList.map((category) {
                  return DropdownMenuItem<UpiCategory>(
                    value: category,
                    child: Text(category.name?? ''),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value; // Set the selected category
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return _upicategoryList.map<Widget>((category) {
                    return Text(category.name ?? '');
                  }).toList();
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: referral,
                maxLines: 3,
                decoration:
                const InputDecoration(hintText: 'referral code', labelText: 'referral code'),
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 320.0,
                  height: 45.0,
                  child: ElevatedButton(

                    onPressed: () {
                      var privatedonation = PrivateDonation();

                      privatedonation.amount = amount.text;
                      privatedonation.cause = cause.text;
                      privatedonation.upicategory = _selectedCategory?.name ?? '';
                      privatedonation.referral = referral.text;
                      _privatedonation(context, privatedonation);
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

  void _privatedonation(context, PrivateDonation privatedonation) async {
    var privatedonationService = PrivateDonationService();
    var privatedonationData = await privatedonationService.addPrivateDonation(privatedonation);
    var result =await json.decode(privatedonationData.body);

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

}
