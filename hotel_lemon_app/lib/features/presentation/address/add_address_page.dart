import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_lemon_app/config/route/routes_helper.dart';
import 'package:hotel_lemon_app/core/exception/show_custom_msg.dart';
import 'package:hotel_lemon_app/features/domain/model/location_model/location_address_model.dart';
import 'package:hotel_lemon_app/features/getx_controller/controller/auth_controller.dart';
import 'package:hotel_lemon_app/features/getx_controller/controller/user_controller.dart';
import 'package:hotel_lemon_app/features/getx_controller/map_controller/location_controller.dart';
import 'package:hotel_lemon_app/features/presentation/address/pick_address_from_map.dart';
import 'package:hotel_lemon_app/features/presentation/reusable_widget/app_text_field.dart';
import 'package:hotel_lemon_app/features/presentation/reusable_widget/bigtext.dart';
import 'package:hotel_lemon_app/features/presentation/reusable_widget/smalltext.dart';
import 'package:hotel_lemon_app/utils/app_colors.dart';
import 'package:hotel_lemon_app/utils/app_dimension.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isloggedIn;
  //default address on map, when we load for the first time
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(27.7172, 85.3240), zoom: 16);
  //default address on map, when we load for the first time
  late LatLng _initalPosition = const LatLng(27.7172, 85.3240);

  @override
  void initState() {
    super.initState();
    _isloggedIn = Get.find<AuthController>().userLoggedIn();
    // ignore: unnecessary_null_comparison
    if (_isloggedIn && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }

    //only user address is not empty
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      //This conditon apply only when user change the device.
      //user address from local storage
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();
      //getting address from database, only if user is already logged in.
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initalPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: SmallTxt(
            text: "Address",
            size: 15,
            color: ApClrs.textfontgreyColor,
          )),
      body: GetBuilder<UserController>(
        builder: (userController) {
          // ignore: unnecessary_null_comparison
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.userModel.name}';
            _contactPersonNumber.text = '${userController.userModel.phone}';

            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  '${locationController.placemark.name ?? ''}'
                  '${locationController.placemark.locality ?? ''}'
                  '${locationController.placemark.postalCode ?? ''}'
                  '${locationController.placemark.country ?? ''}';
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //map
                    Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ApClrs.greenColor),
                        ),
                        child: Stack(
                          children: [
                            GoogleMap(
                              mapType: MapType.satellite,
                              initialCameraPosition: CameraPosition(
                                  //from databse value
                                  target: _initalPosition,
                                  zoom: 16),
                              onTap: (latLng) {
                                Get.toNamed(
                                  RouteHelper.getAddAddressOnMap(),
                                  arguments: AddAddressOnMap(
                                    //Ontap event pasing page with some value as a argument
                                    fromSignUp: false,
                                    fomAddressPagr: true,
                                    googleMapController:
                                        locationController.mapController,
                                  ),
                                );
                              },
                              zoomControlsEnabled: true,
                              compassEnabled: false,
                              indoorViewEnabled: true,
                              mapToolbarEnabled: false,
                              myLocationButtonEnabled: true,
                              myLocationEnabled: true,
                              onCameraIdle: () {
                                //this method will get called when user move the map and select new address
                                locationController.updatePosition(
                                  _cameraPosition,
                                  true,
                                );
                              },
                              onCameraMove: ((position) =>
                                  //this method is most imporatant part for map address update
                                  _cameraPosition = position),
                              onMapCreated: (GoogleMapController controller) {
                                locationController.setMapController(controller);
                                if (Get.find<LocationController>()
                                    .addressList
                                    .isEmpty) {
                                  //
                                //  locationController.setMapController(controller);
                                }
                              },
                            ),
                          ],
                        )),
                    //Address field
                    SizedBox(height: Dimen.height5),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 80,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                locationController.addressTypeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  locationController.setAddressTypeIndex(index);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 60,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: ApClrs.bodyColor,
                                      border: Border.all(
                                        width: 2,
                                        color: locationController
                                                    .selectedAddresstypeIndex ==
                                                index
                                            ? ApClrs.mainClr
                                            : Colors.grey,
                                      )),
                                  child: Center(
                                    child: Icon(
                                      index == 0
                                          ? Icons.home_filled
                                          : index == 1
                                              ? Icons.work
                                              : Icons.location_on,
                                      color: locationController
                                                  .selectedAddresstypeIndex ==
                                              index
                                          ? ApClrs.mainClr
                                          : ApClrs.pendidngColor,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(height: Dimen.height10),
                    //field
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: BigText(
                        text: "Delivery address",
                        size: 24,
                        color: ApClrs.textfontgreyColor,
                      ),
                    ),
                    SizedBox(height: Dimen.height10),
                    //
                    AppTextField(
                      icon: Icons.map,
                      textController: _addressController,
                      hintText: "Address",
                    ),
                    //
                    SizedBox(height: Dimen.height20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: BigText(
                        text: "Your name",
                        size: 24,
                        color: ApClrs.textfontgreyColor,
                      ),
                    ),
                    SizedBox(height: Dimen.height10),
                    //
                    AppTextField(
                      icon: Icons.person,
                      textController: _contactPersonName,
                      hintText: "Name",
                    ),
                    SizedBox(height: Dimen.height20),
                    //
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: BigText(
                        text: "Your number",
                        size: 24,
                        color: ApClrs.textfontgreyColor,
                      ),
                    ),
                    SizedBox(height: Dimen.height10),
                    //
                    AppTextField(
                      icon: Icons.phone,
                      textController: _contactPersonNumber,
                      hintText: "Phone",
                    ),

                    SizedBox(height: Dimen.height20),
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          id: userController.userModel.id,
                          addressType: locationController.addressTypeList[
                              locationController.selectedAddresstypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude:
                              locationController.position.latitude.toString(),
                          longitude:
                              locationController.position.longitude.toString(),
                        );
                        print("address model ===== " +
                            _addressModel.id.toString());
                        locationController
                            .addUserAddress(_addressModel)
                            .then((response) {
                          if (response.isSuccess) {
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar(
                                "Address", "Address added succesfully");
                          } else {
                            showCuastomSnackBAr(
                              "Coudn't able to update your address",
                            );
                          }
                        });
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ApClrs.mainClr,
                        ),
                        child: Center(
                          child: BigText(
                            text: "Save address",
                            size: 20,
                            color: ApClrs.blackColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimen.height20),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
