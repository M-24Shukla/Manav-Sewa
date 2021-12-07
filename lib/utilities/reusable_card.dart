import 'package:flutter/material.dart';

Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);

class ReusableCard extends StatelessWidget {

  ReusableCard({@required this.colour, this.cardChild, this.onPress, this.width});

  final Color colour;
  final Widget cardChild;
  final Function onPress;
  final int width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPress,
      child: Container(
        // width: double.infinity,
        child: cardChild,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colour,
          boxShadow: [BoxShadow(blurRadius: 2, color: dark)]
        ),
      ),
    );
  }
}