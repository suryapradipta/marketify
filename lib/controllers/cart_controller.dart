import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';
import '../utils/colors.dart';

// controller must be loadded on dependencies
// when add to cart is clicked, it will save the data
class CartController extends GetxController {
  final CartRepo cartRepo;

  /*constructor*/
  CartController({required this.cartRepo});

  // eveything stored here
  // stored the item while application is running
  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  /*only for storage and sharedpreferences*/
  List<CartModel> storageItems = [];








  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    //check if already contain value
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        //
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
            "Item Count", "You should at least add an item in the cart!",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }

    // update and add cart repo list
    cartRepo.addToCartList(getItems);
    update();
  }

  // check if there is an item in the cart
  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    // id contains or not
    if (_items.containsKey(product.id)) {
      // loop the id
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  // make a list of cart items
  // return all item as a lsit
  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });

    return total;
  }

  // only get cart when we start the app
  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    // put in the storage
    storageItems = items;

    // print("Length of cart items "+storageItems.length.toString());

    // update
    for(int i=0; i <storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items={};
    // supaya tau ada perubahan pada ui
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    // empty the items
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    // update and add cart repo list
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }
}
