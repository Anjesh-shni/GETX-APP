import 'package:get/get.dart';
import '../../../utils/api_constant.dart';
import '../api/api_client.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    //Getting user information
    return await apiClient.getData(AppConstants.USER_INFO);
  }
}
