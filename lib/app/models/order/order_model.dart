import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hookahorder_mobile/app/models/place_model/place_model.dart';

part 'order_model.freezed.dart';

part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const OrderModel._();

  const factory OrderModel({
    required int id,
    @JsonKey(name: "order_status") String? orderStatus,
    @JsonKey(name: "taken_at") DateTime? takenAt,
    @JsonKey(name: "completed_at") DateTime? completedAt,
    @JsonKey(name: "created_at") required DateTime createdAt,
    @JsonKey(name: "place_id") required PlaceModel place,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, Object?> json) => _$OrderModelFromJson(json);

  int get getId => id;

  String? get getOrderStatus => orderStatus;

  DateTime? get getTakenAt => takenAt;

  DateTime? get getCompletedAt => completedAt;
  DateTime get getCreatedAt => createdAt;

  PlaceModel get getPlace => place;
}
