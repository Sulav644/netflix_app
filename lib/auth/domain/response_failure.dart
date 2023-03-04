import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_failure.freezed.dart';

@freezed
class ResponseFailure with _$ResponseFailure {
  const ResponseFailure._();
  const factory ResponseFailure.api(int? errorCode) = _Api;
}
