import 'package:flutter/material.dart';
import 'package:hotel_lemon_app/features/presentation/reusable_widget/bigtext.dart';

Widget customButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: BigText(text: title!),
  );
}
