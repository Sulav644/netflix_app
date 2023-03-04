import 'package:flutter/material.dart';

import '../../core/utils.dart';
import '../domain/netflix_data.dart';
import 'favourite_movie_action_button.dart';
import 'netflix_favorite_list.dart';

class MovieImageWithTitles extends StatelessWidget {
  final MovieDetail e;
  final VoidCallback onClick;
  const MovieImageWithTitles({
    super.key,
    required this.e,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        movieImage(context),
        Column(
          children: [
            verticalSpace(getHeightRatio(context, 0.22)),
            movieTitles(context),
            verticalSpace(10),
            FavouriteMovieActionButtons(
              e: e,
              onClick: () => onClick(),
            ),
          ],
        )
      ],
    );
  }

  Widget movieImage(BuildContext context) {
    return Image.network(
      e.imgUrl!,
      width: getWidth(context),
      height: getHeightRatio(context, 0.4),
      fit: BoxFit.cover,
    );
  }

  Widget movieTitles(BuildContext context) {
    return !e.title!.contains(":")
        ? defaultTextStyle(
            Colors.white,
            SizedBox(
                width: getWidth(context), child: Center(child: Text(e.title!))),
            25)
        : defaultTextStyle(
            Colors.white,
            SizedBox(
              width: getWidth(context),
              child: Column(
                children: [
                  Text(trimmedTitle(e.title!)),
                  Text(trimmedSubtitle(e.title!, 1))
                ],
              ),
            ),
            25);
  }
}
