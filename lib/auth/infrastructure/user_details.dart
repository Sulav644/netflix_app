import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_details.freezed.dart';

@freezed
class Validation with _$Validation {
  const Validation._();
  const factory Validation() = _Validation;
  const factory Validation.none() = _ValidationNone;
  const factory Validation.empty() = _ValidationEmpty;
  const factory Validation.notMatchedPattern() = _ValidationNotMatchedPattern;
  const factory Validation.valid() = _ValidationValid;
}

@freezed
class UserDetails with _$UserDetails {
  const UserDetails._();
  const factory UserDetails(
      {File? image,
      @Default('') String firstName,
      @Default('') String lastName,
      @Default(0) int phone,
      @Default('') String email,
      @Default('') String password}) = _UserDetails;
}

@freezed
class LoginVerify with _$LoginVerify {
  const LoginVerify._();
  const factory LoginVerify({
    @Default(Validation.none()) Validation firstName,
    @Default(Validation.none()) Validation lastName,
    @Default(Validation.none()) Validation phoneNumber,
    @Default(Validation.none()) Validation email,
    @Default(Validation.none()) Validation password,
  }) = _LoginVerify;
}
