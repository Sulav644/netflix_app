import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/auth/presentation/components/image_picker.dart';
import 'package:netflix_app/auth/presentation/login_page.dart';
import 'package:netflix_app/auth/application/response_repos_cubit.dart';
import 'package:netflix_app/auth/infrastructure/response_repos_notifier.dart';
import 'package:netflix_app/auth/infrastructure/response_repos_remote_service.dart';
import 'package:netflix_app/auth/infrastructure/response_repos_repository.dart';
import 'package:netflix_app/netflix_app/favourite_list/favourite_movie_action_button.dart';
import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';
import 'package:netflix_app/netflix_app/movie_detail/components/movie_action_button.dart';
import 'package:netflix_app/splash_screen.dart';

import 'netflix_app/home_page/components/navbar.dart';
import 'netflix_app/activity/domain/activity_log_cubit.dart';
import 'netflix_app/activity/domain/activity_log_list_cubit.dart';
import 'netflix_app/buy_tickets/domain/buy_tickets_cubit.dart';
import 'netflix_app/domain/netflix_data.dart';
import 'netflix_app/domain/review_alert_notice_cubit.dart';
import 'netflix_app/home_page/netflix_page.dart';
import 'netflix_app/movie_review/movie_review_page.dart';

final responseReposRemoteService = ResponseReposRemoteService(Dio());

final responseReposRepository =
    ResponseReposRepository(responseReposRemoteService);

ThemeData setThemeData(Color color) {
  return ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: color);
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavoriteMovieListCubit()),
        BlocProvider(create: (context) => FavoriteToggleCubit()),
        BlocProvider(create: (context) => BuyTicketsCubit()),
        BlocProvider(create: (context) => ShowMessageCubit()),
        BlocProvider(create: (context) => MovieReviewCubit()),
        BlocProvider(create: (context) => MovieInspectCubit()),
        BlocProvider(create: (context) => ShowReviewNoticeCubit()),
        BlocProvider(create: (context) => ShowMovieReviewPageCubit()),
        BlocProvider(create: (context) => DetailsCubit()),
        BlocProvider(create: (context) => ThemeColorCubit()),
        BlocProvider(create: (context) => ActivityLogListCubit()),
        BlocProvider(create: (context) => ActivityLogCubit()),
        BlocProvider(create: (context) => PickedConfirmImageCubit()),
        BlocProvider(create: (context) => ImagePreviewCubit()),
        BlocProvider(create: (context) => ShowProfileCubit()),
        BlocProvider(create: (context) => ShowColorDialogCubit()),
        BlocProvider(create: (context) => ShowNavigationCubit()),
        BlocProvider(create: (context) => LoginVerifyCubit()),
        BlocProvider(create: (context) => ResponseReposCubit()),
        BlocProvider(
            create: (context) => InitialOffsetForNavigationDialogCubit()),
        BlocProvider(
            create: (context) =>
                ResponseReposNotifier(responseReposRepository)),
        BlocProvider(create: (context) => DeletedMovieCubit()),
        BlocProvider(create: (context) => ShowNoFavoriteAddedMessageCubit()),
        BlocProvider(
            create: (context) => ShowActivityRecordNotRemovableMessageCubit()),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: SplashScreen(),
      ),
    );
  }
}
