import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix_app/auth/domain/response_failure.dart';
import 'package:netflix_app/auth/infrastructure/response_repo.dart';

import '../infrastructure/fresh.dart';

part 'response_repos_cubit.freezed.dart';

typedef RepositoryGetter
    = Future<Either<ResponseFailure, Fresh<List<ResponseRepo>>>> Function();

@freezed
class ResponseReposState with _$ResponseReposState {
  const ResponseReposState._();
  const factory ResponseReposState.initial(
    Fresh<List<ResponseRepo>> repos,
  ) = _Initial;
  const factory ResponseReposState.loadInProgress(
    Fresh<List<ResponseRepo>> repos,
  ) = _LoadInProgress;
  const factory ResponseReposState.loadSuccess(
    Fresh<List<ResponseRepo>> repos,
  ) = _LoadSuccess;
  const factory ResponseReposState.loadFailure(
    Fresh<List<ResponseRepo>> repos,
    ResponseFailure failure,
  ) = _LoadFailure;
}

class ResponseReposCubit extends Cubit<ResponseReposState> {
  ResponseReposCubit() : super(ResponseReposState.initial(Fresh.yes([])));
  Future<void> getNextPage(RepositoryGetter getter) async {
    emit(ResponseReposState.loadInProgress(state.repos));
    final failureOrRepos = await getter();
    emit(failureOrRepos
        .fold((l) => ResponseReposState.loadFailure(state.repos, l), (r) {
      return ResponseReposState.loadSuccess(r.copyWith(entity: [...r.entity]));
    }));
  }
}
