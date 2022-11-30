import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivary_app/controllers/auth_controller.dart';
import 'package:food_delivary_app/controllers/location_controller.dart';
import 'package:food_delivary_app/controllers/user_controllers.dart';
import 'package:food_delivary_app/utils/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  
  late bool _isLogged;

   CameraPosition _cameraPosition =const CameraPosition(target: LatLng(
    23.7980575, 90.3629107
  ),zoom: 5);

  late LatLng _initialPosition= const LatLng(
    23.7980575, 90.3629107
  );
  


  @override
  void initState() {
    _isLogged= Get.find<AuthController>().userLoggedIn();
     if(_isLogged&&Get.find<UserController>().userModel==null){
       Get.find<UserController>().getUserInfo();
     }
    if(Get.find<LocationController>().addressList.isNotEmpty){
         _cameraPosition = CameraPosition(target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["langitude"])
         ));
         _initialPosition=LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["langitude"])
         );
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address page"),
        backgroundColor: AppColors.mainColor,
      ),

        body: GetBuilder<LocationController>(builder: (locationcontroller){
          return Column(
          children: [
           Container(
            height: 140,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 5,right: 5,top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 2,color: Theme.of(context).primaryColor)
            ),
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 17
                    ),
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled:false,
                    onCameraIdle: (){
                     locationcontroller.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position)=>_cameraPosition=position),
                   onMapCreated: (GoogleMapController controller){
                    locationcontroller.setMapController(controller);
                   },
                    )
              ],
            ),
           )
          ],
        );
        },)
      );
  }
}