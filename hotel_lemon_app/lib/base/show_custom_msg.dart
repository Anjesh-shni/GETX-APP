import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_lemon_app/widget/bigtext.dart';

import '../utils/colors.dart';



void showCuastomSnackBAr(String messege,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(
    title,
    messege,
    snackPosition: SnackPosition.TOP,
    backgroundColor: ApClrs.mainClr,
    titleText: BigText(
      text: title,
      color: Colors.black,
      size: 16,
    ),
    messageText: Text(
      messege,
      style: const TextStyle(
        color: Colors.redAccent,
      ),
    ),
  );
}
