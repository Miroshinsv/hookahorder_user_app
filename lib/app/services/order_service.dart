import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/models/order/order_model.dart';
import 'package:hookahorder_mobile/app/network/api_client.dart';
import 'package:hookahorder_mobile/app/network/api_utils.dart';

class OrderService extends GetxService {
  final ApiClient _apiClient = ApiUtils.getApiClient();

  Future<OrderModel> postOrder({
    required int placeId,
    required userId,
    required String time,
    String? comment,
  }) async {
    return await _apiClient.postOrder(
      {
        "place_id": {"id": placeId},
        "user_id": {"id": userId},
        "order_time": time,
        "comment": {"text": comment}
      },
    );
  }

  Future<List<OrderModel>> getMyOrders({String? status, int? count}) async {
    return await _apiClient.getMyOrders();
  }
}
