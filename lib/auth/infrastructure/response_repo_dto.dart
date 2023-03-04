import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix_app/auth/infrastructure/response_repo.dart';

part 'response_repo_dto.freezed.dart';
part 'response_repo_dto.g.dart';

@freezed
class ResponseRepoDTO with _$ResponseRepoDTO {
  const ResponseRepoDTO._();
  const factory ResponseRepoDTO({
    required int albumId,
    required int id,
    required String title,
    required String url,
    required String thumbnailUrl,
  }) = _ResponseRepoDTO;
  factory ResponseRepoDTO.fromJson(Map<String, dynamic> json) =>
      _$ResponseRepoDTOFromJson(json);
  factory ResponseRepoDTO.fromDomain(ResponseRepo _) {
    return ResponseRepoDTO(
        albumId: _.albumId,
        id: _.id,
        title: _.title,
        url: _.url,
        thumbnailUrl: _.thumbnailUrl);
  }
  ResponseRepo toDomain() {
    return ResponseRepo(
        albumId: albumId,
        id: id,
        title: title,
        url: url,
        thumbnailUrl: thumbnailUrl);
  }
}
