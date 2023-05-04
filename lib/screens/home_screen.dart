import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_app/delegates/product_search.dart';
import 'package:ecom_app/helpers/side_drawer_navigation.dart';
import 'package:ecom_app/models/productcategory.dart';
import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/models/upicategory.dart';
import 'package:ecom_app/pages/slide.dart';
import 'package:ecom_app/screens/cart_screen.dart';
import 'package:ecom_app/services/cart_service.dart';
import 'package:ecom_app/services/productcategory_service.dart';
import 'package:ecom_app/services/product_service.dart';
import 'package:ecom_app/services/slider_service.dart';
import 'package:ecom_app/services/upicategory_service.dart';
import 'package:ecom_app/widgets/carousel_slider.dart';
import 'package:ecom_app/widgets/home_hot_products.dart';
import 'package:ecom_app/widgets/home_new_arrival_products.dart';
import 'package:ecom_app/widgets/home_product_categories.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  SliderService _sliderService = SliderService();
  ProductCategoryService _categoryService = ProductCategoryService();

  ProductService _productService = ProductService();

  List<ProductCategory> _productcategoryList = <ProductCategory>[];

  List<Product> _productList = <Product>[];
  List<Product> _allProductList = <Product>[];
  List<Product> _newArrivalproductList = <Product>[];

  CartService _cartService = CartService();
  late List<Product> _cartItems;

  var items = [];



  @override
  void initState() {
    super.initState();
    //_getAllSliders();
    _getAllProductCategories();

    _getAllHotProducts();
    _getAllNewArrivalProducts();
    _getCartItems();
    _getAllProducts();

  }

  _getCartItems() async {
    _cartItems = <Product>[];
    var cartItems = await _cartService.getCartItems();
    cartItems.forEach((data) {
      var product = Product();
      product.id = data['productId'];
      product.name = data['productName'];
      product.photo = data['productPhoto'];
      product.price = data['productPrice'];
      product.discount = data['productDiscount'];
      product.productDetail = data['productDetail'] ?? 'No detail';
      product.quantity = data['productQuantity'];

      setState(() {
        _cartItems.add(product);
      });
    });
  }

  // _getAllSliders() async {
  //   var sliders = await _sliderService.getSliders();
  //   var result = json.decode(sliders.body);
  //   result['data'].forEach((data) {
  //     setState(() {
  //       items.add(NetworkImage(data['image_url']));
  //     });
  //   });
  // }

  _getAllProductCategories() async {
    var categories = await _categoryService.getProductCategories();
    var result = json.decode(categories.body);
    result['data'].forEach((data) {
      var model = ProductCategory();
      model.id = data['id'];
      model.name = data['name'];
      model.icon = data['icon'];
      setState(() {
        _productcategoryList.add(model);
      });
    });
  }



  _getAllProducts() async {
    var products = await _productService.getAllProducts();
    var result = json.decode(products.body);
    result['data'].forEach((data) {
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.productDetail = data['detail'];

      setState(() {
        _allProductList.add(model);
      });
    });
  }

  _getAllHotProducts() async {
    var hotProducts = await _productService.getHotProducts();
    var result = json.decode(hotProducts.body);
    result['data'].forEach((data) {
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.productDetail = data['detail'];

      setState(() {
        _productList.add(model);
      });
    });
  }

  _getAllNewArrivalProducts() async {
    var newArrivalProducts = await _productService.getNewArrivalProducts();
    var result = json.decode(newArrivalProducts.body);
    result['data'].forEach((data) {
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.productDetail = data['detail'];

      setState(() {
        _newArrivalproductList.add(model);
      });
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawerNavigation(),
      appBar: AppBar(
        title: const Text('eComm App'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: ProductSearch(products: _allProductList));
          }),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(_cartItems),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 150,
                width: 30,
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      iconSize: 30,
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Positioned(
                      child: Stack(
                        children: <Widget>[
                          const Icon(Icons.brightness_1,
                              size: 25, color: Colors.black),
                          Positioned(
                            top: 4.0,
                            right: 8.0,
                            child: Center(
                                child: Text(_cartItems.length.toString())),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
          child: ListView(
            children: <Widget>[
              //slide(),
              //carouselSlider(items),

              CarouselSlider(
                items: [

                  //1st Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://myconstituency.in/ecom-api/public/37278.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //2nd Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage("https://myconstituency.in/ecom-api/public/31641.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //3rd Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage("https://myconstituency.in/ecom-api/public/16842.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //4th Image of Slider
                  // Container(
                  //   margin: EdgeInsets.all(6.0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     image: DecorationImage(
                  //       image: NetworkImage("ADD IMAGE URL HERE"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  //
                  // //5th Image of Slider
                  // Container(
                  //   margin: EdgeInsets.all(6.0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     image: DecorationImage(
                  //       image: NetworkImage("ADD IMAGE URL HERE"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),

                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Product Categories'),
              ),
              HomeProductCategories(
                categoryList: _productcategoryList,
              ),

              
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Hot Products'),
              ),
              HomeHotProducts(
                productList: _productList,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('New Arrival Products'),
              ),
              HomeNewArrivalProducts(
                productList: _newArrivalproductList,
              )
            ],
          )),
      
    );
  }
}
