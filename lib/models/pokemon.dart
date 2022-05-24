import 'package:flutter/cupertino.dart';

class Pokemon with ChangeNotifier {
  final String name;
  final int number;
  final String image;
  final String type;
  final String description;
  final String color;

  Pokemon({
    this.name,
    this.number,
    this.image,
    this.type,
    this.description,
    this.color,
  });
}
