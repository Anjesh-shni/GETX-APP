import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../../../config/route/routes_helper.dart';
import '../../../utils/api_constant.dart';
import '../../domain/model/main_model/popular_product_mooel.dart';
import '../../getx_controller/controller/popular_product_controller.dart';
import '../../getx_controller/controller/recommended_product_controller.dart';
import '../reusable_widget/bigtext.dart';
import '../reusable_widget/smalltext.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({
    Key? key,
  }) : super(key: key);

  @override
  State<FoodPageBody> createState() => FoodPageBodyState();
}

class FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 230;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // //pageview buildder
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isloaded
              ? Container(
                  height: 280,
                  child: PageView.builder(
                      // physics: BouncingScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, index) {
                        return _buildPageItem(
                            index, popularProducts.popularProductList[index]);
                      }),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
        }),

        //Dots indicator
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue.floor(),
            decorator: DotsDecorator(
              activeColor: Colors.green.shade400,
              size: const Size.square(10.0),
              activeSize: const Size(16.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          );
        }),

        const SizedBox(
          height: 15,
        ),

        // Recommended text
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "All"),
              const SizedBox(
                width: 5,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallTxt(
                  text: "Food Pairing",
                  size: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        // product ListView
        Container(
          height: 600,
          child: GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
              return recommendedProducts.isloaded
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          recommendedProducts.recommendedProductList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getRecommendedFood(
                                index, "home", index));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 10),
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                //image

                                Container(
                                  height: 100,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              recommendedProducts
                                                  .recommendedProductList[index]
                                                  .img!,
                                        ),
                                      ),
                                      color: Colors.green.shade200),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text: recommendedProducts
                                            .recommendedProductList[index]
                                            .name!,
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SmallTxt(
                                        text: "Explore to see more items!",
                                        color: Colors.black.withAlpha(100),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    Get.toNamed(RouteHelper.getRecommendedFood(
                                        index, "home", index));
                                  },
                                  icon: Icon(
                                    Icons.touch_app,
                                    color: Colors.black.withAlpha(50),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProducts) {
    Matrix4 matrix = Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getPopularFood(index, "home", index));
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        popularProducts.img!,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(left: 40, right: 40, bottom: 15),
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                      BoxShadow(
                        color: Colors.green.shade100,
                        offset: const Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.green.shade100,
                        offset: const Offset(5, 0),
                      ),
                    ],
                    color: Colors.green.shade100),
                child: Center(
                  child: BigText(
                    text: popularProducts.name!,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
