import 'package:flutter/material.dart';

class Dimensions {
  final BuildContext context;
  final double deviceWidth;
  final double deviceHeight;

  Dimensions(this.context)
    : deviceWidth = MediaQuery.of(context).size.width,
      deviceHeight = MediaQuery.of(context).size.height;
}
