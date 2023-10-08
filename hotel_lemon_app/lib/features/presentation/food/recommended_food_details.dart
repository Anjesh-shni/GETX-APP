import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_lemon_app/utils/api_constant.dart';
import '../../../config/route/routes_helper.dart';
import '../../../utils/app_dimension.dart';
import '../../getx_controller/controller/cart_controller.dart';
import '../../getx_controller/controller/popular_product_controller.dart';
import '../../getx_controller/controller/recommended_product_controller.dart';
import '../reusable_widget/app_column.dart';
import '../reusable_widget/app_icon.dart';
import '../reusable_widget/bigtext.dart';
import '../reusable_widget/expandble_text.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int index;
  final int pageId;
  final String page;
  const RecommendedFoodDetails({
    Key? key,
    required this.pageId,
    required this.page,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          //AppBar
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 65,
            //Icons
            title: Row(
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
                    icon: Icons.clear,
                    iconColor: Colors.black,
                    backgound: Colors.green.shade200,
                  ),
                ),
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
                                    text: controller.totalItems.toString(),
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

            //Welcome text
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 5, left: 20),
                height: 40,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey)],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white),
                child: BigText(
                  text: "Welcome",
                  size: 25,
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.green,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              //Images

              background: CachedNetworkImage(
                imageUrl: AppConstants.BASE_URL +
                    AppConstants.UPLOAD_URL +
                    product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Expandbale text and Icons
          SliverToBoxAdapter(
            child: Container(
                height: 500,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                decoration: const BoxDecoration(
                  boxShadow: [],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(
                      height: Dimen.height20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimen.height10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandbleText(text: product.description!),
                        //  ExpandbleText(text: product.description!),
                      ),
                    ),
                  ],
                )),
          ),
          // Container(
          //   // margin: EdgeInsets.only(top: 0),
          //   decoration: BoxDecoration(
          //       color: Colors.green.shade100,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(10),
          //         topRight: Radius.circular(10),
          //       )),
          //   height: 1000,
          //   child: ListView.builder(
          //       itemCount: Product.products.length,
          //       itemBuilder: (context, index) {
          //         return Container();
          //         // ProduListCrad(products: Product.products[index]);
          //       }),
          // ),
          // Container(
          //   color: Colors.green.shade100,
          //   margin: EdgeInsets.only(left: 10, top: 10),
          //   child: Text(
          //       "By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engagingBy leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engagingBy leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engagingBy leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engagingBy leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engagingBy leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engagingBy leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.”“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging.“By leveraging Lottie animations, we can provide a dynamic experience and make it much more fun by showcasing an animation that is much richer and engaging."),
          // ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Container(
            height: 95,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.grey, blurRadius: 10)
                ],
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green.shade100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.setQuantity(false);
                          },
                          child: const Icon(Icons.remove)),
                      const SizedBox(
                        width: 10,
                      ),
                      BigText(text: controller.inCartItem.toString()),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.setQuantity(true);
                          },
                          child: const Icon(Icons.add)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.addItem(product);
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
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.shade100),
                    child: Row(
                      children: [
                        BigText(text: "रु ${product.price!} || Add to cart"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
