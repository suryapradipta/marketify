import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

// repo is to get data
class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  // _ underscore in variable means private
  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;

  // late means, we have to initialize before use it
  late CartController _cart;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  // shopping cart
  int _quantity = 0;

  int get quantity => _quantity;
  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  // get product list from the server
  Future<void> getPopularProductList(bool reload) async {
    if (_popularProductList == null || reload) {
      // await needed because 'Future'
      Response response = await popularProductRepo.getPopularProductList();
      if (response.statusCode == 200) {
        // print("got products");
        _popularProductList = [];
        _popularProductList.addAll(Product.fromJson(response.body).products);
        // print(_popularProductList);
        _isLoaded = true;
        update();
      } else {}
    }
  }

  //=================REUSABLE
  // shopping product controller
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      // print("number of items: " +_quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print("decrement" + _quantity.toString());
    }
    // tell ui there are new value
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      // Get.snakbar untuk manampilkan notification message
      Get.snackbar(
        "Item Count!",
        "You can't reduce more.",
        icon: const Icon(Icons.warning, color: Colors.white),
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Item Count!",
        "You can't add more than 20.",
        icon: const Icon(Icons.warning, color: Colors.white),
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        return 0;
      }
      return 20;
    } else {
      return quantity;
    }
  }

  // ketika food dibuka set quantity jadi 0
  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;

    // to know if there is an item in cart
    var exist = false;
    exist = _cart.existInCart(product);

    // if exist
    // get from storage _inCartItems=3

    // print("exist or not: " + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    // print("the quantity in the cart: "+_inCartItems.toString() );
  }

  void addItem(ProductModel product) {
    // add quantity
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("the id is: " +
          value.id.toString() +
          " the quantity: " +
          value.quantity.toString());
    });

    // once update in crontroller, but ui doesnt udpated, must be use this function
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

//=================REUSABLE
  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
