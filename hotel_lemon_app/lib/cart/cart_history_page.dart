import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../base/empty_cart.dart';
import '../controller/cart_controller.dart';
import '../model/main_model/cart_model.dart';
import '../route/routes_helper.dart';
import '../utils/app_constant.dart';
import '../utils/colors.dart';
import '../utils/dimension.dart';
import '../widget/app_icon.dart';
import '../widget/bigtext.dart';
import '../widget/smalltext.dart';


class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOderList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> orderTimes = cartItemsPerOderList();
    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());

        var outPutFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outPutFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Column(
        children: [
          //App Bar
          Container(
            color: Colors.green,
            height: Dimen.height20 * 5,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimen.height30, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  text: "Your Cart History",
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getCartPage());
                  },
                  child: AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.black,
                    backgound: Colors.green.shade200,
                  ),
                ),
              ],
            ),
          ),

          //
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Dimen.height20,
                          left: Dimen.width10,
                          right: Dimen.width10),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < orderTimes.length; i++)
                              Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  dismissible: DismissiblePane(onDismissed: () {
                                    _cartController.clear();
                                    _cartController.clearCartHistory();
                                  }),
                                  children: const [
                                    SlidableAction(
                                      // An action can be bigger than the others.

                                      onPressed: doNothing,
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.brown,
                                      width: 1,
                                    ),
                                  ),
                                  height: Dimen.height40 * 3,
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      left: Dimen.width5, right: Dimen.width10),
                                  margin: EdgeInsets.only(
                                    bottom: Dimen.height20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      timeWidget(listCounter),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.brown,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                                orderTimes[i], (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          right: Dimen.width10 /
                                                              2),
                                                      height:
                                                          Dimen.height20 * 4,
                                                      width: Dimen.height20 * 4,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          Dimen.radius15 / 2,
                                                        ),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(AppConstants
                                                                  .BASE_URL +
                                                              AppConstants
                                                                  .UPLOAD_URL +
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!),
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            }),
                                          ),
                                          Container(
                                            height: Dimen.height20 * 4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallTxt(
                                                  text: "Total",
                                                  color: ApClrs.titleClr,
                                                  size: 15,
                                                ),
                                                BigText(
                                                  text:
                                                      "${orderTimes[i]} Items",
                                                  color: ApClrs.titleClr,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeToList();
                                                    Map<int, CartModel>
                                                        moreOrder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        moreOrder.putIfAbsent(
                                                            getCartHistoryList[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;

                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimen.width10,
                                                            vertical:
                                                                Dimen.height10 /
                                                                    2),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimen.radius15 /
                                                                  2),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.blue),
                                                    ),
                                                    child: SmallTxt(
                                                      text: "See more",
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.6,
                    child: const Center(
                      child: EmptyCartPage(),
                    ),
                  );
          })
        ],
      ),
    );
  }
}

void doNothing(BuildContext context) {}
