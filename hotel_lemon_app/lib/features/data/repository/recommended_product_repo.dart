import 'package:get/get.dart';
import '../../../../../utils/api_constant.dart';
import '../api/api_client.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  ///recommended product get method from server
  ///Similarly,we can make same method call for different dozens of new category with diffrenent end=Point;
  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMENDED_PRODUCT_URI);
  }
}
