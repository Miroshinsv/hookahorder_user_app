import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/models/place_model/place_model.dart';
import 'package:hookahorder_mobile/app/network/api_client.dart';
import 'package:hookahorder_mobile/app/network/api_utils.dart';

class PlaceService extends GetxService {
  final ApiClient _apiClient = ApiUtils.getApiClient();

  Future<List<PlaceModel>> getAllPlaces() async {
    return await _apiClient.getAllPlaces();
  }
}
