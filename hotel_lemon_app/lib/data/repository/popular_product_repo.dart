import 'package:get/get.dart';
import 'package:lemon_hotel/data/api/api_client.dart';
import 'package:lemon_hotel/utils/app_constant.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
