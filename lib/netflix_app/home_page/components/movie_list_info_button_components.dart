import 'package:flutter/material.dart';

import '../../domain/netflix_data.dart';
import '../../movie_detail/content_detail_page.dart';

import '../../favourite_list/netflix_favorite_list.dart';

class MovieListInfoButtonWidgets {
  Future<dynamic> navigateToFavoriteListPage(BuildContext context, int index,
          [MovieDetail? e]) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return (() {
          if (index == 0) {
            return const NetFlixFavoriteListPage();
          } else {
            return ContentDetailPage(movieDetail: e!);
          }
        }());
      }));
}
