import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_app/services/slider_service.dart';
import 'package:flutter/material.dart';

class carouselSlider extends StatefulWidget {
  const carouselSlider({Key? key}) : super(key: key);

  @override
  State<carouselSlider> createState() => _carouselSliderState();
}

class _carouselSliderState extends State<carouselSlider> {

  SliderService _sliderService = SliderService();
  final List<String> items = [];

  @override
  void initState() {
    super.initState();
    _getAllSliders();

  }

  _getAllSliders() async {
    var sliders = await _sliderService.getSliders();
    var result = json.decode(sliders.body);
    result['data'].forEach((data) {
      setState(() {
        items.add(data['image_url'].toString());
      });
    });
    // print(result);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          //autoPlayInterval: Duration(milliseconds: 1000),
          autoPlayAnimationDuration: Duration(milliseconds: 1000),
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: items
            .map((item) => Image(
          image: NetworkImage(
            item,
          ),
          fit: BoxFit.cover,
        ))
            .toList(),
      ),
    );
  }
}
