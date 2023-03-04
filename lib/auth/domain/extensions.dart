import '../infrastructure/response_repo.dart';
import '../infrastructure/response_repo_dto.dart';

extension DTOListTODomainList on List<ResponseRepoDTO> {
  List<ResponseRepo> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}
