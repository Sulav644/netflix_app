import 'package:flutter/material.dart';
import 'package:netflix_app/netflix_app/movie_detail/content_detail_page.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';

import '../home_page/domain/movie_data.dart';
import '../domain/netflix_data.dart';
// r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'

Images images = Images(
    nowPlaying: nowPlaying,
    popularSeries: popularSeries,
    animes: animes,
    tvComedies: tvComedies);

class TvShowsPage extends StatelessWidget {
  const TvShowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: SizedBox(
            width: getWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                verticalSpace(40),
                defaultTextStyle(
                  Colors.white,
                  Text(
                    'now playing'.capitalizeAndTrim(),
                  ),
                  20,
                  FontWeight.bold,
                ),
                SeriesList(movieList: images.nowPlaying),
                defaultTextStyle(
                  Colors.white,
                  Text('popular series'.capitalizeAndTrim()),
                  20,
                  FontWeight.bold,
                ),
                SeriesList(movieList: images.popularSeries),
                defaultTextStyle(
                  Colors.white,
                  Text('animes'.capitalize()),
                  20,
                  FontWeight.bold,
                ),
                SeriesList(movieList: images.animes),
                defaultTextStyle(
                  Colors.white,
                  Text('tv^ shows'.capitalizeAndTrim()),
                  20,
                  FontWeight.bold,
                ),
                SeriesList(movieList: images.tvComedies)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<MovieDetail> movieList;
  const SeriesList({super.key, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
          movieList.length,
          (index) => GestureDetector(
                onTap: () => navigateToConsequentPage(context, index),
                child: movieImage(index),
              )).toList(),
    );
  }

  Widget movieImage(int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(
          movieList[index].imgUrl!,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      );

  Future<dynamic> navigateToConsequentPage(BuildContext context, int index) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ContentDetailPage(movieDetail: movieList[index])));
}
