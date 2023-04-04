import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

Widget carouselSlider(items) {
  var autoPlay = false;
  if (items.length > 0) {
    autoPlay = true;
  }
  return SizedBox(
    height: 200,
    child: Carousel(
      boxFit: BoxFit.cover,
      images: items,
      autoplay: autoPlay,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: const Duration(milliseconds: 1000),
    ),
  );
}
