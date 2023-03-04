import 'package:netflix_app/auth/application/response_repos_cubit.dart';
import 'package:netflix_app/auth/infrastructure/response_repos_repository.dart';

class ResponseReposNotifier extends ResponseReposCubit {
  final ResponseReposRepository _repository;
  ResponseReposNotifier(this._repository);
  Future<void> getResponseReposPage() async {
    super.getNextPage(() => _repository.getResponseReposPage());
  }
}
