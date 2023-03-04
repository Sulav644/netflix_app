import 'package:flutter/material.dart';
import 'package:netflix_app/netflix_app/home_page/components/movie_list_info_button_components.dart';

import '../domain/netflix_data.dart';
import '../../core/utils.dart';
import '../favourite_list/netflix_favorite_list.dart';
import 'movie_action_button.dart';

class MyListAndInfoButtons extends StatelessWidget {
  final VoidCallback onClick;
  final MovieDetail movieDetail;
  final bool isProfileDialogOpened;
  final bool isColorDialogOpened;
  final bool isNavigationDialogOpened;
  const MyListAndInfoButtons(
      {super.key,
      required this.onClick,
      required this.movieDetail,
      required this.isProfileDialogOpened,
      required this.isColorDialogOpened,
      required this.isNavigationDialogOpened});

  @override
  Widget build(BuildContext context) {
    return defaultTextStyle(
      Colors.white,
      SizedBox(
        width: getWidth(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MovieNetFlixActionButton(
              icon: Icons.check,
              title: 'My List',
              onClick: () {
                if (isColorDialogOpened ||
                    isProfileDialogOpened ||
                    isNavigationDialogOpened) {
                  onClick();
                } else {
                  MovieListInfoButtonWidgets()
                      .navigateToFavoriteListPage(context, 0);
                }
              },
            ),
            horizontalSpace(getWidthRatio(context, 0.1)),
            MovieNetFlixActionButton(
                icon: Icons.info_outline,
                title: 'info',
                onClick: () {
                  if (isColorDialogOpened ||
                      isProfileDialogOpened ||
                      isNavigationDialogOpened) {
                    onClick();
                  } else {
                    MovieListInfoButtonWidgets()
                        .navigateToFavoriteListPage(context, 1, movieDetail);
                  }
                })
          ],
        ),
      ),
    );
  }
}
