import 'package:flutter/material.dart';

import '../../../core/utils.dart';
import '../../favourite_list/netflix_favorite_list.dart';
import '../../domain/netflix_data.dart';

class MovieDetailComponents {
  final BuildContext context;
  final MovieDetail movieDetail;

  MovieDetailComponents(
    this.context,
    this.movieDetail,
  );
  Widget movieGenres() => Row(
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
  Widget movieDescription() => Container(
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
  Widget movieDirector() => defaultTextStyle(
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

  Widget movieImage() => Image.network(
        movieDetail.imgUrl!,
        width: getWidth(context),
        height: getHeightRatio(context, 0.4),
        fit: BoxFit.cover,
      );

  Widget movieTitles() => movieDetail.title!.contains(":")
      ? defaultTextStyle(Colors.white, movieTitlesWithoutSubtitles(), 25)
      : defaultTextStyle(Colors.white, movieTitlesWithSubtitles(), 25);
  Widget movieTitlesWithoutSubtitles() => SizedBox(
      width: getWidth(context), child: Center(child: Text(movieDetail.title!)));
  Widget movieTitlesWithSubtitles() => SizedBox(
        width: getWidth(context),
        child: Column(
          children: [
            Text(trimmedTitle(movieDetail.title!)),
            Text(trimmedSubtitle(movieDetail.title!, 1))
          ],
        ),
      );
}
