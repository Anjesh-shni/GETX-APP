import 'package:get/get.dart';
import 'package:hotel_lemon_app/features/presentation/address/add_address_page.dart';
import 'package:hotel_lemon_app/features/presentation/home/homepage.dart';
import 'package:hotel_lemon_app/features/presentation/auth/sign_up_page.dart';
import '../../features/presentation/cart_page/cart_page.dart';
import '../../features/presentation/food/popular_food_details.dart';
import '../../features/presentation/food/recommended_food_details.dart';
import '../../features/presentation/auth/sign_in_page.dart';
import '../../app/home/home_navigation.dart';
import '../../features/presentation/splash_screeen/splash_screen1.dart';

class RouteHelper {
  ///Route constant
  static const String inittial = "/";
  static const String tablePage = "/table-page";
  static const String splashPage = "/splash-page";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String homePage = "/home-page";
  static const String address = "/address";

  ///Route constant refrences
  static String getInitial() => inittial;
  static String getTablePage() => tablePage;
  static String getSplashPage() => splashPage;
  static String getPopularFood(int pageId, String page, int index) =>
      "$popularFood?pageId=$pageId&page=$page&index=$index";

  static String getRecommendedFood(int pageId, String page, int index) =>
      "$recommendedFood?pageId=$pageId&page=$page&index=$index";

  static String getCartPage() => cartPage;
  static String getSignIn() => signIn;
  static String getSignUp() => signUp;
  static String getHomePage() => homePage;
  static String getAddressPage() => address;

  ///All the route list
  static List<GetPage> routes = [
    GetPage(
      name: inittial,
      page: () => const HomeNav(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signIn,
      page: () => const SignInPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signUp,
      page: () => const SignUpPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: homePage,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: splashPage,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters["pageId"];
        var index = Get.parameters["index"];
        final page = Get.parameters["page"];
        return PopularFoodDetails(
            pageId: int.parse(pageId!), index: int.parse(index!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters["pageId"];
        final page = Get.parameters["page"];
        var index = Get.parameters["index"];
        return RecommendedFoodDetails(
            pageId: int.parse(pageId!), index: int.parse(index!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return const CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: address,
      page: () {
        return const AddAddressPage();
      },
      transition: Transition.fadeIn,
    ),
  ];
}
