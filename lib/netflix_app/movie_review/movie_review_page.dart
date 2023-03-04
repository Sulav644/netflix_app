import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';

import '../activity/domain/activity_freezed.dart';
import '../activity/domain/activity_log_cubit.dart';
import '../activity/domain/activity_log_list_cubit.dart';
import '../domain/netflix_data.dart';

MaterialTapTargetSize materialTapTargetSize() =>
    MaterialTapTargetSize.shrinkWrap;
MaterialStateProperty<Color> checkBoxFillColor() =>
    MaterialStateColor.resolveWith((states) => Colors.transparent);
BorderSide checkBoxBorderSide() => MaterialStateBorderSide.resolveWith(
    (states) => const BorderSide(width: 2, color: Colors.red));
OutlinedBorder checkBoxShape() =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));

final movieGenre = ["PG-13", "R", "Specific"];

class MovieReviewPage extends StatefulWidget {
  final String imgUrl;
  final String title;
  final VoidCallback onPressed;
  const MovieReviewPage(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.onPressed});

  @override
  State<MovieReviewPage> createState() => _MovieReviewPageState();
}

class _MovieReviewPageState extends State<MovieReviewPage> {
  int selectedValue = 0;
  List checkBoxValue = [false, false, false, false];
  late TextEditingController messageController, descriptionController;
  final FocusNode focusNodeMessage = FocusNode(),
      focusNodeDescription = FocusNode();
  @override
  void initState() {
    super.initState();

    messageController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showMessageStatus = context.watch<ShowMessageCubit>().state;
    final movieInspectStatus = context.watch<MovieInspectCubit>().state;

    return GestureDetector(
      onTap: () {
        focusNodeMessage.unfocus();
        focusNodeDescription.unfocus();
      },
      child: SingleChildScrollView(
        child: SizedBox(
          width: getWidth(context),
          height: getHeight(context),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: SingleChildScrollView(
                child: Container(
                  width: getWidthRatio(context, 0.9),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 27, 27, 27),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultTextStyle(
                      Colors.white,
                      Column(
                        children: [
                          Text(
                            'create^ review^'.capitalizeAndTrim(),
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          verticalSpace(6),
                          imageField(),
                          verticalSpace(10),
                          MovieStarSelection(
                              movieInspectStatus: movieInspectStatus),
                          verticalSpace(10),
                          MovieTypeSelectionColumn(
                              movieInspectStatus: movieInspectStatus),
                          verticalSpace(10),
                          MovieGenreSelectionColumn(
                              movieInspectStatus: movieInspectStatus),
                          MovieMessage(
                              focusNode: focusNodeMessage,
                              messageController: messageController,
                              showMessageStatus: showMessageStatus),
                          MovieDescription(
                              focusNode: focusNodeDescription,
                              descriptionController: descriptionController),
                          MovieButton(
                              onPressed: widget.onPressed,
                              imgUrl: widget.imgUrl,
                              title: widget.title,
                              movieInspectStatus: movieInspectStatus),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageField() => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          widget.imgUrl,
          width: getWidth(context),
          height: getHeightRatio(context, 0.25),
          fit: BoxFit.cover,
        ),
      );
}

class MovieStarSelection extends StatelessWidget {
  final MovieDetail movieInspectStatus;
  const MovieStarSelection({super.key, required this.movieInspectStatus});
  bool isMovieStarredWith(StarCount starCount) {
    return movieInspectStatus.starCount.contains(starCount);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          StarCount.values.length,
          (index) => GestureDetector(
              onTap: () {
                if (isMovieStarredWith(StarCount.values[index])) {
                  context
                      .read<MovieInspectCubit>()
                      .removeStarCount(StarCount.values[index]);
                } else {
                  context
                      .read<MovieInspectCubit>()
                      .setStarCount(StarCount.values[index]);
                }
              },
              child: Icon(
                (() {
                  if (isMovieStarredWith(StarCount.values[index])) {
                    return Icons.star;
                  } else {
                    return Icons.star_border_outlined;
                  }
                }()),
                size: 28,
                color: Colors.red,
              ))).toList(),
    );
  }
}

class MovieButton extends StatelessWidget {
  final String imgUrl;
  final String title;
  final MovieDetail movieInspectStatus;
  final VoidCallback onPressed;
  const MovieButton(
      {super.key,
      required this.title,
      required this.movieInspectStatus,
      required this.imgUrl,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MovieElevatedButton(
            onPressed: () {
              final result = context.read<MovieInspectCubit>().inspectStatus();
              if (result) {
                context
                    .read<ActivityLogCubit>()
                    .addSingleReview(DateTime.now(), title);
                final singleMovie = context.read<ActivityLogCubit>().state;
                context.read<ActivityLogListCubit>().addReview(ActivitySingle(
                    dateTime: singleMovie.dateTime,
                    addedReview: singleMovie.addedReview));
                context.read<ActivityLogCubit>().resetActivity();

                context
                    .read<MovieReviewCubit>()
                    .addMovieReview(movieInspectStatus);

                context
                    .read<ShowMovieReviewPageCubit>()
                    .toggleMovieReviewState(false);
                context.read<MovieInspectCubit>().resetState();
              }
            },
            title: 'Save'),
        horizontalSpace(10),
        MovieElevatedButton(onPressed: onPressed, title: 'Cancel')
      ],
    );
  }
}

class MovieElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const MovieElevatedButton(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 39, 39, 39)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.red)))),
        onPressed: onPressed,
        child: Text(title));
  }
}

class MovieDescription extends StatelessWidget {
  final TextEditingController descriptionController;
  final FocusNode focusNode;
  const MovieDescription(
      {super.key,
      required this.descriptionController,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MovieTextField(
          messageController: descriptionController,
          maxLines: 4,
          focusNode: focusNode,
          textInputAction: TextInputAction.done,
          onChanged: (value) => context
              .read<MovieInspectCubit>()
              .addDescription(descriptionController.text)),
    );
  }
}

class MovieMessage extends StatelessWidget {
  final TextEditingController messageController;
  final bool showMessageStatus;
  final FocusNode focusNode;
  const MovieMessage(
      {super.key,
      required this.messageController,
      required this.showMessageStatus,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        messageBox(context),
        if (showMessageStatus)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MovieTextField(
                messageController: messageController,
                maxLines: 1,
                focusNode: focusNode,
                textInputAction: TextInputAction.next,
                onChanged: (value) => context
                    .read<MovieInspectCubit>()
                    .addMessage(messageController.text)),
          ),
        (() {
          if (!showMessageStatus) {
            messageController.clear();
            return Container();
          } else {
            return Container();
          }
        }())
      ],
    );
  }

  Row messageBox(BuildContext context) => Row(
        children: [
          CheckBoxWidget(
              context: context,
              movieTypeStatus: showMessageStatus,
              onChanged: (value) {
                context.read<ShowMessageCubit>().toggleMessage(value!);
              }),
          const Text(
            'Message',
            style: TextStyle(color: Colors.white),
          )
        ],
      );
}

class MovieTextField extends StatelessWidget {
  final TextEditingController messageController;
  final Function(String) onChanged;
  final int maxLines;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  const MovieTextField(
      {super.key,
      required this.messageController,
      required this.onChanged,
      required this.maxLines,
      required this.focusNode,
      required this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageController,
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
      maxLines: maxLines,
      cursorHeight: 30,
      cursorColor: Colors.white,
      textInputAction: textInputAction,
      decoration: const InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      focusNode: focusNode,
    );
  }
}

class MovieTypeSelectionColumn extends StatelessWidget {
  final MovieDetail movieInspectStatus;

  const MovieTypeSelectionColumn({super.key, required this.movieInspectStatus});

  @override
  Widget build(BuildContext context) {
    MovieType getMovieType(String title) {
      return MovieType.values[movieGenreTypes.moviesTypes.indexOf(title)];
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Movie Type'),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...movieGenreTypes.moviesTypes.map((e) => Column(
                  children: [
                    movieTypesList(context, getMovieType(e), e),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ))
          ],
        )
      ],
    );
  }

  Row movieTypesList(BuildContext context, MovieType movieType, String e) =>
      Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CheckBoxWidget(
                context: context,
                movieTypeStatus: movieInspectStatus.type
                    .where((element) => element == movieType)
                    .isNotEmpty,
                onChanged: (value) {
                  if (movieInspectStatus.type
                      .where((element) => element == movieType)
                      .isNotEmpty) {
                    context
                        .read<MovieInspectCubit>()
                        .removeMovieType(movieType);
                  } else {
                    context.read<MovieInspectCubit>().setMovieType(movieType);
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(e.capitalize().replaceAll("/", "")),
          )
        ],
      );
}

class CheckBoxWidget extends StatelessWidget {
  final BuildContext context;
  final bool movieTypeStatus;
  final Function(bool?)? onChanged;
  const CheckBoxWidget(
      {super.key,
      required this.context,
      required this.movieTypeStatus,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: movieTypeStatus,
      onChanged: onChanged,
      materialTapTargetSize: materialTapTargetSize(),
      fillColor: checkBoxFillColor(),
      side: checkBoxBorderSide(),
      shape: checkBoxShape(),
    );
  }
}

class MovieGenreSelectionColumn extends StatelessWidget {
  final MovieDetail movieInspectStatus;
  const MovieGenreSelectionColumn(
      {super.key, required this.movieInspectStatus});

  @override
  Widget build(BuildContext context) {
    GenreType getMovieGenreType(String title) {
      return GenreType.values[movieGenreTypes.genreTypes.indexOf(title)];
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Genre'),
        const SizedBox(
          width: 52,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...movieGenreTypes.genreTypes.map((e) => Column(
                  children: [
                    Row(
                      children: [
                        Text(e.contains('pg')
                            ? e.toUpperCase()
                            : e.capitalize()),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(unselectedWidgetColor: Colors.red),
                              child: RadioWidget(
                                  genreType: getMovieGenreType(e),
                                  movieInspectStatus: movieInspectStatus),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ))
          ],
        )
      ],
    );
  }
}

class RadioWidget extends StatelessWidget {
  final GenreType genreType;
  final MovieDetail movieInspectStatus;
  const RadioWidget(
      {super.key, required this.genreType, required this.movieInspectStatus});

  @override
  Widget build(BuildContext context) {
    return Radio(
        activeColor: Colors.red,
        value: genreType,
        groupValue: movieInspectStatus.genreType,
        onChanged: (value) =>
            context.read<MovieInspectCubit>().addGenreType(genreType));
  }
}

class ShowMessageCubit extends Cubit<bool> {
  ShowMessageCubit() : super(false);
  void toggleMessage(bool status) {
    emit(status);
  }

  void resetShowMessage() {
    emit(false);
  }
}

class MovieReviewCubit extends Cubit<List<MovieDetail>> {
  MovieReviewCubit() : super([]);
  void addMovieReview(MovieDetail movieDetail) {
    emit([movieDetail, ...state]);
  }

  void removeMovieReview(MovieDetail movieDetail) {
    state.remove(movieDetail);
    emit([...state]);
  }
}

class MovieInspectCubit extends Cubit<MovieDetail> {
  MovieInspectCubit() : super(const MovieDetail());
  void setMovieImage(String image) {
    emit(state.copyWith(imgUrl: image));
  }

  void setStarCount(StarCount count) {
    List<StarCount> starCount = [...state.starCount, count];
    emit(state.copyWith(starCount: starCount));
  }

  void removeStarCount(StarCount count) {
    List<StarCount> starCount = [];
    for (var element in state.starCount) {
      if (element != count) {
        starCount.add(element);
      }
    }
    emit(state.copyWith(starCount: starCount));
  }

  void setMovieType(MovieType type) {
    List<MovieType> movieTypes = [...state.type, type];
    emit(state.copyWith(type: movieTypes));
  }

  void removeMovieType(MovieType type) {
    List<MovieType> movieTypes = [];
    for (var element in state.type) {
      if (element != type) {
        movieTypes.add(element);
      }
    }
    emit(state.copyWith(type: movieTypes));
  }

  void addGenreType(GenreType genre) {
    emit(state.copyWith(genreType: genre));
  }

  void addMessage(String message) {
    emit(state.copyWith(message: message));
  }

  void addDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void resetState() {
    emit(const MovieDetail());
  }

  bool inspectStatus() {
    if (state.type.isEmpty) {
      return false;
    } else if (state.genreType == GenreType.none) {
      return false;
    } else if (state.description.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

class ShowMovieReviewPageCubit extends Cubit<bool> {
  ShowMovieReviewPageCubit() : super(false);
  void toggleMovieReviewState(bool status) {
    emit(status);
  }
}
