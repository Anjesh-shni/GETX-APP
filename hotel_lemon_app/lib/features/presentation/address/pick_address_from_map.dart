import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_lemon_app/config/route/routes_helper.dart';
import 'package:hotel_lemon_app/features/getx_controller/map_controller/location_controller.dart';
import 'package:hotel_lemon_app/features/presentation/reusable_widget/bigtext.dart';
import 'package:hotel_lemon_app/features/presentation/reusable_widget/button_widget.dart';
import 'package:hotel_lemon_app/features/presentation/reusable_widget/smalltext.dart';
import 'package:hotel_lemon_app/utils/app_colors.dart';

class AddAddressOnMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fomAddressPagr;
  final GoogleMapController? googleMapController;
  const AddAddressOnMap({
    Key? key,
    required this.fromSignUp,
    required this.fomAddressPagr,
    this.googleMapController,
  }) : super(key: key);

  @override
  State<AddAddressOnMap> createState() => _AddAddressOnMapState();
}

class _AddAddressOnMapState extends State<AddAddressOnMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      //if user didn't have any address
      _initialPosition = const LatLng(27.7172, 85.3240);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 16);
    } else {
      //address list is not empty means user must have address in local storage, or in server
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        //user address from database
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));

        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 16);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: SmallTxt(
            text: "Change address",
            color: ApClrs.textfontgreyColor,
            size: 20,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  //Map
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 16),
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    onCameraMove: (CameraPosition cameraPosition) {
                      //
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      //this method return position
                      Get.find<LocationController>()
                          .updatePosition(_cameraPosition, false);
                    },
                  ),
                  //Marker
                  Center(
                    child: !locationController.loading
                        ? Image.asset(
                            "assets/icons/marker.png",
                            width: 50,
                            height: 50,
                          )
                        : const CircularProgressIndicator(
                            color: Colors.green,
                          ),
                  ),

                  //Address Box
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ApClrs.mainClr,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: ApClrs.bottonColor,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: BigText(
                                    text:
                                        "${locationController.pickplacemark.name ?? ""}"))
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Button
                  Positioned(
                    bottom: 20,
                    left: 10,
                    right: 10,
                    child: ButtonWidget(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      height: 55,
                      width: double.infinity,
                      buttonText: "Update address",
                      onPress: locationController.loading
                          ? () {
                              debugPrint(
                                  "Set Update Addressn getcalled::::::::::::::::::::nulllllll");
                            }
                          : () {
                              if (locationController.pickUpPositon.latitude !=
                                      0 &&
                                  locationController.pickplacemark.name !=
                                      null) {
                                if (widget.fomAddressPagr) {
                                  if (widget.googleMapController != null) {
                                    //
                                    print(
                                        "On map update button tapped::::::::::::::::");
                                    widget.googleMapController!.moveCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: LatLng(
                                            locationController
                                                .pickUpPositon.latitude,
                                            locationController
                                                .pickUpPositon.longitude,
                                          ),
                                        ),
                                      ),
                                    );
                                    locationController.setAddAddressData();
                                  }
                                  //get back, cause problem for not updating valuse like, list, variable
                                  //so used named push
                                  Get.toNamed(RouteHelper.getAddressPage());
                                }
                              }
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
