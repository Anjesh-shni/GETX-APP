import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../widget/bigtext.dart';
import '../../widget/smalltext.dart';
import 'food_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<AnimatedTextExample> _examples;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _examples = animatedTextExamples(onTap: () {
      setState(() {});
    });
  }

  Future<void> _loadResources() async {
    Get.find<CartController>().getCartData();
    await Get.find<PopularProductController>().getPopulaProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    final animatedTextExample = _examples[_index];
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadResources();
        },
        child: Column(
          children: [
            Container(
              color: Colors.green,
              child: Container(
                margin: const EdgeInsets.only(top: 45, bottom: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          key: ValueKey(animatedTextExample),
                          child: animatedTextExample.child,
                        ),
                        Row(
                          children: [
                            SmallTxt(
                              text: "Inaruwa",
                              size: 14,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                    // BigText(text: "Table No: ${widget.initial}"),/
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.shade100),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search_outlined,
                          color: Colors.black.withAlpha(150),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //category text
            Container(
              height: 30,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.green.shade200,
              ),
              child: Center(
                child: BigText(
                  text: 'List of Category',
                  size: 18,
                  color: Colors.blueGrey,
                ),
              ),
            ),

            //Main food page
            const Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: FoodPageBody(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedTextExample {
  final Color? color;
  final Widget child;

  const AnimatedTextExample({
    required this.color,
    required this.child,
  });
}

// Colorize Text Style
const _colorizeTextStyle = TextStyle(
  fontSize: 22,
  fontFamily: 'Horizon',
  fontWeight: FontWeight.bold,
);

// Colorize Colors
const _colorizeColors = [
  Colors.amber,
  Colors.purple,
  Colors.white,
  Colors.yellow,
  Colors.red,
];

List<AnimatedTextExample> animatedTextExamples({VoidCallback? onTap}) =>
    <AnimatedTextExample>[
      AnimatedTextExample(
        color: Colors.blueGrey[50],
        child: AnimatedTextKit(
          totalRepeatCount: 1000000000000000,
          animatedTexts: [
            ColorizeAnimatedText(
              'Hotel Lemon',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
            ColorizeAnimatedText(
              'Hotel Lemon',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
            ColorizeAnimatedText(
              'Hotel Lemon',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
          ],
        ),
      ),
    ];
