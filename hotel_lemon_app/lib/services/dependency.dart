import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/data/api/api_client.dart';
import '../features/data/repository/auth_repo.dart';
import '../features/data/repository/cart_repo.dart';
import '../features/data/repository/popular_product_repo.dart';
import '../features/data/repository/recommended_product_repo.dart';
import '../features/data/repository/user_repo.dart';
import '../features/getx_controller/controller/auth_controller.dart';
import '../features/getx_controller/controller/cart_controller.dart';
import '../features/getx_controller/controller/popular_product_controller.dart';
import '../features/getx_controller/controller/recommended_product_controller.dart';
import '../features/getx_controller/controller/user_controller.dart';
import '../utils/api_constant.dart';

Future<void> init() async {
  // //shredPrefrences
  final sharedPrefrences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPrefrences);

  // //api clienet
  Get.lazyPut(
    () => ApiClient(
        appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()),
  );

  // //Auth reepo
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  //Login
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  // //for repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  // //for controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));

  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
