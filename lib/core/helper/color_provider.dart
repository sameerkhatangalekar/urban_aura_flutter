import 'dart:math';

import 'package:flutter/material.dart';

final List<Color> imagePlaceholderColors = [
  Colors.red.shade100,
  Colors.pink.shade100,
  Colors.purple.shade100,
  Colors.deepPurple.shade100,
  Colors.blue.shade100,
  Colors.cyan.shade100,
  Colors.teal.shade100,
  Colors.green.shade100,
  Colors.lightGreen.shade100,
  Colors.lime.shade100,
  Colors.yellow.shade100,
  Colors.amber.shade100,
  Colors.orange.shade100,
  Colors.deepOrange.shade100,
  Colors.brown.shade100,
  Colors.grey.shade100,
  Colors.blueGrey.shade100
];

Color getRandomColor() {
  final rand = Random();

  return imagePlaceholderColors[rand.nextInt(imagePlaceholderColors.length)];
}

Map<String, String> colorMap = {
  "brick brown": "#6f4f28",
  "brown check": "#8d3f2f",
  "chocolate brown": "#3d2b1f",
  "black": "#000000",
  "floral purple": "#6a0dad",
  "cocoa brown": "#4e3a26",
  "beige": "#f5f5dc",
  "pink": "#ffc0cb",
  "pink satin" :  "#ffc0cb",
  "white": "#ffffff",
  "floral": "#c0c0c0",
  "floral black": "#000000",
  "green": "#008000"
};

Color hexToColor(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6 || hex.length == 7) buffer.write('ff');
  buffer.write(hex.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}