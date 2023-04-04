import 'dart:convert';

import 'package:ecom_app/models/order.dart';
import 'package:ecom_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {

  List<Order> _orderList = <Order>[];
  @override
  void initState() {
    super.initState();
    _getOrderListByUserId();
  }

  _getOrderListByUserId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? _userId = _prefs.getInt('userId');
    OrderService _orderService = OrderService();
    var result = await _orderService.getOrdersByUserId(_userId!);
    var orders = json.decode(result.body);
    orders.forEach((order){
      var model = Order();
      model.id = order['id'];
      model.quantity = order['quantity'];
      model.amount = double.tryParse(order['amount'].toString())!;
      model.product.name = order['product']['name'];
      model.product.photo = order['product']['photo'];

      setState(() {
        _orderList.add(model);
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order List Screen')),

      body: ListView.builder(
        itemCount: _orderList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              leading: Image.network(_orderList[index].product.photo!),
              title: Text(_orderList[index].product.name!),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("quantity : ${_orderList[index].quantity.toString()}"),
                  Text('-'),
                  Text("amount : \$${_orderList[index].amount.toString()}")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
