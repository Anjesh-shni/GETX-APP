import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repository/cart_repo.dart';
import '../../domain/model/main_model/cart_model.dart';
import '../../domain/model/main_model/popular_product_mooel.dart';
import '../../../utils/app_colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  // cart storage data
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  //For Local Storage
  List<CartModel> storageItems = [];

  // Add item without duplicating check ok............................................
  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(
        product.id!,
        (value) {
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
        },
      );
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
          "Product count",
          "You should have add atleast one item in the cart!",
          backgroundColor: ApClrs.mainClr,
          colorText: Colors.black,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
    cartRepo.addToCartlist(getItems);
    update();
  }

  //page exist or not in cart item ok................................................
  bool isExistInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  //getting quantity ok..............................................................
  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  //To show badge in cart ok.......................................................
  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  //For Cart Page Iterate ok.........................................................
  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  //Total Amount for Cart Page ok..................................................
  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  //Local Storage of Cart Data ok...................................................
  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  // setter for all cart model ok....................................................
  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      // print("length of cart item is....." + storageItems.length.toString());
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  //on TAP CHECKOut BUTTON............................................................
  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  //TO REMOVE Cart List OK...........................................................
  void clear() {
    _items = {};
    update();
  }

  //For Cart History ok.............................................................
  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  // Setter function means,  it must Accept something..............................
  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  //ok .............................................................................
  void addToCartList() {
    cartRepo.addToCartlist(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }
}
