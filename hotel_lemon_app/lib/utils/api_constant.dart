class AppConstants {
  const AppConstants._();
  //App Name
  static const String APP_NAME = "Nvida";
  static const int APP_VERSION = 1;
  //API End point
  // static const String BASE_URL = "http://127.0.0.1:8000";
  static const String BASE_URL = "http://192.168.101.5:8000";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String BIRYANI = "/api/v1/products/biryani";
  //Authentication End point
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO = "/api/v1/customer/info";

  //Address
  static const String GEO_CODE_URI = "/api/v1/config/geocode-api";
  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDED_USER_LIST = "/api/v1/customer/address/list";
  //Constant
  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String UPLOAD_URL = "/uploads/";
  static const String CART_LIST = "Cart-List";
  static const String CART_HISTORY_LIST = "cart-history";
}
