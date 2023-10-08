import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_lemon_app/features/presentation/reusable_widget/bigtext.dart';
import 'package:hotel_lemon_app/features/presentation/reusable_widget/custom_button.dart';
import 'package:hotel_lemon_app/features/presentation/reusable_widget/smalltext.dart';
import 'package:hotel_lemon_app/utils/app_colors.dart';
import '../../../utils/app_dimension.dart';

Widget dialogueButton(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BigText(
          text: "Confirm",
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        SizedBox(
          height: Dimen.height10,
        ),
        SmallTxt(
          text: "Are you sure want to exit !",
        ),
        SizedBox(
          height: Dimen.height15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
              color: ApClrs.greenColor,
              title: "Yes",
              textColor: ApClrs.textfontgreyColor,
              onPress: () {
                SystemNavigator.pop();
              },
            ),
            customButton(
              color: ApClrs.greenColor,
              title: "No",
              textColor: ApClrs.textfontgreyColor,
              onPress: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    ),
  );
}
