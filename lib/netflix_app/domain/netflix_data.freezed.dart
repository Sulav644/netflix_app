// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'netflix_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MovieData {
  List<MovieDetail>? get movieDetail => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MovieDataCopyWith<MovieData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieDataCopyWith<$Res> {
  factory $MovieDataCopyWith(MovieData value, $Res Function(MovieData) then) =
      _$MovieDataCopyWithImpl<$Res, MovieData>;
  @useResult
  $Res call({List<MovieDetail>? movieDetail});
}

/// @nodoc
class _$MovieDataCopyWithImpl<$Res, $Val extends MovieData>
    implements $MovieDataCopyWith<$Res> {
  _$MovieDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movieDetail = freezed,
  }) {
    return _then(_value.copyWith(
      movieDetail: freezed == movieDetail
          ? _value.movieDetail
          : movieDetail // ignore: cast_nullable_to_non_nullable
              as List<MovieDetail>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MovieDataCopyWith<$Res> implements $MovieDataCopyWith<$Res> {
  factory _$$_MovieDataCopyWith(
          _$_MovieData value, $Res Function(_$_MovieData) then) =
      __$$_MovieDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MovieDetail>? movieDetail});
}

/// @nodoc
class __$$_MovieDataCopyWithImpl<$Res>
    extends _$MovieDataCopyWithImpl<$Res, _$_MovieData>
    implements _$$_MovieDataCopyWith<$Res> {
  __$$_MovieDataCopyWithImpl(
      _$_MovieData _value, $Res Function(_$_MovieData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movieDetail = freezed,
  }) {
    return _then(_$_MovieData(
      movieDetail: freezed == movieDetail
          ? _value._movieDetail
          : movieDetail // ignore: cast_nullable_to_non_nullable
              as List<MovieDetail>?,
    ));
  }
}

/// @nodoc

class _$_MovieData extends _MovieData {
  const _$_MovieData({final List<MovieDetail>? movieDetail = const []})
      : _movieDetail = movieDetail,
        super._();

  final List<MovieDetail>? _movieDetail;
  @override
  @JsonKey()
  List<MovieDetail>? get movieDetail {
    final value = _movieDetail;
    if (value == null) return null;
    if (_movieDetail is EqualUnmodifiableListView) return _movieDetail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MovieData(movieDetail: $movieDetail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MovieData &&
            const DeepCollectionEquality()
                .equals(other._movieDetail, _movieDetail));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_movieDetail));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieDataCopyWith<_$_MovieData> get copyWith =>
      __$$_MovieDataCopyWithImpl<_$_MovieData>(this, _$identity);
}

abstract class _MovieData extends MovieData {
  const factory _MovieData({final List<MovieDetail>? movieDetail}) =
      _$_MovieData;
  const _MovieData._() : super._();

  @override
  List<MovieDetail>? get movieDetail;
  @override
  @JsonKey(ignore: true)
  _$$_MovieDataCopyWith<_$_MovieData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MovieDetail {
  String? get imgUrl => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  List<String> get genre => throw _privateConstructorUsedError;
  GenreType get genreType => throw _privateConstructorUsedError;
  List<MovieType> get type => throw _privateConstructorUsedError;
  List<StarCount> get starCount => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  MovieContentDescription? get movieContentDescription =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MovieDetailCopyWith<MovieDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieDetailCopyWith<$Res> {
  factory $MovieDetailCopyWith(
          MovieDetail value, $Res Function(MovieDetail) then) =
      _$MovieDetailCopyWithImpl<$Res, MovieDetail>;
  @useResult
  $Res call(
      {String? imgUrl,
      String? title,
      List<String> genre,
      GenreType genreType,
      List<MovieType> type,
      List<StarCount> starCount,
      String message,
      String description,
      MovieContentDescription? movieContentDescription});

  $MovieContentDescriptionCopyWith<$Res>? get movieContentDescription;
}

/// @nodoc
class _$MovieDetailCopyWithImpl<$Res, $Val extends MovieDetail>
    implements $MovieDetailCopyWith<$Res> {
  _$MovieDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imgUrl = freezed,
    Object? title = freezed,
    Object? genre = null,
    Object? genreType = null,
    Object? type = null,
    Object? starCount = null,
    Object? message = null,
    Object? description = null,
    Object? movieContentDescription = freezed,
  }) {
    return _then(_value.copyWith(
      imgUrl: freezed == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: null == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as List<String>,
      genreType: null == genreType
          ? _value.genreType
          : genreType // ignore: cast_nullable_to_non_nullable
              as GenreType,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as List<MovieType>,
      starCount: null == starCount
          ? _value.starCount
          : starCount // ignore: cast_nullable_to_non_nullable
              as List<StarCount>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      movieContentDescription: freezed == movieContentDescription
          ? _value.movieContentDescription
          : movieContentDescription // ignore: cast_nullable_to_non_nullable
              as MovieContentDescription?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MovieContentDescriptionCopyWith<$Res>? get movieContentDescription {
    if (_value.movieContentDescription == null) {
      return null;
    }

    return $MovieContentDescriptionCopyWith<$Res>(
        _value.movieContentDescription!, (value) {
      return _then(_value.copyWith(movieContentDescription: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MovieDetailCopyWith<$Res>
    implements $MovieDetailCopyWith<$Res> {
  factory _$$_MovieDetailCopyWith(
          _$_MovieDetail value, $Res Function(_$_MovieDetail) then) =
      __$$_MovieDetailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? imgUrl,
      String? title,
      List<String> genre,
      GenreType genreType,
      List<MovieType> type,
      List<StarCount> starCount,
      String message,
      String description,
      MovieContentDescription? movieContentDescription});

  @override
  $MovieContentDescriptionCopyWith<$Res>? get movieContentDescription;
}

/// @nodoc
class __$$_MovieDetailCopyWithImpl<$Res>
    extends _$MovieDetailCopyWithImpl<$Res, _$_MovieDetail>
    implements _$$_MovieDetailCopyWith<$Res> {
  __$$_MovieDetailCopyWithImpl(
      _$_MovieDetail _value, $Res Function(_$_MovieDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imgUrl = freezed,
    Object? title = freezed,
    Object? genre = null,
    Object? genreType = null,
    Object? type = null,
    Object? starCount = null,
    Object? message = null,
    Object? description = null,
    Object? movieContentDescription = freezed,
  }) {
    return _then(_$_MovieDetail(
      imgUrl: freezed == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: null == genre
          ? _value._genre
          : genre // ignore: cast_nullable_to_non_nullable
              as List<String>,
      genreType: null == genreType
          ? _value.genreType
          : genreType // ignore: cast_nullable_to_non_nullable
              as GenreType,
      type: null == type
          ? _value._type
          : type // ignore: cast_nullable_to_non_nullable
              as List<MovieType>,
      starCount: null == starCount
          ? _value._starCount
          : starCount // ignore: cast_nullable_to_non_nullable
              as List<StarCount>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      movieContentDescription: freezed == movieContentDescription
          ? _value.movieContentDescription
          : movieContentDescription // ignore: cast_nullable_to_non_nullable
              as MovieContentDescription?,
    ));
  }
}

/// @nodoc

class _$_MovieDetail extends _MovieDetail {
  const _$_MovieDetail(
      {this.imgUrl,
      this.title,
      final List<String> genre = const [],
      this.genreType = GenreType.none,
      final List<MovieType> type = const [],
      final List<StarCount> starCount = const [],
      this.message = "",
      this.description = "",
      this.movieContentDescription})
      : _genre = genre,
        _type = type,
        _starCount = starCount,
        super._();

  @override
  final String? imgUrl;
  @override
  final String? title;
  final List<String> _genre;
  @override
  @JsonKey()
  List<String> get genre {
    if (_genre is EqualUnmodifiableListView) return _genre;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genre);
  }

  @override
  @JsonKey()
  final GenreType genreType;
  final List<MovieType> _type;
  @override
  @JsonKey()
  List<MovieType> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  final List<StarCount> _starCount;
  @override
  @JsonKey()
  List<StarCount> get starCount {
    if (_starCount is EqualUnmodifiableListView) return _starCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_starCount);
  }

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final String description;
  @override
  final MovieContentDescription? movieContentDescription;

  @override
  String toString() {
    return 'MovieDetail(imgUrl: $imgUrl, title: $title, genre: $genre, genreType: $genreType, type: $type, starCount: $starCount, message: $message, description: $description, movieContentDescription: $movieContentDescription)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MovieDetail &&
            (identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._genre, _genre) &&
            (identical(other.genreType, genreType) ||
                other.genreType == genreType) &&
            const DeepCollectionEquality().equals(other._type, _type) &&
            const DeepCollectionEquality()
                .equals(other._starCount, _starCount) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(
                    other.movieContentDescription, movieContentDescription) ||
                other.movieContentDescription == movieContentDescription));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      imgUrl,
      title,
      const DeepCollectionEquality().hash(_genre),
      genreType,
      const DeepCollectionEquality().hash(_type),
      const DeepCollectionEquality().hash(_starCount),
      message,
      description,
      movieContentDescription);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieDetailCopyWith<_$_MovieDetail> get copyWith =>
      __$$_MovieDetailCopyWithImpl<_$_MovieDetail>(this, _$identity);
}

abstract class _MovieDetail extends MovieDetail {
  const factory _MovieDetail(
      {final String? imgUrl,
      final String? title,
      final List<String> genre,
      final GenreType genreType,
      final List<MovieType> type,
      final List<StarCount> starCount,
      final String message,
      final String description,
      final MovieContentDescription? movieContentDescription}) = _$_MovieDetail;
  const _MovieDetail._() : super._();

  @override
  String? get imgUrl;
  @override
  String? get title;
  @override
  List<String> get genre;
  @override
  GenreType get genreType;
  @override
  List<MovieType> get type;
  @override
  List<StarCount> get starCount;
  @override
  String get message;
  @override
  String get description;
  @override
  MovieContentDescription? get movieContentDescription;
  @override
  @JsonKey(ignore: true)
  _$$_MovieDetailCopyWith<_$_MovieDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MovieContentDescription {
  String get description => throw _privateConstructorUsedError;
  String get director => throw _privateConstructorUsedError;
  List<String> get writers => throw _privateConstructorUsedError;
  List<String> get stars => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MovieContentDescriptionCopyWith<MovieContentDescription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieContentDescriptionCopyWith<$Res> {
  factory $MovieContentDescriptionCopyWith(MovieContentDescription value,
          $Res Function(MovieContentDescription) then) =
      _$MovieContentDescriptionCopyWithImpl<$Res, MovieContentDescription>;
  @useResult
  $Res call(
      {String description,
      String director,
      List<String> writers,
      List<String> stars});
}

/// @nodoc
class _$MovieContentDescriptionCopyWithImpl<$Res,
        $Val extends MovieContentDescription>
    implements $MovieContentDescriptionCopyWith<$Res> {
  _$MovieContentDescriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? director = null,
    Object? writers = null,
    Object? stars = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      director: null == director
          ? _value.director
          : director // ignore: cast_nullable_to_non_nullable
              as String,
      writers: null == writers
          ? _value.writers
          : writers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MovieContentDescriptionCopyWith<$Res>
    implements $MovieContentDescriptionCopyWith<$Res> {
  factory _$$_MovieContentDescriptionCopyWith(_$_MovieContentDescription value,
          $Res Function(_$_MovieContentDescription) then) =
      __$$_MovieContentDescriptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      String director,
      List<String> writers,
      List<String> stars});
}

/// @nodoc
class __$$_MovieContentDescriptionCopyWithImpl<$Res>
    extends _$MovieContentDescriptionCopyWithImpl<$Res,
        _$_MovieContentDescription>
    implements _$$_MovieContentDescriptionCopyWith<$Res> {
  __$$_MovieContentDescriptionCopyWithImpl(_$_MovieContentDescription _value,
      $Res Function(_$_MovieContentDescription) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? director = null,
    Object? writers = null,
    Object? stars = null,
  }) {
    return _then(_$_MovieContentDescription(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      director: null == director
          ? _value.director
          : director // ignore: cast_nullable_to_non_nullable
              as String,
      writers: null == writers
          ? _value._writers
          : writers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stars: null == stars
          ? _value._stars
          : stars // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_MovieContentDescription extends _MovieContentDescription {
  const _$_MovieContentDescription(
      {required this.description,
      required this.director,
      required final List<String> writers,
      required final List<String> stars})
      : _writers = writers,
        _stars = stars,
        super._();

  @override
  final String description;
  @override
  final String director;
  final List<String> _writers;
  @override
  List<String> get writers {
    if (_writers is EqualUnmodifiableListView) return _writers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_writers);
  }

  final List<String> _stars;
  @override
  List<String> get stars {
    if (_stars is EqualUnmodifiableListView) return _stars;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stars);
  }

  @override
  String toString() {
    return 'MovieContentDescription(description: $description, director: $director, writers: $writers, stars: $stars)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MovieContentDescription &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.director, director) ||
                other.director == director) &&
            const DeepCollectionEquality().equals(other._writers, _writers) &&
            const DeepCollectionEquality().equals(other._stars, _stars));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      description,
      director,
      const DeepCollectionEquality().hash(_writers),
      const DeepCollectionEquality().hash(_stars));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieContentDescriptionCopyWith<_$_MovieContentDescription>
      get copyWith =>
          __$$_MovieContentDescriptionCopyWithImpl<_$_MovieContentDescription>(
              this, _$identity);
}

abstract class _MovieContentDescription extends MovieContentDescription {
  const factory _MovieContentDescription(
      {required final String description,
      required final String director,
      required final List<String> writers,
      required final List<String> stars}) = _$_MovieContentDescription;
  const _MovieContentDescription._() : super._();

  @override
  String get description;
  @override
  String get director;
  @override
  List<String> get writers;
  @override
  List<String> get stars;
  @override
  @JsonKey(ignore: true)
  _$$_MovieContentDescriptionCopyWith<_$_MovieContentDescription>
      get copyWith => throw _privateConstructorUsedError;
}
