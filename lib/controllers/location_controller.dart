import 'package:food_delivary_app/data/repository/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService{
   LocationRepo locationRepo;
   LocationController({required this.locationRepo});

   bool _loading = false;
   late Position _position;
   late Position _pickPosition;
  //get data
bool get loading => _loading;
Position get position => _position;
Position get pickPosition => _pickPosition;

   Placemark _placemark = Placemark();
   Placemark _pickPlacemark= Placemark();

   List<AddressModel> _addressList=[];
   List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<String> addressTypeList = ["home","office", "others"];
  int _addressTypeIndex = 0;

  late Map<String ,dynamic> _getAddress;
  Map get getAddress=> _getAddress;
 
  late GoogleMapController _mapController;
  bool _updateAddressData =true;
  bool _changeAddress= true;

  void setMapController(GoogleMapController mapController){
    _mapController=mapController;
  }

  void updatePosition(CameraPosition Cposition, bool fromAddress)async {
       if(_updateAddressData){
        _loading = true;
        update();
        try{
            if(fromAddress){
              _position = Position(
                longitude: Cposition.target.latitude , 
                latitude: Cposition.target.longitude, 
                timestamp: DateTime.now(),
                 accuracy: 1, 
                 altitude: 1,  
                 heading: 1, 
                 speed: 1, 
                 speedAccuracy: 1,
                 );
            } else{
               _pickPosition = Position(
                longitude: Cposition.target.latitude , 
                latitude: Cposition.target.longitude, 
                timestamp: DateTime.now(),
                 accuracy: 1, 
                 altitude: 1,  
                 heading: 1, 
                 speed: 1, 
                 speedAccuracy: 1,
                 );
            }
            if(_changeAddress){
              String _address = await getAddressFromGeocode(
             LatLng(
              Cposition.target.latitude,
              Cposition.target.longitude,
             )
              );
            }
        }catch(e){
          print(e);
        }
       }
  }
 Future<String> getAddressFromGeocode(LatLng latLng)async{
  String _address="Unknow locaiton Found ";
  Response response = await locationRepo.getAddressFromGeocode(latLng);

   print("Status code is ${response.statusCode}");
print(response.body);
  if(response.body["status"]=='200'){
    print(response.body);
    _address= response.body["results"][0]['formatted_address'].toString();
    print("printing address"+_address);
  }else{
    print("error getting the google api");
  }
  return _address;
 }

}