import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'netflix_data.freezed.dart';

enum MovieType { action, adventure, fiction, crime }

class MovieGenreTypes {
  List<String> moviesTypes;
  List<String> genreTypes;
  MovieGenreTypes({required this.moviesTypes, required this.genreTypes});
}

final movieGenreTypes = MovieGenreTypes(
    moviesTypes: ["action/", "adventure/", "fiction/", "crime/"],
    genreTypes: ["pg-13", "r", "specific"]);

final movieTypeString = {
  MovieType.action: "action/",
  MovieType.adventure: "adventure/",
  MovieType.fiction: "fiction/",
  MovieType.crime: "crime/",
};
final movieGenreString = {
  GenreType.pg_13: "pg-13",
  GenreType.r: "r",
  GenreType.specific: "specific",
};

enum StarCount { one, two, three, four, five }

enum GenreType { pg_13, r, specific, none }

@freezed
class MovieData with _$MovieData {
  const MovieData._();
  const factory MovieData({
    @Default([]) List<MovieDetail>? movieDetail,
  }) = _MovieData;
}

@freezed
class MovieDetail with _$MovieDetail {
  const MovieDetail._();
  const factory MovieDetail({
    String? imgUrl,
    String? title,
    @Default([]) List<String> genre,
    @Default(GenreType.none) GenreType genreType,
    @Default([]) List<MovieType> type,
    @Default([]) List<StarCount> starCount,
    @Default("") String message,
    @Default("") String description,
    MovieContentDescription? movieContentDescription,
  }) = _MovieDetail;
}

@freezed
class MovieContentDescription with _$MovieContentDescription {
  const MovieContentDescription._();
  const factory MovieContentDescription({
    required String description,
    required String director,
    required List<String> writers,
    required List<String> stars,
  }) = _MovieContentDescription;
}

class FavoriteMovieListCubit extends Cubit<List<MovieDetail>> {
  FavoriteMovieListCubit() : super([]);
  void addFavouriteMovie(MovieDetail movieDetail) {
    emit([movieDetail, ...state]);
  }

  void removeFavouriteMovie(MovieDetail movieDetail) {
    state.remove(movieDetail);
    emit([...state]);
  }
}

class FavoriteToggleCubit extends Cubit<bool> {
  FavoriteToggleCubit() : super(false);
  void toggleFavorite(bool status) {
    emit(status);
  }
}
