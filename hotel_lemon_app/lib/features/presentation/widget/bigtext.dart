import 'package:flutter/material.dart';
import 'package:hotel_lemon_app/utils/app_dimension.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;

  BigText({
    Key? key,
    this.color = const Color(0xff332d2b),
    this.size = 20,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.clip,
      maxLines: 1,
      style: TextStyle(
        fontFamily: "Roboto",
        fontSize: size == 0 ? Dimen.font20 : size = 16,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
