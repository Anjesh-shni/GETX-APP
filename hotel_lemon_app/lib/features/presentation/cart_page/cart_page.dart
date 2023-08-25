import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route/routes_helper.dart';
import '../../../core/base/no_data_page.dart';
import '../../getx_controller/controller/cart_controller.dart';
import '../../getx_controller/controller/popular_product_controller.dart';
import '../../getx_controller/controller/recommended_product_controller.dart';
import '../widget/app_icon.dart';
import '../widget/bigtext.dart';
import '../widget/smalltext.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/api_constant.dart';
import '../../../utils/app_dimension.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //For Icons
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
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: Dimen.width30,
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

          //Product details
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getItems.isNotEmpty
                ? Positioned(
                    top: Dimen.height15 * 6,
                    left: 5,
                    right: 5,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimen.height15),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (cartController) {
                            var cartList = cartController.getItems;
                            return ListView.builder(
                              itemCount: cartList.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.green.shade200),
                                  height: Dimen.height20 * 5,
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex = Get.find<
                                                  PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                                  cartList[index].product!);

                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                              RouteHelper.getPopularFood(
                                                  popularIndex,
                                                  "cart-page",
                                                  index),
                                            );
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(
                                                    cartList[index].product!);

                                            if (recommendedIndex < 0) {
                                              Get.snackbar(
                                                "History Product",
                                                "This history product review is not available",
                                                backgroundColor:
                                                    ApClrs.backGroundColor,
                                                colorText:
                                                    ApClrs.textfontgreyColor,
                                              );
                                            } else {
                                              Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                    recommendedIndex,
                                                    "cart-page",
                                                    index),
                                              );
                                            }
                                          }
                                        },

                                        //Image section
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            bottom: Dimen.height5,
                                            left: Dimen.width5,
                                            top: Dimen.height5,
                                          ),
                                          height: Dimen.height20 * 5,
                                          width: Dimen.height20 * 5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimen.radius20),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD_URL +
                                                      cartController
                                                          .getItems[index]
                                                          .img!),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimen.width10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          // color: Colors.grey,
                                          height: Dimen.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: BigText(
                                                  text: cartController
                                                      .getItems[index].name!,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                              ),
                                              SmallTxt(text: "spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text:
                                                        "रु ${cartController.getItems[index].price.toString()}",
                                                    color: Colors.black,
                                                    size: 16,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: Dimen.height10,
                                                        bottom: Dimen.height10,
                                                        left: Dimen.width10,
                                                        right: Dimen.width10),
                                                    decoration: BoxDecoration(
                                                      // color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimen.radius20),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color:
                                                                ApClrs.signClr,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimen.width10,
                                                        ),
                                                        BigText(
                                                            text: cartList[
                                                                    index]
                                                                .quantity
                                                                .toString()),
                                                        SizedBox(
                                                          width: Dimen.width10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color:
                                                                ApClrs.signClr,
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
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: NoDataPAge(
                      text: 'Your cart is empty',
                    ),
                  );
          })
        ],
      ),

      //Bottom Nav
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: Dimen.bottomNav,
            padding: EdgeInsets.only(
                top: Dimen.height30,
                bottom: Dimen.height30,
                right: Dimen.width20,
                left: Dimen.width20),
            decoration: BoxDecoration(
                color: ApClrs.backGroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimen.radius20 * 2),
                  topRight: Radius.circular(Dimen.radius20 * 2),
                ),
                boxShadow: [
                  BoxShadow(
                      color: cartController.getItems.isNotEmpty
                          ? Colors.grey
                          : ApClrs.backGroundColor,
                      blurRadius: 10)
                ]),
            child: cartController.getItems.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 0),
                        padding: EdgeInsets.only(
                            top: Dimen.height20,
                            bottom: Dimen.height20,
                            left: Dimen.width20,
                            right: Dimen.width20),
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          borderRadius: BorderRadius.circular(Dimen.radius15),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimen.width5,
                            ),
                            BigText(
                              text: "रु ${cartController.totalAmount}",
                            ),
                            SizedBox(
                              width: Dimen.width5,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (cartController.getItems.length > 0) {
                            cartController.addToHistory();
                            Get.snackbar(
                              "Saved",
                              "Your order has been saved to cart history",
                              backgroundColor: ApClrs.bodyColor,
                              colorText: ApClrs.textfontgreyColor,
                              snackPosition: SnackPosition.TOP,
                            );
                          } else {}
                          // if (cartController.getItems.isNotEmpty) {
                          //   Get.to(const PrintCheckout());
                          // } else {}
                          // cartController.addToHistory();
                          // Get.to(PrintCheckout());

                          // if (Get.find<AuthController>().userLoggedIn()) {
                          //   cartController.addToHistory();
                          // } else {
                          //   Get.toNamed(RouteHelper.getSignIn());
                          // }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 0),
                          padding: EdgeInsets.only(
                              top: Dimen.height20,
                              bottom: Dimen.height20,
                              left: Dimen.width20,
                              right: Dimen.width20),
                          decoration: BoxDecoration(
                            color: Colors.green.shade200,
                            borderRadius: BorderRadius.circular(Dimen.radius15),
                          ),
                          child: BigText(
                            text: "Checkout",
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
