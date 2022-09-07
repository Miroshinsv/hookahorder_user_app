import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_entity.freezed.dart';
part 'address_entity.g.dart';


@freezed
class AddressEntity with _$AddressEntity {
  const factory AddressEntity({
    required int id,
    String? country,
    String? apartment,
    required String city,
    required String street,
    required String building,
    required double lat,
    required double lng,
  }) = _AddressEntity;

  factory AddressEntity.fromJson(Map<String, Object?> json) =>
      _$AddressEntityFromJson(json);
}
