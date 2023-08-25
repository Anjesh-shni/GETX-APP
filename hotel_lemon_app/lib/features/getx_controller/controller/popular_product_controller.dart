import 'package:get/get.dart';
import 'package:hotel_lemon_app/utils/app_colors.dart';
import '../../data/repository/popular_product_repo.dart';
import '../../domain/model/main_model/cart_model.dart';
import '../../domain/model/main_model/popular_product_mooel.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isloaded = false;
  bool get isloaded => _isloaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItem = 0;
  int get inCartItem => _inCartItem + quantity;

  // Fetching Popular Product Data ok
  Future<void> getPopulaProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("Sucessfully Got popular product");

      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isloaded = true;

      update();
    } else {
      print("Something went wrong!!!");
    }
  }

  // Quantity increment / Decrement ok
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  // Quantitiy Check <0 or >20
  int checkQuantity(int quantity) {
    if ((_inCartItem + quantity) < 0) {
      Get.snackbar("You have 0 product", "You Can't reduce more!",
          backgroundColor: ApClrs.backGroundColor,
          colorText: ApClrs.textfontgreyColor,
          snackPosition: SnackPosition.TOP);
      // if (_inCartItem > 0) {
      //   _quantity = -_quantity;
      //   return quantity;
      // }
      if (_inCartItem > 0) {
        _quantity = -_inCartItem;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItem + quantity) > 20) {
      Get.snackbar(
        "You have 20 products in cart",
        "Please check out 20 item first",
        backgroundColor: ApClrs.backGroundColor,
        colorText: ApClrs.textfontgreyColor,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  // Different page cart quantity should not be altered ok
  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItem = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.isExistInCart(product);
    if (exist) {
      _inCartItem = _cart.getQuantity(product);
    }
  }

  //cart item from previous local ok
  void addItem(ProductModel product) {
    _cart.addItem(product, quantity);
    _quantity = 0;
    _inCartItem = _cart.getQuantity(product);

    update();
  }

  //For cart Badge ok
  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
