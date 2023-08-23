import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCartPage extends StatefulWidget {
  const EmptyCartPage({Key? key}) : super(key: key);

  @override
  EmptyCartPageState createState() => EmptyCartPageState();
}

class EmptyCartPageState extends State<EmptyCartPage>
    with TickerProviderStateMixin {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            // firstChild: Lottie.asset('assets/image/emptycart.json'),
            duration: const Duration(seconds: 4),
            child: Center(
              child: Lottie.asset(
                'assets/animation/empty_cart.json',
                controller: _coffeeController,
                height: height / 2,
                onLoaded: (composition) {
                  _coffeeController.duration = composition.duration;
                  _coffeeController.forward();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
