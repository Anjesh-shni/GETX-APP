import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_lemon_app/features/data/repository/locaton_repo.dart';
import 'package:hotel_lemon_app/features/domain/model/location_model/location_address_model.dart';
import 'package:hotel_lemon_app/features/domain/model/main_model/response_model.dart';
import '../../../core/exception/show_custom_msg.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickplacemark = Placemark();

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  //
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;
  //
  final List<String> _addressTypeList = ["Home", "Office", "Others"];
  List<String> get addressTypeList => _addressTypeList;
  //
  int _selectedAddressTypeIndex = 0;
  int get selectedAddresstypeIndex => _selectedAddressTypeIndex;
  //
  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  //
  bool _updatedPositionData = true;
  final bool _changeAddress = true;

  //getter
  bool get loading => _loading;
  Position get position => _position;
  Position get pickUpPositon => _pickPosition;
  Placemark get placemark => _placemark;
  Placemark get pickplacemark => _pickplacemark;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

//
  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updatedPositionData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          print("if coming from address page.......................1");
          _position = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        } else {
          print("if coming from cart page.......................2");
          _pickPosition = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        }

        if (_changeAddress) {
          print(
              "Updating new address::::Changing address.......................3");
          //talking to the erver from here
          String _address = await getAddressFromGeoCode(LatLng(
            position.target.latitude,
            position.target.longitude,
          ));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickplacemark = Placemark(name: _address);
        }
      } catch (e) {
        showCuastomSnackBAr("something went wrong $e");
      }
      _loading = false;
      update();
    } else {
      _updatedPositionData = true;
    }
  }

  //new address getting
  Future<String> getAddressFromGeoCode(LatLng latlang) async {
    String _address = "Unknown location";
    Response response = await locationRepo.getAddressFromGeoCode(latlang);
    if (response.body["status"] == "OK") {
      _address = response.body["results"][0]["formatted_address"].toString();
      print("my address:::::::::::::::::::" + _address);
    } else {
      showCuastomSnackBAr("Error getting google location api");
    }
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  //
  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
      print("Get User Address ${_addressModel.address}");
    } catch (e) {
      showCuastomSnackBAr(e.toString());
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _selectedAddressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addUserAddress(AddressModel addressModel) async {
    print("Add userAddress method get called   2nd.........");
    _loading = true;
    update();
    Response response = await locationRepo.addUserAddress(addressModel);
    print("Cheking response ......${response.body.toString()}");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("im save user addree...........3");
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      //Save userAddressMethod
      // print(" saving userAddress in storage" + message);
      await saveUserAddress(addressModel);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    //this the get request where we get all the data from server

    Response response = await locationRepo.getAllAddressList();
    if (response.statusCode == 200) {
      print(
          "User address from locationController getAddresslist method:::::::::::" +
              response.body);
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
        print("Get addressList method called    ........4" +
            addressList.toString());
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    print("im saving user addreess to local storage.............5");
    String savedUserAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(savedUserAddress);
  }

  void clearUserAddress() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  //Get user address from local storage
  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickplacemark;
    _updatedPositionData = false;
    update();
  }
}
