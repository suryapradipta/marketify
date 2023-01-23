import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marketify/controllers/auth_controller.dart';
import 'package:marketify/controllers/location_controller.dart';
import 'package:marketify/controllers/user_controller.dart';
import 'package:marketify/utils/colors.dart';
import 'package:marketify/widgets/app_text_field.dart';

import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(
          target: LatLng(-8.620932815641462, 115.16657399823436),
          zoom: 17);
  late LatLng _initialPosition = LatLng(-8.620932815641462, 115.16657399823436);


  @override
  void initState() {
   super.initState();
   _isLogged = Get.find<AuthController>().userLoggedIn();
   if(_isLogged&&Get.find<UserController>().userModel == null) {
     Get.find<UserController>().getUserInfo();
   }
   // actual location
   if(Get.find<LocationController>().addressList.isNotEmpty) {
     _cameraPosition = CameraPosition(target: LatLng(
       double.parse(Get.find<LocationController>().getAddress["latitude"]),
       double.parse(Get.find<LocationController>().getAddress["longitude"])
     ));
     _initialPosition = LatLng(
         double.parse(Get.find<LocationController>().getAddress["latitude"]),
         double.parse(Get.find<LocationController>().getAddress["longitude"])
     );
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if (userController.userModel != null &&
            _contactPersonName.text.isEmpty) {
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text = '${locationController.placemark.name??''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          print("address in my view is " + _addressController.text);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 2, color: AppColors.mainColor

                    )
                ),
                child: Stack(
                  children: [
                    GoogleMap(initialCameraPosition:
                    CameraPosition(
                        target: _initialPosition,
                        zoom: 17),
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
                      onCameraIdle: (){
                        locationController.updatePosition(_cameraPosition, true);
                      },
                      onCameraMove: ((position)=> _cameraPosition = position),
                      onMapCreated: (GoogleMapController controller) {
                        locationController.setMapController(controller);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20),
                child: BigText(text: "Delivery address"),
              ),
              SizedBox(height: Dimensions.height10,),
              AppTextField(textController: _addressController, hintText: "Your address", icon: Icons.map),

              SizedBox(height: Dimensions.height20,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20),
                child: BigText(text: "Contact name"),
              ),
              SizedBox(height: Dimensions.height10,),
              AppTextField(textController: _contactPersonName, hintText: "Your name", icon: Icons.person),

              SizedBox(height: Dimensions.height20,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20),
                child: BigText(text: "Your number"),
              ),
              SizedBox(height: Dimensions.height10,),
              AppTextField(textController: _contactPersonNumber, hintText: "Your number", icon: Icons.phone)
            ],
          );
        });
      }),
    );
  }
}
