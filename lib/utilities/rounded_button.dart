import 'package:flutter/material.dart';

Color light = Color(0xffc6f1e7), dark = Color(0xff0D1728), pink = Color(0xfffa4659);

class RoundedButton extends StatelessWidget {

  final Color colour;
  final String label;
  final Function onPressed;
  final double width;

  RoundedButton({@required this.label, @required this.colour, @required this.onPressed, this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: width ?? 200.0,
          height: 42.0,
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: dark,
              fontSize: 16
            ),
          ),
        ),
      ),
    );
  }
}