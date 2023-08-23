import 'package:flutter/material.dart';
import 'package:hotel_lemon_app/utils/app_dimension.dart';

import '../../../utils/app_colors.dart';


// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;

  AppTextField(
      {Key? key,
      this.isObscure = false,
      required this.icon,
      required this.textController,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimen.height20, right: Dimen.height20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimen.radius15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.2),
            )
          ]),
      child: TextField(
        obscureText: isObscure?true:false,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: ApClrs.yllowClr,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.radius15),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.radius15),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimen.radius15),
            // borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
