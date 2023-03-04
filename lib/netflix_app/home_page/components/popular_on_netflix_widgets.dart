import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../../../core/utils.dart';
import '../../domain/netflix_data.dart';
import '../../movie_detail/content_detail_page.dart';

class PopularOnNetflixWidgets {
  Widget seriesTitle(String title) => Row(
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      );

  Future<dynamic> navigateToContentDetailPage(
          BuildContext context, MovieDetail e) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ContentDetailPage(
          movieDetail: e,
        );
      }));

  EdgeInsets edgePadding(MovieDetail e, List images) => EdgeInsets.only(
      top: 8.0,
      right: (() {
        if (e.imgUrl == images[images.lastIndex!].imgUrl) return 0.0;
        return 8.0;
      }()),
      bottom: 8.0);

  Widget gridSeriesImage(MovieDetail e, BuildContext context) => Image.network(
        e.imgUrl!,
        width: getWidthRatio(context, 0.4),
        height: getWidthRatio(context, 0.4),
        fit: BoxFit.cover,
      );
}
