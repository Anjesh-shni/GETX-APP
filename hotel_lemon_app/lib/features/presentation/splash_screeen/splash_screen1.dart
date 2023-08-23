import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../config/route/routes_helper.dart';
import '../../getx_controller/controller/cart_controller.dart';
import '../../getx_controller/controller/popular_product_controller.dart';
import '../../getx_controller/controller/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Future<void> _loadResources() async {
    Get.find<CartController>().getCartData();
    await Get.find<PopularProductController>().getPopulaProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 8),
        () => Get.offNamed(RouteHelper.getInitial()));
    _loadResources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/animation/abstract.json",
            width: double.infinity,
            height: 300,
            repeat: true,
          ),
        ],
      ),
    );
  }
}
