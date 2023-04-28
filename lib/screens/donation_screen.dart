import 'dart:convert';

import 'package:ecom_app/models/donation.dart';
import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/services/donation_service.dart';
import 'package:ecom_app/services/statecategory_service.dart';
import 'package:flutter/material.dart';

import '../models/statecategory.dart';
import 'choose_payment_method.dart';

class DonationScreen extends StatefulWidget {

  final List<Product> cartItems;
  const DonationScreen({super.key, required this.cartItems});


  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {

  final amount = TextEditingController();
  final name = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final adress = TextEditingController();
  final cause = TextEditingController();
  final referral = TextEditingController();

  StateCategory? _selectedCategory;

  StateCategoryService _statecategoryService = StateCategoryService();
  final List<StateCategory> _statecategoryList = [];

  _getAllStateCategories() async {
    var stateCategories = await _statecategoryService.getStateCategories();
    var result = json.decode(stateCategories.body);
    result['data'].forEach((data) {
      var model = StateCategory();
      model.id = data['id'];
      model.name = data['name'];
      print(_statecategoryList);
      setState(() {
        _statecategoryList.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllStateCategories();
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
              child: Text('Donation',
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
                    hintText: 'Enter Amount', labelText: 'Enter Amount'),
              ),
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
                keyboardType: TextInputType.phone,
                controller: mobile,
                decoration: const InputDecoration(
                    hintText: 'Enter Mobile Number', labelText: 'Enter Mobile Number'),
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
              child: DropdownButton<StateCategory>(
                hint: Text('Select State'),
                value: _selectedCategory, // The currently selected category
                items: _statecategoryList.map((category) {
                  return DropdownMenuItem<StateCategory>(
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
                  return _statecategoryList.map<Widget>((category) {
                    return Text(category.name ?? '');
                  }).toList();
                },
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
                      var donation = Donation();
                      donation.amount = amount.text;
                      donation.name = name.text;
                      donation.mobile = mobile.text;
                      donation.email = email.text;
                      donation.statecategory = _selectedCategory?.name ?? '';
                      donation.adress = adress.text;
                      donation.cause = cause.text;
                      donation.referral = referral.text;
                      _donation(context, donation);
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

  void _donation(context, Donation donation) async {
    var donationService = DonationService();
    var donationData = await donationService.addDonation(donation);
    var result =await json.decode(donationData.body);

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
