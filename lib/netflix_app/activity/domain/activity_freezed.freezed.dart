// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_freezed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ActivityFreezed {
  List<ActivitySingle> get activity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActivityFreezedCopyWith<ActivityFreezed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityFreezedCopyWith<$Res> {
  factory $ActivityFreezedCopyWith(
          ActivityFreezed value, $Res Function(ActivityFreezed) then) =
      _$ActivityFreezedCopyWithImpl<$Res, ActivityFreezed>;
  @useResult
  $Res call({List<ActivitySingle> activity});
}

/// @nodoc
class _$ActivityFreezedCopyWithImpl<$Res, $Val extends ActivityFreezed>
    implements $ActivityFreezedCopyWith<$Res> {
  _$ActivityFreezedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity = null,
  }) {
    return _then(_value.copyWith(
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as List<ActivitySingle>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ActivityFreezedCopyWith<$Res>
    implements $ActivityFreezedCopyWith<$Res> {
  factory _$$_ActivityFreezedCopyWith(
          _$_ActivityFreezed value, $Res Function(_$_ActivityFreezed) then) =
      __$$_ActivityFreezedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ActivitySingle> activity});
}

/// @nodoc
class __$$_ActivityFreezedCopyWithImpl<$Res>
    extends _$ActivityFreezedCopyWithImpl<$Res, _$_ActivityFreezed>
    implements _$$_ActivityFreezedCopyWith<$Res> {
  __$$_ActivityFreezedCopyWithImpl(
      _$_ActivityFreezed _value, $Res Function(_$_ActivityFreezed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity = null,
  }) {
    return _then(_$_ActivityFreezed(
      activity: null == activity
          ? _value._activity
          : activity // ignore: cast_nullable_to_non_nullable
              as List<ActivitySingle>,
    ));
  }
}

/// @nodoc

class _$_ActivityFreezed extends _ActivityFreezed {
  const _$_ActivityFreezed({final List<ActivitySingle> activity = const []})
      : _activity = activity,
        super._();

  final List<ActivitySingle> _activity;
  @override
  @JsonKey()
  List<ActivitySingle> get activity {
    if (_activity is EqualUnmodifiableListView) return _activity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activity);
  }

  @override
  String toString() {
    return 'ActivityFreezed(activity: $activity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivityFreezed &&
            const DeepCollectionEquality().equals(other._activity, _activity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_activity));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActivityFreezedCopyWith<_$_ActivityFreezed> get copyWith =>
      __$$_ActivityFreezedCopyWithImpl<_$_ActivityFreezed>(this, _$identity);
}

abstract class _ActivityFreezed extends ActivityFreezed {
  const factory _ActivityFreezed({final List<ActivitySingle> activity}) =
      _$_ActivityFreezed;
  const _ActivityFreezed._() : super._();

  @override
  List<ActivitySingle> get activity;
  @override
  @JsonKey(ignore: true)
  _$$_ActivityFreezedCopyWith<_$_ActivityFreezed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActivitySingle {
  DateTime? get dateTime => throw _privateConstructorUsedError;
  List<String> get addedMovie => throw _privateConstructorUsedError;
  List<String> get addedReview => throw _privateConstructorUsedError;
  List<String> get addedTickets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActivitySingleCopyWith<ActivitySingle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivitySingleCopyWith<$Res> {
  factory $ActivitySingleCopyWith(
          ActivitySingle value, $Res Function(ActivitySingle) then) =
      _$ActivitySingleCopyWithImpl<$Res, ActivitySingle>;
  @useResult
  $Res call(
      {DateTime? dateTime,
      List<String> addedMovie,
      List<String> addedReview,
      List<String> addedTickets});
}

/// @nodoc
class _$ActivitySingleCopyWithImpl<$Res, $Val extends ActivitySingle>
    implements $ActivitySingleCopyWith<$Res> {
  _$ActivitySingleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = freezed,
    Object? addedMovie = null,
    Object? addedReview = null,
    Object? addedTickets = null,
  }) {
    return _then(_value.copyWith(
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addedMovie: null == addedMovie
          ? _value.addedMovie
          : addedMovie // ignore: cast_nullable_to_non_nullable
              as List<String>,
      addedReview: null == addedReview
          ? _value.addedReview
          : addedReview // ignore: cast_nullable_to_non_nullable
              as List<String>,
      addedTickets: null == addedTickets
          ? _value.addedTickets
          : addedTickets // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ActivitySingleCopyWith<$Res>
    implements $ActivitySingleCopyWith<$Res> {
  factory _$$_ActivitySingleCopyWith(
          _$_ActivitySingle value, $Res Function(_$_ActivitySingle) then) =
      __$$_ActivitySingleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? dateTime,
      List<String> addedMovie,
      List<String> addedReview,
      List<String> addedTickets});
}

/// @nodoc
class __$$_ActivitySingleCopyWithImpl<$Res>
    extends _$ActivitySingleCopyWithImpl<$Res, _$_ActivitySingle>
    implements _$$_ActivitySingleCopyWith<$Res> {
  __$$_ActivitySingleCopyWithImpl(
      _$_ActivitySingle _value, $Res Function(_$_ActivitySingle) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = freezed,
    Object? addedMovie = null,
    Object? addedReview = null,
    Object? addedTickets = null,
  }) {
    return _then(_$_ActivitySingle(
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addedMovie: null == addedMovie
          ? _value._addedMovie
          : addedMovie // ignore: cast_nullable_to_non_nullable
              as List<String>,
      addedReview: null == addedReview
          ? _value._addedReview
          : addedReview // ignore: cast_nullable_to_non_nullable
              as List<String>,
      addedTickets: null == addedTickets
          ? _value._addedTickets
          : addedTickets // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_ActivitySingle extends _ActivitySingle {
  const _$_ActivitySingle(
      {this.dateTime,
      final List<String> addedMovie = const [],
      final List<String> addedReview = const [],
      final List<String> addedTickets = const []})
      : _addedMovie = addedMovie,
        _addedReview = addedReview,
        _addedTickets = addedTickets,
        super._();

  @override
  final DateTime? dateTime;
  final List<String> _addedMovie;
  @override
  @JsonKey()
  List<String> get addedMovie {
    if (_addedMovie is EqualUnmodifiableListView) return _addedMovie;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addedMovie);
  }

  final List<String> _addedReview;
  @override
  @JsonKey()
  List<String> get addedReview {
    if (_addedReview is EqualUnmodifiableListView) return _addedReview;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addedReview);
  }

  final List<String> _addedTickets;
  @override
  @JsonKey()
  List<String> get addedTickets {
    if (_addedTickets is EqualUnmodifiableListView) return _addedTickets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addedTickets);
  }

  @override
  String toString() {
    return 'ActivitySingle(dateTime: $dateTime, addedMovie: $addedMovie, addedReview: $addedReview, addedTickets: $addedTickets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivitySingle &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            const DeepCollectionEquality()
                .equals(other._addedMovie, _addedMovie) &&
            const DeepCollectionEquality()
                .equals(other._addedReview, _addedReview) &&
            const DeepCollectionEquality()
                .equals(other._addedTickets, _addedTickets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      dateTime,
      const DeepCollectionEquality().hash(_addedMovie),
      const DeepCollectionEquality().hash(_addedReview),
      const DeepCollectionEquality().hash(_addedTickets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActivitySingleCopyWith<_$_ActivitySingle> get copyWith =>
      __$$_ActivitySingleCopyWithImpl<_$_ActivitySingle>(this, _$identity);
}

abstract class _ActivitySingle extends ActivitySingle {
  const factory _ActivitySingle(
      {final DateTime? dateTime,
      final List<String> addedMovie,
      final List<String> addedReview,
      final List<String> addedTickets}) = _$_ActivitySingle;
  const _ActivitySingle._() : super._();

  @override
  DateTime? get dateTime;
  @override
  List<String> get addedMovie;
  @override
  List<String> get addedReview;
  @override
  List<String> get addedTickets;
  @override
  @JsonKey(ignore: true)
  _$$_ActivitySingleCopyWith<_$_ActivitySingle> get copyWith =>
      throw _privateConstructorUsedError;
}
