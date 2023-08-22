import 'package:get/get.dart';
import 'package:lemon_hotel/data/api/api_client.dart';
import 'package:lemon_hotel/utils/app_constant.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO);
  }
}
