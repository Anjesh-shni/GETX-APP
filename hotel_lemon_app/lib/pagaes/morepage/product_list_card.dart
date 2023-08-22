import 'package:flutter/material.dart';

import '../../model/product_model.dart';
import '../../widget/bigtext.dart';


class ProduListCrad extends StatelessWidget {
  final Product products;

  const ProduListCrad({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  products.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${products.price.toString()}€",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: 10,
            ),
            margin: EdgeInsets.only(right: 10),
            height: 35,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        const snackBar = SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.amber,
                          content: Text(
                            "Product removed",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 4, right: 0),
                  child: BigText(
                    text: "0",
                    size: 18,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      const snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.amber,
                        content: Text(
                          "Product Added",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
