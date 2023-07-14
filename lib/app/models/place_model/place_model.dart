import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hookahorder_mobile/app/models/address_model/address_model.dart';

part 'place_model.freezed.dart';

part 'place_model.g.dart';

@freezed
class PlaceModel with _$PlaceModel {
  const factory PlaceModel({
    required int id,
    required String name,
    String? startTime,
    String? endTime,
    String? logo,
    required AddressModel address,
  }) = _PlaceModel;

  factory PlaceModel.fromJson(Map<String, Object?> json) =>
      _$PlaceModelFromJson(json);
}
