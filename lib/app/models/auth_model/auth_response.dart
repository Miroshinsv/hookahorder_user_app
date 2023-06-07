import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.freezed.dart';

part 'auth_response.g.dart';

@freezed
class AuthResponseModel with _$AuthResponseModel {
  const AuthResponseModel._();

  const factory AuthResponseModel({
    required String type,
    required String accessToken,
    required String refreshToken,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, Object?> json) =>
      _$AuthResponseModelFromJson(json);

  String get getAccessToken => accessToken;
  String get getRefreshToken => refreshToken;
  String get getTokenType => type;
}
