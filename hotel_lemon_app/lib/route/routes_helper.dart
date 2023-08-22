import 'package:get/get.dart';
import 'package:hotel_lemon_app/pagaes/home/homepage.dart';
import 'package:hotel_lemon_app/pagaes/morepage/auth/signup_page.dart';

import '../cart/cart_page.dart';
import '../model/main_model/table_model.dart';
import '../pagaes/food/popular_food_details.dart';
import '../pagaes/food/recommended_food_details.dart';
import '../pagaes/morepage/auth/sign_in_page.dart';
import '../pagaes/morepage/bottom_nav_home.dart';
import '../pagaes/morepage/splash_screen1.dart';
import '../pagaes/morepage/table_page.dart';


class RouteHelper {
  //This is for Routing.........................................................
  static const String inittial = "/";
  static const String tablePage = "/table-page";
  static const String splashPage = "/splash-page";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String homePage = "/home-page";
  

  //This is because we can pass parameter or argument in any page...............
  static String getInitial() => "$inittial";
  static String getTablePage() => "$tablePage";
  static String getSplashPage() => "$splashPage";
  static String getPopularFood(int pageId, String page, int index) =>
      "$popularFood?pageId=$pageId&page=$page&index=$index";

  static String getRecommendedFood(int pageId, String page, int index) =>
      "$recommendedFood?pageId=$pageId&page=$page&index=$index";

  static String getCartPage() => '$cartPage';
  static String getSignIn() => '$signIn';
  static String getSignUp() => '$signUp';
  static String getHomePage() => '$homePage';

  //This is list of Routes......................................................
  static List<GetPage> routes = [
    GetPage(
      name: inittial,
      page: () => HomeNav(
        initial: Tableid.tablee.length,
      ),
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
      name: tablePage,
      page: () {
        return const TablePAge();
      },
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
        return CartPage(inddex: Tableid.tablee.length,);
      },
      transition: Transition.fadeIn,
    ),
  ];
}
