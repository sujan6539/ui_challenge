import 'dart:ui';

import 'package:flutter/material.dart';

class Drinks {
  String name;
  String price;
  String image;
  Color color1;
  Color color2;

  Drinks(
      {required this.name,
      required this.price,
      required this.image,
      required this.color1,
      required this.color2});
}

final List<Drinks> shakes = [
  Drinks(
      name: "Orange Juice Shake",
      price: "\$6",
      image: "assets/images/smoothie.png",
      color1: Colors.orange.shade800,
      color2: Colors.orange.shade600),
  Drinks(
    name: "Strawberry Shake",
    price: "\$5",
    image: "assets/images/strawberry.png",
    color1: Colors.pinkAccent.shade700,
    color2: Colors.pinkAccent.shade200,
  ),
  Drinks(
      name: "Chocolate Shake",
      price: "\$6",
      image: "assets/images/chocolate.png",
      color1: Colors.brown.shade700,
      color2: Colors.brown.shade400),
];

final List<Drinks> coffee = [
  Drinks(
      name: "Espresso",
      price: "\$6",
      image: "/assets/images/smoothie.png",
      color1: Colors.orange.shade800,
      color2: Colors.orange.shade600),
  Drinks(
    name: "Strawberry Shake",
    price: "\$5",
    image: "/assets/images/smoothie.png",
    color1: Colors.pinkAccent.shade700,
    color2: Colors.pinkAccent.shade200,
  ),
  Drinks(
      name: "Orange Juice Shake",
      price: "\$6",
      image: "/assets/images/smoothie.png",
      color1: Colors.orange.shade800,
      color2: Colors.orange.shade600),
];
