import 'package:ecom_app/screens/donation_screen.dart';
import 'package:ecom_app/screens/login_screen.dart';
import 'package:ecom_app/screens/order_list_screen.dart';
import 'package:ecom_app/screens/privatedonation_screen.dart';
import 'package:ecom_app/screens/vregistration_screen.dart';
import 'package:ecom_app/widgets/video_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/complaint_screen.dart';


class SideDrawerNavigation extends StatefulWidget {
  @override
  _SideDrawerNavigationState createState() => _SideDrawerNavigationState();
}

class _SideDrawerNavigationState extends State<SideDrawerNavigation> {
  SharedPreferences? _prefs;
  String _loginLogoutMenuText = "Log In";
  IconData _loginLogoutIcon = FontAwesomeIcons.signInAlt;

  String _userName = '';



  _getUserName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userName = _prefs.getString('userName') ?? '';
    setState(() {
      _userName = userName;
    });
  }

  @override
  void initState() { 
    super.initState();
    _isLoggedIn();
    _getUserName();
  }

  _isLoggedIn() async {
    _prefs = await SharedPreferences.getInstance();
    int? userId = _prefs!.getInt('userId');
    if(userId == 0){
      setState(() {
        _loginLogoutMenuText = "Log In";
      _loginLogoutIcon = FontAwesomeIcons.signInAlt;
      });
    } else {
      setState(() {
        _loginLogoutMenuText = "Logout";
      _loginLogoutIcon = FontAwesomeIcons.signOutAlt;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Drawer(
        child: Container(
          color: Colors.redAccent,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.redAccent),
                accountName: Text(
                  'Welcome, $_userName!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                accountEmail: const Text('contact.rinfo@gmail.com'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    radius: 50,
                    child: Image.asset('assets/user.png'),
                  ),
                ),
              ),
              const ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(Icons.home, color: Colors.white),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivateDonationScreen(cartItems: [],)));
                },
                child: const ListTile(
                  title: Text(
                    'Private donation',
                    style: TextStyle(color: Colors.white),
                  ),

                  leading: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DonationScreen(cartItems: [],)));
                },
                child: const ListTile(
                  title: Text(
                    'donation',
                    style: TextStyle(color: Colors.white),
                  ),

                  leading: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  RegistrationScreen(cartItems: [],)));
                },
                child: const ListTile(
                  title: Text(
                    'volunteer',
                    style: TextStyle(color: Colors.white),
                  ),

                  leading: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  VideoSlider()));
                },
                child: const ListTile(
                  title: Text(
                    'video',
                    style: TextStyle(color: Colors.white),
                  ),

                  leading: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ComplaintScreen(cartItems: [],)));
                },
                child: const ListTile(
                  title: Text(
                    'ComplaintScreen',
                    style: TextStyle(color: Colors.white),
                  ),

                  leading: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                ),
              ),
              
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderListScreen()));
                },
                child: const ListTile(
                  title: Text(
                    'Order List',
                    style: TextStyle(color: Colors.white),
                  ),
                  
                  leading: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(cartItems: [],)));
                  },
                  child: ListTile(
                    title: Text(
                      _loginLogoutMenuText,
                      style: const TextStyle(color: Colors.white),
                    ),
                    
                    leading: Icon(
                      _loginLogoutIcon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
