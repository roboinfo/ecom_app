import 'package:ecom_app/models/product.dart';

class Order {
  int? id;
  String? paymentType;
  int? quantity;
  double? amount;
  int? productId;
  Product product = Product();
}