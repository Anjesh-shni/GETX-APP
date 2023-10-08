import 'package:get/get.dart';
import '../../../utils/api_constant.dart';
import '../api/api_client.dart';

class PopularProductRepo extends GetxService {
  ///Popular product get method from server 
  ///Similarly,we can make same method call for different dozens of new category with diffrenent end=Point;
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
