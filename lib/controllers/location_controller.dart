import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/repository/location_repo.dart';
import '../models/AddressModel.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];

  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList = ["home", "office", "others"];
  int _addressTypeIndex = 0;


  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;


  void setMapController(GoogleMapController mapController) {
    _mapController = _mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async{
    if(_updateAddressData) {
      _loading = true;
      update();
      try {
        if(fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1
          );
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1
          );
        }

        if(_changeAddress) {
          String _address = await getAddressfromGeocode(
            LatLng(
              position.target.longitude,
              position.target.latitude,
            )
          );
          fromAddress?_placemark = Placemark(name:_address):
          _pickPlacemark=Placemark(name: _address);
        }
      }catch(e) {
        print(e);
      }
    }
  }

  Future<String> getAddressfromGeocode(LatLng latlng) async {
    String _address = "Unknown Location Found";
    Response response = await locationRepo.getAddressfromGeocode(latlng);
    if(response.body["status"]=='OK') {
      _address = response.body["results"][0]['formatted_address'].toString();
      print("printing address " + _address);
    } else {
      print("Error getting the google api");
    }

    return _address;
  }


  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    // convert to map using jsonDecode
    _getAddress = jsonDecode(locationRepo.getUserAddress());

    try {
      _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch(e) {
      print(e);
    }
    return _addressModel;
  }
}
