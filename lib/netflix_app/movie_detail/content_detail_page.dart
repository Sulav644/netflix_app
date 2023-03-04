import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'package:supercharged/supercharged.dart';

import '../../core/utils.dart';

import '../home_page/components/navbar.dart';
import '../domain/netflix_data.dart';
import 'components/movie_action_button.dart';
import 'components/movie_detail_components.dart';

enum MessageProps { height }

class ContentDetailPage extends StatefulWidget {
  final MovieDetail movieDetail;

  const ContentDetailPage({required this.movieDetail, super.key});

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage>
    with TickerProviderStateMixin {
  late AnimationController activityAlertController;
  late Animation<TimelineValue<MessageProps>> activityAlertAnimation;
  Tween tween = Tween(begin: 20.0, end: 60.0);
  bool showPassword = false;
  bool showPasswordToggler = false;

  @override
  void initState() {
    super.initState();

    activityAlertController =
        AnimationController(duration: duration, vsync: this);

    activityAlertAnimation = TimelineTween<MessageProps>()
        // opacity
        .addScene(begin: begin, end: end, curve: curve)
        .animate(MessageProps.height, tween: Tween(begin: -50.0, end: 26.0))
        .parent
        .animatedBy(activityAlertController);
  }

  bool added = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final movieDetailList = context.watch<FavoriteMovieListCubit>().state;
    final backgroundColor = context.watch<ThemeColorCubit>().state;
    final showActivityMessage =
        context.watch<ShowActivityRecordNotRemovableMessageCubit>().state;
    MovieDetailComponents components = MovieDetailComponents(
      context,
      widget.movieDetail,
    );
    if (showActivityMessage) {
      activityAlertController.forward().then((value) =>
          Future.delayed(const Duration(seconds: 2))
              .then((value) => activityAlertController.reverse()));
    }
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: getWidth(context),
                    height: getHeightRatio(context, 0.4),
                    child: Stack(
                      children: [
                        movieImage(widget.movieDetail),
                        Column(
                          children: [
                            Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    movieTitles(widget.movieDetail),
                                  ],
                                )),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MovieDetailActionButtons(
                                    movieDetailList: movieDetailList,
                                    movieDetail: widget.movieDetail,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultTextStyle(
                        Colors.white,
                        Column(
                          children: [
                            verticalSpace(10),
                            movieGenres(widget.movieDetail),
                            verticalSpace(10),
                            movieDescription(widget.movieDetail),
                            verticalSpace(10),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 22, 22, 22),
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 58, 58, 58),
                                        offset: Offset(1, 1))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    components.movieDirector(),
                                    divider(
                                        width: getWidth(context),
                                        thickness: 1,
                                        color: const Color.fromARGB(
                                            255, 105, 105, 105)),
                                    movieWriters(
                                        context,
                                        'Writers',
                                        widget.movieDetail
                                            .movieContentDescription!.writers),
                                    divider(
                                        width: getWidth(context),
                                        thickness: 1,
                                        color: const Color.fromARGB(
                                            255, 105, 105, 105)),
                                    movieWriters(
                                        context,
                                        'Stars',
                                        widget.movieDetail
                                            .movieContentDescription!.stars)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        16),
                  ),
                ],
              ),
            ),
            if (showActivityMessage)
              AnimatedBuilder(
                animation: activityAlertController,
                builder: (context, child) {
                  return Positioned(
                    top: activityAlertAnimation.value.get(MessageProps.height),
                    left: getWidthRatio(context, 0.1),
                    child: Container(
                      width: getWidthRatio(context, 0.8),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, top: 8.0, right: 4, bottom: 8.0),
                        child: Text(
                          "Its more than one minute\nIt won't be removed from present activity record but will be added to new record when you again add in in favorite",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }

  Widget movieGenres(MovieDetail movieDetail) => Row(
        children: movieDetail.genre
            .map((e) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ))
            .toList(),
      );
  Widget movieDescription(MovieDetail movieDetail) => Container(
        width: getWidth(context),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 22, 22, 22),
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 58, 58, 58), offset: Offset(1, 1))
            ]),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movieDetail.movieContentDescription!.description,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
  Widget movieDirector(MovieDetail movieDetail) => defaultTextStyle(
        Colors.blue,
        Row(
          children: [
            const Text(
              'Director ',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(movieDetail.movieContentDescription!.director),
          ],
        ),
      );
  Widget movieWriters(BuildContext context, String title, List list) =>
      SizedBox(
        width: getWidth(context),
        child: defaultTextStyle(
          Colors.blue,
          Wrap(
            children: [
              Text(
                '$title ',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              ...objectToList(list)
            ],
          ),
        ),
      );

  Widget movieImage(MovieDetail movieDetail) => Image.network(
        movieDetail.imgUrl!,
        width: getWidth(context),
        height: getHeightRatio(context, 0.4),
        fit: BoxFit.cover,
      );

  Widget movieTitles(MovieDetail movieDetail) =>
      movieDetail.title!.contains(":")
          ? defaultTextStyle(
              Colors.white, movieTitlesWithSubtitles(movieDetail), 25)
          : defaultTextStyle(
              Colors.white, movieTitlesWithoutSubtitles(movieDetail), 25);

  Widget movieTitlesWithoutSubtitles(MovieDetail movieDetail) => SizedBox(
      width: getWidth(context), child: Center(child: Text(movieDetail.title!)));
  Widget movieTitlesWithSubtitles(MovieDetail movieDetail) => SizedBox(
        width: getWidth(context),
        child: Column(
          children: [
            Text(trimmedTitle(movieDetail.title!)),
            Text(trimmedSubtitle(movieDetail.title!, 1))
          ],
        ),
      );
}
