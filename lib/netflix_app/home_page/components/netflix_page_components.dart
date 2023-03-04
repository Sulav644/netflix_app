import 'package:flutter/material.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';

import '../../domain/netflix_data.dart';
import '../../movie_detail/content_detail_page.dart';
import '../../../core/utils.dart';
import '../domain/movie_data.dart';
import '../../movie_review/movie_review_list.dart';
import '../../favourite_list/netflix_favorite_list.dart';
import '../../tv_shows/tv_shows.dart';
import '../movie_image.dart';
import '../netflix_page.dart';

class NetflixPageComponents {
  List<Widget> nowPlayingImages(
          {required Images images,
          required BuildContext context,
          required VoidCallback onClick,
          required bool isProfileDialogOpened,
          required bool isColorDialogOpened,
          required bool isNavigationDialogOpened}) =>
      images.nowPlaying
          .map((e) => DefaultTextStyle(
                style: const TextStyle(color: Colors.white, fontSize: 30),
                child: Stack(
                  children: [
                    MovieImage(
                        e: e,
                        onClick: () {
                          if (isProfileDialogOpened ||
                              isColorDialogOpened ||
                              isNavigationDialogOpened) {
                            onClick();
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ContentDetailPage(
                                movieDetail: e,
                              );
                            }));
                          }
                        }),
                    Column(
                      children: [
                        Expanded(
                            flex: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                movieTitle(e.title!, context),
                              ],
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                verticalSpace(10),
                                movieGenre(e, context),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ))
          .toList();

  Widget movieReviewNotification(
          AnimationController notificationController,
          Animation<TimelineValue<NotificationProps>> notificationAnimation,
          BuildContext context) =>
      Column(
        children: [
          AnimatedBuilder(
            animation: notificationController,
            builder: (context, child) {
              return Padding(
                padding: EdgeInsets.only(
                    top: notificationAnimation.value
                        .get(NotificationProps.height)),
                child: notification(context),
              );
            },
          ),
        ],
      );

  Widget movieScrollCircles(Images images, int movieIndex) =>
      circles(images, movieIndex);
  Widget circles(Images images, int movieIndex) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(images.nowPlaying.length,
              (index) => circlesWithPadding(index, movieIndex)).toList()
        ],
      );
  Widget circlesWithPadding(int index, int movieIndex) => Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: index == movieIndex
                  ? Colors.white
                  : const Color.fromARGB(255, 175, 174, 174),
              borderRadius: BorderRadius.circular(100)),
        ),
      );

  Widget notification(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          message(context),
        ],
      );
  Widget message(BuildContext context) => Container(
        constraints: BoxConstraints(maxWidth: getWidthRatio(context, 0.8)),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 24, 24, 24),
            borderRadius: BorderRadius.circular(10)),
        child: alert(),
      );

  Widget alert() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Select any movie and click on "Create Review" on the page appeared',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );

  Widget movieTitle(String title, BuildContext context) => !title.contains(":")
      ? SizedBox(width: getWidth(context), child: Center(child: Text(title)))
      : SizedBox(
          width: getWidth(context),
          child: Column(
            children: [
              Text(trimmedTitle(title)),
              Text(trimmedSubtitle(title, 1)),
            ],
          ),
        );
  Widget movieGenre(MovieDetail e, BuildContext context) =>
      defaultTextStyle(Colors.white, genreList(e, context), 10);
  Widget genreList(MovieDetail e, BuildContext context) => SizedBox(
        width: getWidth(context),
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            genreListView(e),
          ],
        ),
      );
  Widget genreListView(MovieDetail e) => ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: e.genre.length,
        itemBuilder: (context, index) {
          return Text(e.genre[index]);
        },
        separatorBuilder: (context, index) {
          return const Text(' . ');
        },
      );

  Widget movieCategories(
          {required VoidCallback onClick,
          required BuildContext context,
          required bool isProfileDialogOpened,
          required bool isColorDialogOpened,
          required bool isNavigationDialogOpened}) =>
      Container(
          width: getWidth(context),
          height: 40,
          color: Colors.transparent,
          child: defaultTextStyle(
            Colors.white,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...["tv^ shows", "categories@", "reviews"]
                    .map(
                      (e) => (() {
                        if (e.contains("@")) {
                          return Container(
                              height: 40,
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e.capitalizeAndTrim(),
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ));
                        } else {
                          return GestureDetector(
                              onTap: () {
                                if (isColorDialogOpened ||
                                    isProfileDialogOpened ||
                                    isNavigationDialogOpened) {
                                  onClick();
                                } else {
                                  navigateToConsequentPage(e, context);
                                }
                              },
                              child: Container(
                                  height: 40,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.capitalizeAndTrim(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                  )));
                        }
                      }()),
                    )
                    .toList()
              ],
            ),
          ));
  Future<dynamic> navigateToConsequentPage(String e, BuildContext context) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => (() {
                    if (e.contains('^')) {
                      return const TvShowsPage();
                    } else {
                      return const MovieReviewListPage();
                    }
                  }())));
}
