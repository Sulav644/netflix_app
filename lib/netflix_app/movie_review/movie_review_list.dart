import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/netflix_app/movie_review/movie_review_pdf.dart';
import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'package:supercharged/supercharged.dart';
import 'package:printing/printing.dart';

import '../../core/utils.dart';
import '../home_page/components/navbar.dart';
import '../domain/netflix_data.dart';
import '../home_page/netflix_page.dart';
import 'movie_review_page.dart';

enum ReviewProps { top }

class MovieReviewListPage extends StatefulWidget {
  final String? imgUrl;
  final String? title;
  const MovieReviewListPage({super.key, this.imgUrl, this.title});

  @override
  State<MovieReviewListPage> createState() => _MovieReviewListPageState();
}

class _MovieReviewListPageState extends State<MovieReviewListPage>
    with TickerProviderStateMixin {
  late AnimationController reviewController;
  late Animation<TimelineValue<ReviewProps>> reviewAnimation;

  @override
  void initState() {
    super.initState();

    reviewController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    reviewAnimation = TimelineTween<ReviewProps>()
        // opacity
        .addScene(
          begin: 0.milliseconds,
          end: 1000.milliseconds,
          curve: Curves.ease,
        )
        .animate(ReviewProps.top, tween: Tween(begin: 220.0, end: 0.0))
        // height and padding
        // .addSubsequentScene(duration: 1000.milliseconds, curve: Curves.ease)
        // .animate(AnimProps.height, tween: Tween(begin: 50.0, end: 150.0))
        .parent
        .animatedBy(reviewController);
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  // late Uint8List byteList, iconList;

  fetch(MovieDetail movieReviewList, BuildContext context) async {
    // final ByteData bytes = await rootBundle.load(image);
    // byteList = bytes.buffer.asUint8List();

    setState(() {});
    printDoc(movieReviewList, context);
  }

  @override
  Widget build(BuildContext context) {
    final movieReviewList = context.watch<MovieReviewCubit>().state;
    final showMovieReviewState =
        context.watch<ShowMovieReviewPageCubit>().state;
    final backgroundColor = context.watch<ThemeColorCubit>().state;
    if (widget.imgUrl != '' && showMovieReviewState) {
      reviewController.forward();
    }
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  (() {
                    if (movieReviewList.isEmpty) {
                      return defaultTextStyle(
                        Colors.white,
                        SizedBox(
                          width: getWidth(context),
                          height: getHeight(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('No review created'),
                              verticalSpace(10),
                              const MovieRevieListButton(),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          ...movieReviewList.map(
                            (e) => Column(
                              children: [
                                getStarsAndImage(e),
                                verticalSpace(10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: defaultTextStyle(
                                      Colors.blue,
                                      Column(
                                        children: [
                                          getStarComment(e),
                                          verticalSpace(10),
                                          Container(
                                            width: getWidth(context),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  getMovieTypeGenreComment(e),
                                                  divider(
                                                      width: getWidth(context),
                                                      thickness: 1,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              105,
                                                              105,
                                                              105)),
                                                  getMovieDescription(e),
                                                  (() {
                                                    if (e.message != '') {
                                                      return Column(
                                                        children: [
                                                          divider(
                                                              width: getWidth(
                                                                  context),
                                                              thickness: 1,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  105,
                                                                  105,
                                                                  105)),
                                                          getMovieMessage(e),
                                                        ],
                                                      );
                                                    } else {
                                                      return Container();
                                                    }
                                                  }()),
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
                          ),
                          const MovieRevieListButton(),
                        ],
                      );
                    }
                  }()),
                ],
              ),
              if (widget.imgUrl != '' && showMovieReviewState)
                Column(
                  children: [
                    AnimatedBuilder(
                      animation: reviewController,
                      builder: (context, child) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: reviewAnimation.value.get(ReviewProps.top)),
                          child: MovieReviewPage(
                            onPressed: () {
                              context.read<MovieInspectCubit>().resetState();
                              reviewController.reverse().then((value) => context
                                  .read<ShowMovieReviewPageCubit>()
                                  .toggleMovieReviewState(false));
                            },
                            imgUrl: widget.imgUrl!,
                            title: widget.title!,
                          ),
                        );
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> printDoc(
      MovieDetail movieReviewList, BuildContext newcontext) async {
    final netImage = await networkImage(movieReviewList.imgUrl!);
    final pdfFile =
        await PdfMovieReview.generate(movieReviewList, netImage, getContext());

    PdfApiReview.openFile(pdfFile);
  }

  BuildContext getContext() => context;

  Stack getStarsAndImage(e) {
    return Stack(
      children: [
        Image.network(
          e.imgUrl!,
          width: getWidth(context),
          height: 250,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            verticalSpace(getHeightRatio(context, 0.03)),
            Row(
              children: [
                ...StarCount.values
                    .map((i) => Icon(
                          e.starCount
                                  .where((element) => element == i)
                                  .isNotEmpty
                              ? Icons.star
                              : Icons.star_border_outlined,
                          color: Colors.white,
                        ))
                    .toList(),
              ],
            ),
            verticalSpace(getHeightRatio(context, 0.19)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 126, 156, 180)),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Colors.red)))),
                      onPressed: () async {
                        fetch(e, context);
                      },
                      child: Text('get^ pdf^'.capitalizeAndTrim())),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Container getStarComment(e) {
    return Container(
      width: getWidth(context),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 22, 22, 22),
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 58, 58, 58), offset: Offset(1, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            Text('i^ give this movie rate of '.capitalizeAndTrimOneWord()),
            Text(
              '${e.starCount.length} ',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            e.starCount.length == 1 ? const Text('star') : const Text('stars')
          ],
        ),
      ),
    );
  }

  SizedBox getMovieTypeGenreComment(MovieDetail e) {
    return SizedBox(
      width: getWidth(context),
      child: Wrap(
        children: [
          Text('the% movie completely comes under '.capitalizeAndTrimOneWord()),
          ...List.generate(
              e.type.length,
              (index) => Text(
                    movieTypeString[e.type[index]].toString().replaceAll("/",
                        e.type[index] == e.type[e.type.lastIndex!] ? "" : "/"),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  )).toList(),
          const Text(' genre and its '),
          Text(
            movieGenreString[e.genreType]!.toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          const Text(' rated'),
        ],
      ),
    );
  }

  SizedBox getMovieDescription(e) {
    return SizedBox(
      width: getWidth(context),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Text(
            'description'.capitalizeAndTrim(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(' ${e.description}')
        ],
      ),
    );
  }

  SizedBox getMovieMessage(e) {
    return SizedBox(
      width: getWidth(context),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Text(
            'message'.capitalizeAndTrim(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(' ${e.message}'),
        ],
      ),
    );
  }
}

class MovieRevieListButton extends StatelessWidget {
  const MovieRevieListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.orange)))),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const NetFlixPage(
              pageState: PageState.redirected,
            );
          }));
        },
        child: Text('create^'.capitalizeAndTrim()));
  }
}
