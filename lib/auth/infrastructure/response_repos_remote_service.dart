import 'package:dio/dio.dart';
import 'package:netflix_app/auth/infrastructure/remote_response.dart';
import 'package:netflix_app/auth/infrastructure/repos_remote_service.dart';
import 'package:netflix_app/auth/infrastructure/response_repo_dto.dart';

class ResponseReposRemoteService extends ReposRemoteService {
  ResponseReposRemoteService(
    Dio dio,
  ) : super(dio);
  Future<RemoteResponse<List<ResponseRepoDTO>>> getResponseReposPage() async =>
      super.getPage(
          requestUri: Uri.https('jsonplaceholder.typicode.com', '/photos'),
          jsonDataSelector: (json) => json as List<dynamic>);
}
