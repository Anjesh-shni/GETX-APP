import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../model/main_model/table_model.dart';
import 'bottom_nav_home.dart';


class TablePAge extends StatefulWidget {
  const TablePAge({
    Key? key,
  }) : super(key: key);

  @override
  _TablePAgeState createState() => _TablePAgeState();
}

class _TablePAgeState extends State<TablePAge> {
  late List<AnimatedTextExample> _examples;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _examples = animatedTextExamples(onTap: () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final animatedTextExample = _examples[_index];
    double h = MediaQuery.of(context).size.height - 77;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Align(
          alignment: Alignment.bottomLeft,
          key: ValueKey(animatedTextExample),
          child: animatedTextExample.child,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 30,
              width: double.infinity,
              color: Colors.green.shade300,
              child: Center(
                child: Text(
                  "List of table",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              color: Colors.green.shade100,
              height: h - 110,
              child: GridView.builder(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 5,
                    top: 10,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1),
                  itemCount: Tableid.tablee.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeNav(
                              initial: Tableid.tablee[index].id,
                            ),
                          ),
                        );
                        // Get.to(CartPage(inddex: Tableid.tablee[index].id));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        margin: const EdgeInsets.only(bottom: 10, right: 10, left: 5),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5.0,
                              offset: Offset(0, 5),
                            ),
                            BoxShadow(
                              color: Colors.green,
                              offset: Offset(-5, 0),
                            ),
                            BoxShadow(
                              color: Colors.green,
                              offset: Offset(5, 0),
                            ),
                          ],
                          borderRadius: BorderRadiusDirectional.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Table No: ${Tableid.tablee[index].id}",
                            style: const TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
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
