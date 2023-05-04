import 'dart:convert';

import 'package:ecom_app/models/blockcategory.dart';
import 'package:ecom_app/models/complaint.dart';
import 'package:ecom_app/models/complaintcategory.dart';
import 'package:ecom_app/screens/choose_payment_method.dart';
import 'package:ecom_app/services/blockcategory_service.dart';
import 'package:ecom_app/services/complaintcategory_service.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/complaint_service.dart';

class ComplaintScreen extends StatefulWidget {
  final List<Product> cartItems;
  const ComplaintScreen({super.key, required this.cartItems});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {

  final description = TextEditingController();

  final adress = TextEditingController();

  //*****************************
  TextEditingController date = TextEditingController();

  BlockCategory? _selectedCategory;

  BlockCategoryService _blockcategoryService = BlockCategoryService();
  final List<BlockCategory> _blockcategoryList = [];

  _getAllBlockCategories() async {
    var blockCategories = await _blockcategoryService.getBlockCategories();
    var result = json.decode(blockCategories.body);
    result['data'].forEach((data) {
      var model = BlockCategory();
      model.id = data['id'];
      model.name = data['name'];
      print(_blockcategoryList);
      setState(() {
        _blockcategoryList.add(model);
      });
    });
  }

  ComplaintCategory? _selectedCategory1;

  ComplaintCategoryService _complaintcategoryService = ComplaintCategoryService();
  final List<ComplaintCategory> _complaintcategoryList = [];

  _getAllComplaintCategories() async {
    var complaintCategories = await _complaintcategoryService.getComplaintCategories();
    var result = json.decode(complaintCategories.body);
    result['data'].forEach((data) {
      var model = ComplaintCategory();
      model.id = data['id'];
      model.name = data['name'];
      print(_complaintcategoryList);
      setState(() {
        _complaintcategoryList.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllBlockCategories();
    _getAllComplaintCategories();
    date.text = "";
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
              child: Text('Complaint Report',
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
              child: DropdownButton<BlockCategory>(
                hint: Text('Select Block'),
                value: _selectedCategory, // The currently selected category
                items: _blockcategoryList.map((category) {
                  return DropdownMenuItem<BlockCategory>(
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
                  return _blockcategoryList.map<Widget>((category) {
                    return Text(category.name ?? '');
                  }).toList();
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: DropdownButton<ComplaintCategory>(
                hint: Text('Select Complaint'),
                value: _selectedCategory1, // The currently selected category
                items: _complaintcategoryList.map((category) {
                  return DropdownMenuItem<ComplaintCategory>(
                    value: category,
                    child: Text(category.name?? ''),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory1 = value; // Set the selected category
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return _complaintcategoryList.map<Widget>((category) {
                    return Text(category.name ?? '');
                  }).toList();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: description,
                decoration: const InputDecoration(
                    hintText: 'Enter description', labelText: 'Enter description'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: adress,
                decoration: const InputDecoration(
                    hintText: 'Enter address', labelText: 'Enter address'),
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 320.0,
                  height: 45.0,
                  child: ElevatedButton(

                    onPressed: () {
                      var complaint = Complaint();
                      complaint.blockcategory = _selectedCategory?.name ?? '';
                      complaint.complaintcategory = _selectedCategory1?.name ?? '';
                      complaint.description = description.text;
                      complaint.adress = adress.text;
                      _complaint(context, complaint);
                    },
                    child: const Text('Submit',
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
  void _complaint(context, Complaint complaint) async {
    var complaintService = ComplaintService();
    var complaintData = await complaintService.addComplaint(complaint);
    var result =await json.decode(complaintData.body);

    // if (result['result'] == true) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => ChoosePaymentOption(
    //             cartItems: widget.cartItems,
    //           )));
    // } else {
    //   _showSnackMessage(const Text('Failed to add shipping', style: TextStyle(color: Colors.red),));
    // }
  }
}
