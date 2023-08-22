import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimen.height20 * 5,
        width: Dimen.height20 * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimen.height20 * 5 / 2),
          color: Colors.grey,
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );
  }
}
