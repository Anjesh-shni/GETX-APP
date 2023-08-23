import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../config/route/routes_helper.dart';
import '../../features/getx_controller/controller/cart_controller.dart';
import '../../features/getx_controller/controller/popular_product_controller.dart';
import '../../features/getx_controller/controller/recommended_product_controller.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.green,
    ));
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetBuilder<CartController>(
              builder: (_) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Hotel Lemon',
                  theme: ThemeData().copyWith(
                    scaffoldBackgroundColor: ApClrs.backGroundColor,
                  ),
                  initialRoute: RouteHelper.getSplashPage(),
                  getPages: RouteHelper.routes,
                );
              },
            );
          },
        );
      },
    );
  }
}
