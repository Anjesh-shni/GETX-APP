import 'package:flutter/material.dart';
import 'package:hotel_lemon_app/utils/app_colors.dart';
import 'package:lottie/lottie.dart';

class NoDataPAge extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPAge(
      {Key? key,
      required this.text,
      this.imgPath = "assets/animation/empty.json"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          imgPath,
          height: MediaQuery.of(context).size.height * 0.26,
          width: MediaQuery.of(context).size.width * 0.26,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0275,
              color: ApClrs.textfontgreyColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
