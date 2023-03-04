import 'package:dio/dio.dart';
import 'package:netflix_app/auth/domain/dio_extensions.dart';
import 'package:netflix_app/auth/domain/network_exception.dart';
import 'package:netflix_app/auth/infrastructure/remote_response.dart';
import 'package:netflix_app/auth/infrastructure/response_repo_dto.dart';

abstract class ReposRemoteService {
  final Dio _dio;
  ReposRemoteService(this._dio);
  Future<RemoteResponse<List<ResponseRepoDTO>>> getPage({
    required Uri requestUri,
    required List<dynamic> Function(dynamic json) jsonDataSelector,
  }) async {
    try {
      final response = await _dio.getUri(requestUri);
      if (response.statusCode == 200) {
        final convertedData = jsonDataSelector(response.data)
            .map((e) => ResponseRepoDTO.fromJson(e as Map<String, dynamic>))
            .toList();
        return RemoteResponse.withNewData(convertedData);
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
