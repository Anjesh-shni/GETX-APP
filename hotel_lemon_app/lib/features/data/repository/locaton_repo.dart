import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_lemon_app/features/data/api/api_client.dart';
import 'package:hotel_lemon_app/features/domain/model/location_model/location_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/api_constant.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressFromGeoCode(LatLng latLng) async {
    print("i get calllled");
    return await apiClient.getData('${AppConstants.GEO_CODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? "";
  }

  Future<Response> addUserAddress(AddressModel addressModel) async {
    return apiClient.post(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddressList() async {
    return await apiClient.getData(AppConstants.ADDED_USER_LIST);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(
        AppConstants.ADD_USER_ADDRESS, userAddress);
  }
}
