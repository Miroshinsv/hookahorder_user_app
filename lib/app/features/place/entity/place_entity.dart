import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hookahorder_mobile/app/features/place/entity/address_entity.dart';

part 'place_entity.freezed.dart';
part 'place_entity.g.dart';

@freezed
class PlaceEntity with _$PlaceEntity {
  const factory PlaceEntity({
    required int id,
    String? startTime,
    String? endTime,
    String? logo,
    required AddressEntity address,
  }) = _PlaceEntity;

  factory PlaceEntity.fromJson(Map<String, Object?> json) =>
      _$PlaceEntityFromJson(json);
}
