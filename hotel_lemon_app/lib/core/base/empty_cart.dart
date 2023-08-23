import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:lottie/lottie.dart';

class EmptyCartPage extends StatefulWidget {
  const EmptyCartPage({Key? key}) : super(key: key);

  @override
  _EmptyCartPageState createState() => _EmptyCartPageState();
}

class _EmptyCartPageState extends State<EmptyCartPage>
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
      backgroundColor: Colors.green.shade100,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text(
      //     "Cart",
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 22,
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      //   elevation: 10,
      //   backgroundColor: Colors.green,
      // ),
      body: Stack(
        children: [
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
