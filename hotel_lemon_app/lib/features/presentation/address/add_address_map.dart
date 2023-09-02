// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
