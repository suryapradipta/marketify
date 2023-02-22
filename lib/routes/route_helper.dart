import 'package:marketify/pages/account/account_page.dart';
import 'package:marketify/pages/auth/sign_in_page.dart';
import 'package:marketify/pages/cart/cart_history.dart';
import 'package:marketify/pages/chat/chat_page.dart';
import 'package:marketify/pages/food/popular_food_detail.dart';
import 'package:marketify/pages/food/recommended_food_detail.dart';
import 'package:get/get.dart';
import 'package:marketify/pages/payment/payment_page.dart';

import '../models/order_model.dart';
import '../pages/address/add_address_page.dart';
import '../pages/address/pick_address_map.dart';
import '../pages/cart/cart_page.dart';
import '../pages/home/home_page.dart';
import '../pages/home/main_food_page.dart';
import '../pages/payment/order_success_page.dart';
import '../pages/search/seach_product_page.dart';
import '../pages/splash/splash_page.dart';
import '../start/welcome_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String welcomePage = "/welcome-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-successful";
  static const String search = '/search';
  static const String chat = '/chat';
  static const String account = '/account';
  static const String cartHistory = '/cart-history';

  static String getSearchRoute() => '$search';

  static String getAccountPage() => '$account';

  static String getCartHistory() => '$cartHistory';

  static String getSplashPage() => '$splashPage';

  static String getWelcomePage() => '$welcomePage';

  static String getInitial() => '$initial';

  // return $popularFood variable, refer to above
  // if want to put variable inside the string, use $ sign
  // ?pageId is key and $pageId is value
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';

  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';

  static String getCartPage(int pageId, String page) =>
      '$cartPage?id=$pageId&page=$page';

  static String getSignInPage() => '$signIn';

  static String getAddressPage() => '$addAddress';

  static String getChatPage() => '$chat';

  static String getPickAddressPage() => '$pickAddressMap';

  static String getPaymentPage(String id, int userID) =>
      '$payment?id=$id&userID=$userID';

  static String getOrderSuccessPage(String orderID, String status) =>
      '$orderSuccess?id=$orderID&status=$status';

  static List<GetPage> routes = [
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddress = Get.arguments;
          return _pickAddress;
        }),
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: welcomePage, page: () => WelcomePage()),
    GetPage(name: account, page: () => AccountPage()),
    GetPage(name: cartHistory, page: () => CartHistory()),


    GetPage(
        name: initial, page: () => HomePage(), transition: Transition.fadeIn),
    GetPage(
        name: signIn, page: () => SignInPage(), transition: Transition.fade),
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
          return CartPage(
              pageId: int.parse(Get.parameters['id']!),
              page: Get.parameters['page']!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        }),
    GetPage(
        name: chat,
        page: () {
          return ChatPage();
        }),
    GetPage(
        name: payment,
        page: () => PaymentPage(
                orderModel: OrderModel(
              id: int.parse(Get.parameters['id']!),
              userId: int.parse(Get.parameters['userID']!),
            ))),
    GetPage(
        name: orderSuccess,
        page: () => OrderSuccessPage(
              orderID: Get.parameters['id']!,
              status: Get.parameters["status"].toString().contains("success")
                  ? 1
                  : 0,
            )),
    GetPage(name: search, page: () => SearchScreen()),
  ];
}
