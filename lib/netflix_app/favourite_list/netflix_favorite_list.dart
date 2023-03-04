import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/netflix_app/favourite_list/favourite_movie_action_button.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'package:supercharged/supercharged.dart';

import '../../core/utils.dart';
import '../home_page/components/navbar.dart';
import '../domain/netflix_data.dart';
import 'movie_images_with_title.dart';

String trimmedTitle(String title) {
  return title.substring(0, title.indexOf(":"));
}

String trimmedSubtitle(String title, int num) {
  return title.substring(title.indexOf(":") + num);
}

List objectToList(List list) {
  return List.generate(
      list.length,
      (index) => Text(
            list[index].toString().replaceAll(
                "/", list[index] == list[list.lastIndex!] ? "" : " \u00b7 "),
          )).toList();
}

DefaultTextStyle defaultTextStyle(Color color, Widget child,
    [double? fontSize, FontWeight? fontWeight]) {
  return DefaultTextStyle(
      style: TextStyle(
          color: color,
          fontSize: fontSize ?? 15,
          fontWeight: fontWeight ?? FontWeight.normal),
      child: child);
}

Duration duration = 1000.milliseconds;
Duration begin = 0.milliseconds;
Duration end = 1000.milliseconds;
Curve curve = Curves.ease;

enum MovieProps { left, height }

class NetFlixFavoriteListPage extends StatefulWidget {
  const NetFlixFavoriteListPage({super.key});

  @override
  State<NetFlixFavoriteListPage> createState() =>
      _NetFlixFavoriteListPageState();
}

class _NetFlixFavoriteListPageState extends State<NetFlixFavoriteListPage>
    with TickerProviderStateMixin {
  final GlobalKey keyForFavourite = GlobalKey();
  MovieDetail deletedMovie = const MovieDetail();
  double assumedHeightForDeletedItem = 0;
  late AnimationController deleteMovieController, assumedHeightController;
  late Animation<TimelineValue<MovieProps>> deleteMovieAnimation,
      assumedHeightAnimation;
  Tween tween = Tween(begin: 20.0, end: 60.0);
  bool showPassword = false;
  bool showPasswordToggler = false;
  bool showStaticAssumedHeight = true;
  bool showNoFavoriteAddedMessage = false;

  @override
  void initState() {
    super.initState();

    deleteMovieController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    assumedHeightController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    deleteMovieAnimation = TimelineTween<MovieProps>()
        // opacity
        .addScene(begin: begin, end: end, curve: curve)
        .animate(MovieProps.left, tween: Tween(begin: 0.0, end: -360.0))
        .parent
        .animatedBy(deleteMovieController);
    assumedHeightAnimation = TimelineTween<MovieProps>()
        // opacity
        .addScene(begin: begin, end: end, curve: curve)
        .animate(MovieProps.height, tween: Tween(begin: 596.0, end: 0.0))
        .parent
        .animatedBy(assumedHeightController);
    assumedHeightForDeletedItem = 0;
  }

  @override
  void dispose() {
    deleteMovieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteList = context.watch<FavoriteMovieListCubit>().state;
    final backgroundColor = context.watch<ThemeColorCubit>().state;
    final deletedMovieStatus = context.watch<DeletedMovieCubit>().state;
    final showNoFavoriteMessageStatus =
        context.watch<ShowNoFavoriteAddedMessageCubit>().state;
    if (favoriteList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 900)).then((value) =>
          context.read<ShowNoFavoriteAddedMessageCubit>().toggleState(true));
    } else {
      context.read<ShowNoFavoriteAddedMessageCubit>().toggleState(false);
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: showNoFavoriteMessageStatus
          ? SizedBox(
              width: getWidth(context),
              height: getHeight(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'No favorite added',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      showStaticAssumedHeight
                          ? Container(
                              width: getWidth(context),
                              height: assumedHeightForDeletedItem,
                              color: backgroundColor,
                            )
                          : AnimatedBuilder(
                              animation: assumedHeightController,
                              builder: (context, child) {
                                return Container(
                                  width: getWidth(context),
                                  height: assumedHeightAnimation.value
                                      .get(MovieProps.height),
                                  color: backgroundColor,
                                );
                              },
                            ),
                      ...favoriteList
                          .map((e) => GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    MovieImageWithTitles(
                                        onClick: () {
                                          setState(() {
                                            assumedHeightForDeletedItem = 596;
                                          });
                                          assumedHeightController.reverse();
                                          context
                                              .read<DeletedMovieCubit>()
                                              .addDeletedMovie(e);
                                          deleteMovieController
                                              .forward()
                                              .then((value) {
                                                showStaticAssumedHeight = false;
                                                assumedHeightController
                                                    .forward();
                                              })
                                              .then((value) => context
                                                  .read<DeletedMovieCubit>()
                                                  .resetDeleteMovie())
                                              .then((value) =>
                                                  deleteMovieController
                                                      .reverse())
                                              .then((value) => setState(() {
                                                    assumedHeightForDeletedItem =
                                                        0;
                                                    showStaticAssumedHeight =
                                                        true;
                                                  }));
                                        },
                                        e: e),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: defaultTextStyle(
                                          Colors.white,
                                          Column(
                                            children: [
                                              verticalSpace(10),
                                              getMovieGenres(e),
                                              verticalSpace(10),
                                              getMovieDescription(context, e),
                                              verticalSpace(10),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 22, 22, 22),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                              255, 58, 58, 58),
                                                          offset: Offset(1, 1))
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      movieDirector(e),
                                                      divider(
                                                          width:
                                                              getWidth(context),
                                                          thickness: 1,
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              105, 105, 105)),
                                                      movieWriters(
                                                          context,
                                                          'Stars',
                                                          e.movieContentDescription!
                                                              .writers),
                                                      divider(
                                                          width:
                                                              getWidth(context),
                                                          thickness: 1,
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              105, 105, 105)),
                                                      movieWriters(
                                                          context,
                                                          'Writers',
                                                          e.movieContentDescription!
                                                              .stars),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          16),
                                    )
                                  ],
                                ),
                              ))
                          .toList()
                    ],
                  ),
                  if (deletedMovieStatus.imgUrl != null)
                    AnimatedBuilder(
                      animation: deleteMovieController,
                      builder: (context, child) {
                        return Positioned(
                          top: 20,
                          left: deleteMovieAnimation.value.get(MovieProps.left),
                          child: Column(
                            key: keyForFavourite,
                            children: [
                              MovieImageWithTitles(
                                  onClick: () {}, e: deletedMovieStatus),
                              defaultTextStyle(
                                  Colors.white,
                                  Column(
                                    children: [
                                      verticalSpace(10),
                                      getMovieGenres(deletedMovieStatus),
                                      verticalSpace(10),
                                      getMovieDescription(
                                          context, deletedMovieStatus),
                                      verticalSpace(10),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 22, 22, 22),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 58, 58, 58),
                                                  offset: Offset(1, 1))
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              movieDirector(deletedMovieStatus),
                                              divider(
                                                  width: getWidth(context),
                                                  thickness: 1,
                                                  color: const Color.fromARGB(
                                                      255, 105, 105, 105)),
                                              movieWriters(
                                                  context,
                                                  'Stars',
                                                  deletedMovieStatus
                                                      .movieContentDescription!
                                                      .writers),
                                              divider(
                                                  width: getWidth(context),
                                                  thickness: 1,
                                                  color: const Color.fromARGB(
                                                      255, 105, 105, 105)),
                                              movieWriters(
                                                  context,
                                                  'Writers',
                                                  deletedMovieStatus
                                                      .movieContentDescription!
                                                      .stars),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  16)
                            ],
                          ),
                        );
                      },
                    )
                ],
              ),
            ),
    );
  }

  Widget movieDirector(MovieDetail e) {
    return Row(
      children: [
        const Text(
          'Director ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          e.movieContentDescription!.director,
          style: const TextStyle(color: Colors.blue),
        )
      ],
    );
  }

  Widget movieWriters(BuildContext context, String title, List list) {
    return SizedBox(
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
            ...objectToList(list),
          ],
        ),
      ),
    );
  }

  Widget getMovieGenres(e) {
    return Row(children: [...movieGenresList(e)]);
  }

  List<dynamic> movieGenresList(e) {
    return e.genre!
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
                  ),
                ),
              ),
            ))
        .toList();
  }

  Container getMovieDescription(BuildContext context, e) {
    return Container(
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
              e.movieContentDescription!.description,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowNoFavoriteAddedMessageCubit extends Cubit<bool> {
  ShowNoFavoriteAddedMessageCubit() : super(false);
  void toggleState(bool status) => emit(status);
}
