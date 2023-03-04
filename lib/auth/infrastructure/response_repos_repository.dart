import 'package:dartz/dartz.dart';
import 'package:netflix_app/auth/domain/extensions.dart';
import 'package:netflix_app/auth/domain/network_exception.dart';
import 'package:netflix_app/auth/domain/response_failure.dart';
import 'package:netflix_app/auth/infrastructure/response_repo.dart';
import 'package:netflix_app/auth/infrastructure/response_repos_remote_service.dart';

import 'fresh.dart';

class ResponseReposRepository {
  final ResponseReposRemoteService _remoteService;
  ResponseReposRepository(this._remoteService);
  Future<Either<ResponseFailure, Fresh<List<ResponseRepo>>>>
      getResponseReposPage() async {
    try {
      final remoteItems = await _remoteService.getResponseReposPage();
      return right(await remoteItems.when(noConnection: () async {
        return Fresh.no([]);
      }, withNewData: (data) async {
        return Fresh.yes(data.toDomain());
      }));
    } on RestApiException catch (e) {
      return left(ResponseFailure.api(e.errorCode));
    }
  }
}
