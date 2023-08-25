import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/route/routes_helper.dart';
import '../../../utils/api_constant.dart';
import '../../../utils/app_dimension.dart';
import '../../getx_controller/controller/cart_controller.dart';
import '../../getx_controller/controller/popular_product_controller.dart';
import '../widget/app_column.dart';
import '../widget/app_icon.dart';
import '../widget/bigtext.dart';
import '../widget/expandble_text.dart';

class PopularFoodDetails extends StatelessWidget {
  final int index;
  final int pageId;
  final String page;
  const PopularFoodDetails({
    Key? key,
    required this.pageId,
    required this.page,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];

    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 340,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          //Icon
          Positioned(
            top: Dimen.height45 + 5,
            left: Dimen.width15,
            right: Dimen.width15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if (page == "cart-page") {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.black,
                      backgound: Colors.green.shade200,
                    )),
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            iconColor: Colors.black,
                            backgound: Colors.green.shade200,
                          ),
                          controller.totalItems >= 1
                              ? const Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    iconColor: Colors.transparent,
                                    size: 20,
                                    backgound: Colors.white,
                                  ),
                                )
                              : Container(),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 0,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    color: Colors.red,
                                    size: 18,
                                  ))
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Name & description
          Positioned(
            top: 310 - 20,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(
                      height: Dimen.height20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimen.height20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandbleText(text: product.description!),
                      ),
                    ),
                  ],
                )
                // ListView.builder(
                //   itemCount: Product.products.length,
                //   itemBuilder: (context, index) {
                //     return Container();
                //     //  ProduListCrad(products: Product.products[index]);
                //   },
                // ),
                ),
          ),
        ],
      ),

      // Bottom Nav
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProducts) {
        return Container(
          height: 95,
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)],
              color: Colors.green.shade200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 0, left: 15),
                padding: EdgeInsets.only(
                    top: Dimen.height20,
                    bottom: Dimen.height20,
                    left: Dimen.width20,
                    right: Dimen.width20),
                height: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.shade100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          popularProducts.setQuantity(false);
                        },
                        child: const Icon(Icons.remove)),
                    const SizedBox(
                      width: 10,
                    ),
                    BigText(text: popularProducts.inCartItem.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          popularProducts.setQuantity(true);
                        },
                        child: const Icon(Icons.add)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  popularProducts.addItem(product);
                
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 0, right: 15),
                  padding: EdgeInsets.only(
                      top: Dimen.height20,
                      bottom: Dimen.height20,
                      left: Dimen.width20,
                      right: Dimen.width20),
                  height: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green.shade100),
                  child: Row(
                    children: [
                      BigText(
                        text: "रु ${product.price!} || Add to cart",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
