import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request_entity.freezed.dart';
part 'auth_request_entity.g.dart';

@freezed
class AuthRequestEntity with _$AuthRequestEntity {
  const factory AuthRequestEntity({
    required String phone,
    required String password,
  }) = _AuthRequestEntity;

  factory AuthRequestEntity.fromJson(Map<String, Object?> json) =>
      _$AuthRequestEntityFromJson(json);
}
