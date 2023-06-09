import 'package:ecom_app/models/productcategory.dart';
import 'package:ecom_app/screens/products_by_category_screen.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final ProductCategory category;
  CategoryWidget(this.category);
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: 190,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductsByCategoryScreen(categoryId: widget.category.id!, categoryName: this.widget.category.name!,)));
        },
        child: Card(
          child: Column(
            children: <Widget>[
              Text(this.widget.category.name!),
              Image.network(
                widget.category.icon!,
                width: 190.0,
                height: 160.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
