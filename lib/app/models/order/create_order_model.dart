import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_model.freezed.dart';

part 'create_order_model.g.dart';

@freezed
class CreateOrderModel with _$CreateOrderModel {
  const CreateOrderModel._();

  const factory CreateOrderModel({
    required String type,
    required String accessToken,
    required String refreshToken,
  }) = _CreateOrderModel;

  factory CreateOrderModel.fromJson(Map<String, Object?> json) =>
      _$CreateOrderModelFromJson(json);

  String get getAccessToken => accessToken;
  String get getRefreshToken => refreshToken;
  String get getTokenType => type;
}
