// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hotel_lemon_app/utils/app_dimension.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;

  const ButtonWidget({
    Key? key,
    this.onPress,
    required this.buttonText,
    this.transparent = false,
    this.margin,
    this.height,
    this.width,
    this.fontSize,
    this.radius = 5,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
      backgroundColor: onPress == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : Theme.of(context).primaryColor,
      minimumSize: Size(width == null ? Dimen.screenwidth : width!,
          height != null ? height! : 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
    return Center(
      child: SizedBox(
        width: width != null ? width : Dimen.screenwidth,
        height: height ?? 50,
        child: TextButton(
          style: _flatButton,
          onPressed: onPress,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            icon != null
                ? Padding(
                    padding: EdgeInsets.only(right: Dimen.width10),
                    child: Icon(
                      icon,
                      color: transparent
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                    ),
                  )
                : const SizedBox(),
            Text(
              buttonText,
              style: TextStyle(
                  fontSize: fontSize != null ? fontSize : Dimen.font16,
                  color: transparent
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor),
            )
          ]),
        ),
      ),
    );
  }
}
