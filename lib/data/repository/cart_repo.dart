import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constants.dart';

// save order history
// get and save the data from the local storage, even if the application is closed
// repo always work with controller
class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];





  void addToCartList(List<CartModel> cartList) {
    /*sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    return;*/

    /*save the time when food add to cart*/
    var time = DateTime.now().toString();
    cart = [];
    /*
    * convert object to string because sharedpreferences only accepts string*/
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    /*
    * saved as list*/
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);

    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    // getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList " +carts.toString());
    }
    List<CartModel> cartList = [];

    carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }
  
  List<CartModel> getCartHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      // cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;

    }
    List<CartModel> cartListHistory=[];
    cartHistory.forEach((element) =>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    cart=[];

    // setelah di remove akan disimpan disini
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  // clear the cart history while user sign out
  void clearCartHistory() {
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }

  void removeCartSharedPreference() {
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
