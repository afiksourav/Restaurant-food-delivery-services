import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_const.dart';

class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({ required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressFromGeocode (LatLng latLng)async{
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
    '?lat=${latLng.latitude}&lng=${latLng.longitude}'
    );
   } 
}