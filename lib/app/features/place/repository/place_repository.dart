import 'package:hookahorder_mobile/app/features/place/entity/place_entity.dart';
import 'package:hookahorder_mobile/app/network/api_client.dart';
import 'package:hookahorder_mobile/app/network/api_utils.dart';

class PlaceRepository {
  final ApiClient _apiClient = ApiUtils.getApiClient();

  Future<List<PlaceEntity>> getAllPlaces() async {
    return await _apiClient.getAllPlaces();
  }
}
