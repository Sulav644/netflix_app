import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../../movie_review/movie_review_list.dart';

import '../../activity/domain/activity_freezed.dart';
import '../../activity/domain/activity_log_cubit.dart';
import '../../activity/domain/activity_log_list_cubit.dart';
import '../../domain/netflix_data.dart';
import '../../movie_review/movie_review_page.dart';

class MovieDetailActionButtons extends StatelessWidget {
  final List<MovieDetail> movieDetailList;
  final MovieDetail movieDetail;
  const MovieDetailActionButtons(
      {super.key, required this.movieDetailList, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    final activityLogRecordTimeExpiration =
        context.watch<ActivityLogListCubit>().state;
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: SizedBox(
        width: getWidth(context),
        child: Row(
          children: [
            horizontalSpace(getWidthRatio(context, 0.2)),
            Expanded(
              child: movieDetailList
                      .where((element) => element.imgUrl == movieDetail.imgUrl)
                      .isEmpty
                  ? Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ActivityLogCubit>().addSingleActivity(
                                DateTime.now(), movieDetail.title!);
                            final singleMovie =
                                context.read<ActivityLogCubit>().state;
                            context.read<ActivityLogListCubit>().addActivity(
                                ActivitySingle(
                                    dateTime: singleMovie.dateTime,
                                    addedMovie: singleMovie.addedMovie));
                            context.read<ActivityLogCubit>().resetActivity();
                            context
                                .read<FavoriteMovieListCubit>()
                                .addFavouriteMovie(movieDetail);
                          },
                          child: const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          ),
                        ),
                        const Text('Add Favourite')
                      ],
                    )
                  : Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final dateTime = DateTime.now();
                            if (dateTime
                                    .difference(
                                        activityLogRecordTimeExpiration[0]
                                            .dateTime!)
                                    .inSeconds <
                                60) {
                              context
                                  .read<ActivityLogListCubit>()
                                  .removeActivity(
                                      movieDetail.title!, DateTime.now());
                            } else {
                              context
                                  .read<
                                      ShowActivityRecordNotRemovableMessageCubit>()
                                  .setActivityMessage(true);
                            }
                            context
                                .read<FavoriteMovieListCubit>()
                                .removeFavouriteMovie(movieDetail);
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                        ),
                        const Text('Remove')
                      ],
                    ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context
                      .read<MovieInspectCubit>()
                      .setMovieImage(movieDetail.imgUrl!);
                  context
                      .read<ShowMovieReviewPageCubit>()
                      .toggleMovieReviewState(true);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MovieReviewListPage(
                      imgUrl: movieDetail.imgUrl,
                      title: movieDetail.title,
                    );
                  }));
                },
                child: Column(
                  children: const [
                    Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    Text('Review')
                  ],
                ),
              ),
            ),
            horizontalSpace(getWidthRatio(context, 0.15)),
          ],
        ),
      ),
    );
  }
}

class ShowActivityRecordNotRemovableMessageCubit extends Cubit<bool> {
  ShowActivityRecordNotRemovableMessageCubit() : super(false);
  void setActivityMessage(bool status) {
    emit(status);
    Future.delayed(const Duration(seconds: 3)).then((value) => emit(!status));
  }
}
