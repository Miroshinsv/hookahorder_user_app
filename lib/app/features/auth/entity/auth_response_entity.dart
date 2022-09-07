import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_entity.freezed.dart';
part 'auth_response_entity.g.dart';

@freezed
class AuthResponseEntity with _$AuthResponseEntity {
  const factory AuthResponseEntity({
    required String type,
    required String accessToken,
    required String refreshToken,
  }) = _AuthResponseEntity;

  factory AuthResponseEntity.fromJson(Map<String, Object?> json) =>
      _$AuthResponseEntityFromJson(json);
}
