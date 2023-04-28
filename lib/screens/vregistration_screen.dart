import 'dart:convert';

import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/models/skillcategory.dart';
import 'package:ecom_app/models/statecategory.dart';
import 'package:ecom_app/models/vregistration.dart';
import 'package:ecom_app/screens/choose_payment_method.dart';
import 'package:ecom_app/services/skillcategory_service.dart';
import 'package:ecom_app/services/statecategory_service.dart';
import 'package:ecom_app/services/vregistration_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  final List<Product> cartItems;
  const RegistrationScreen({super.key, required this.cartItems});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final name = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final adress = TextEditingController();
  final pin = TextEditingController();

  //*****************************
  TextEditingController date = TextEditingController();

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

  SkillCategory? _selectedCategory1;

  SkillCategoryService _skillcategoryService = SkillCategoryService();
  final List<SkillCategory> _skillcategoryList = [];

  _getAllSkillCategories() async {
    var skillCategories = await _skillcategoryService.getSkillCategories();
    var result = json.decode(skillCategories.body);
    result['data'].forEach((data) {
      var model = SkillCategory();
      model.id = data['id'];
      model.name = data['name'];
      print(_skillcategoryList);
      setState(() {
        _skillcategoryList.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllStateCategories();
    _getAllSkillCategories();
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
              child: Text('volunteer',
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

            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 10.0, right: 10.0),
                    child: Container(
                      //color: Color.fromRGBO(0, 0, 0, 0.10),
                      color: Colors.white,

                      child: TextField(
                        controller: date,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            //icon of text field
                            labelText:
                            "Birth Date" //label text of field
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = new
                            DateFormat('yyyy-MM-dd')
                                .format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              date.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                    ),
                  ),
                ),
              ],
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

                decoration:
                const InputDecoration(hintText: 'Address', labelText: 'Address'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(

                controller: pin,
                decoration: const InputDecoration(
                    hintText: 'Enter pin',
                    labelText: 'Enter pin'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: DropdownButton<SkillCategory>(
                hint: Text('Select Skill'),
                value: _selectedCategory1, // The currently selected category
                items: _skillcategoryList.map((category) {
                  return DropdownMenuItem<SkillCategory>(
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
                  return _skillcategoryList.map<Widget>((category) {
                    return Text(category.name ?? '');
                  }).toList();
                },
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 320.0,
                  height: 45.0,
                  child: ElevatedButton(

                    onPressed: () {
                      var registration = Registration();
                      registration.name = name.text;
                      registration.mobile = mobile.text;
                      registration.email = email.text;
                      registration.date = date.text;
                      registration.statecategory = _selectedCategory?.name ?? '';
                      registration.adress = adress.text;
                      registration.pin = pin.text;
                      registration.skillcategory = _selectedCategory1?.name ?? '';
                      _registration(context, registration);
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
  void _registration(context, Registration registration) async {
    var registrationService = RegistrationService();
    var registrationData = await registrationService.addRegistration(registration);
    var result =await json.decode(registrationData.body);

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
