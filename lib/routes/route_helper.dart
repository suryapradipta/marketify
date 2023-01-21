import 'package:marketify/pages/auth/sign_in_page.dart';
import 'package:marketify/pages/food/popular_food_detail.dart';
import 'package:marketify/pages/food/recommended_food_detail.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/home/home_page.dart';
import '../pages/home/main_food_page.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";

  static String getSplashPage() => '$splashPage';

  static String getInitial() => '$initial';

  // return $popularFood variable, refer to above
  // if want to put variable inside the string, use $ sign
  // ?pageId is key and $pageId is value
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';

  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';

  static String getCartPage() => '$cartPage';

  static String getSignInPage() => '$signIn';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: signIn, page: () => SignInPage(),
    transition: Transition.fade
    ),
    GetPage(
        name: popularFood,
        page: () {
          // catch the variable using Get.parameters, take list string
          var pageId = Get.parameters['pageId'];

          var page = Get.parameters["page"];

          // return or send to the screen/ ui
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];

          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
  ];
}
