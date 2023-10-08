import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

import '../../config/route/routes_helper.dart';
import '../../utils/app_dimension.dart';
import '../../features/presentation/reusable_widget/app_icon.dart';
import '../../features/presentation/reusable_widget/bigtext.dart';

class EmptyCart extends StatefulWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  _EmptyCartState createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> with TickerProviderStateMixin {
  late AnimationController _coffeeController;
  bool isGreenCoffee = false;
  bool isTextReady = false;

  @override
  void initState() {
    super.initState();
    _coffeeController = AnimationController(vsync: this);
    _coffeeController.addListener(() {
      if (_coffeeController.value > 0.7) {
        isGreenCoffee = true;
        // setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          isTextReady = true;
          // setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    _coffeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.black,
                  backgound: Colors.green.shade200,
                  iconSize: Dimen.icon24 - 4,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              BigText(text: "Table No:- 2"),
              SizedBox(
                width: Dimen.width20,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: AppIcon(
                  icon: Icons.home_outlined,
                  iconColor: Colors.black,
                  backgound: Colors.green.shade200,
                  iconSize: Dimen.icon24 - 4,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.black,
                  backgound: Colors.green.shade200,
                  iconSize: Dimen.icon24 - 4,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: Dimen.width20,
            right: Dimen.width20,
            top: Dimen.height15 * 3 + 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.black,
                    backgound: Colors.green.shade200,
                    iconSize: Dimen.icon24 - 4,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                BigText(text: "Table No:- 2"),
                SizedBox(
                  width: Dimen.width20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.black,
                    backgound: Colors.green.shade200,
                    iconSize: Dimen.icon24 - 4,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.black,
                    backgound: Colors.green.shade200,
                    iconSize: Dimen.icon24 - 4,
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            height: isGreenCoffee ? (height / 1.45) : height,
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(isGreenCoffee ? 25.0 : 0.0),
                  bottomRight: Radius.circular(isGreenCoffee ? 25.0 : 0.0),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  // firstChild: Lottie.asset('assets/image/emptycart.json'),
                  child: Center(
                    child: Lottie.asset(
                      'images/emptycart.json',
                      controller: _coffeeController,
                      height: height / 3,
                      onLoaded: (composition) {
                        _coffeeController.duration = composition.duration;
                        _coffeeController.forward();
                      },
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
