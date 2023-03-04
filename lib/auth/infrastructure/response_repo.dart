import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_repo.freezed.dart';

@freezed
class ResponseRepo with _$ResponseRepo {
  const ResponseRepo._();
  const factory ResponseRepo({
    required int albumId,
    required int id,
    required String title,
    required String url,
    required String thumbnailUrl,
  }) = _ResponseRepo;
}
