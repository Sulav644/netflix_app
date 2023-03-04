// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_repo_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ResponseRepoDTO _$ResponseRepoDTOFromJson(Map<String, dynamic> json) {
  return _ResponseRepoDTO.fromJson(json);
}

/// @nodoc
mixin _$ResponseRepoDTO {
  int get albumId => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponseRepoDTOCopyWith<ResponseRepoDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseRepoDTOCopyWith<$Res> {
  factory $ResponseRepoDTOCopyWith(
          ResponseRepoDTO value, $Res Function(ResponseRepoDTO) then) =
      _$ResponseRepoDTOCopyWithImpl<$Res, ResponseRepoDTO>;
  @useResult
  $Res call(
      {int albumId, int id, String title, String url, String thumbnailUrl});
}

/// @nodoc
class _$ResponseRepoDTOCopyWithImpl<$Res, $Val extends ResponseRepoDTO>
    implements $ResponseRepoDTOCopyWith<$Res> {
  _$ResponseRepoDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? albumId = null,
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? thumbnailUrl = null,
  }) {
    return _then(_value.copyWith(
      albumId: null == albumId
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ResponseRepoDTOCopyWith<$Res>
    implements $ResponseRepoDTOCopyWith<$Res> {
  factory _$$_ResponseRepoDTOCopyWith(
          _$_ResponseRepoDTO value, $Res Function(_$_ResponseRepoDTO) then) =
      __$$_ResponseRepoDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int albumId, int id, String title, String url, String thumbnailUrl});
}

/// @nodoc
class __$$_ResponseRepoDTOCopyWithImpl<$Res>
    extends _$ResponseRepoDTOCopyWithImpl<$Res, _$_ResponseRepoDTO>
    implements _$$_ResponseRepoDTOCopyWith<$Res> {
  __$$_ResponseRepoDTOCopyWithImpl(
      _$_ResponseRepoDTO _value, $Res Function(_$_ResponseRepoDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? albumId = null,
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? thumbnailUrl = null,
  }) {
    return _then(_$_ResponseRepoDTO(
      albumId: null == albumId
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ResponseRepoDTO extends _ResponseRepoDTO {
  const _$_ResponseRepoDTO(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl})
      : super._();

  factory _$_ResponseRepoDTO.fromJson(Map<String, dynamic> json) =>
      _$$_ResponseRepoDTOFromJson(json);

  @override
  final int albumId;
  @override
  final int id;
  @override
  final String title;
  @override
  final String url;
  @override
  final String thumbnailUrl;

  @override
  String toString() {
    return 'ResponseRepoDTO(albumId: $albumId, id: $id, title: $title, url: $url, thumbnailUrl: $thumbnailUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResponseRepoDTO &&
            (identical(other.albumId, albumId) || other.albumId == albumId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, albumId, id, title, url, thumbnailUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResponseRepoDTOCopyWith<_$_ResponseRepoDTO> get copyWith =>
      __$$_ResponseRepoDTOCopyWithImpl<_$_ResponseRepoDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ResponseRepoDTOToJson(
      this,
    );
  }
}

abstract class _ResponseRepoDTO extends ResponseRepoDTO {
  const factory _ResponseRepoDTO(
      {required final int albumId,
      required final int id,
      required final String title,
      required final String url,
      required final String thumbnailUrl}) = _$_ResponseRepoDTO;
  const _ResponseRepoDTO._() : super._();

  factory _ResponseRepoDTO.fromJson(Map<String, dynamic> json) =
      _$_ResponseRepoDTO.fromJson;

  @override
  int get albumId;
  @override
  int get id;
  @override
  String get title;
  @override
  String get url;
  @override
  String get thumbnailUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ResponseRepoDTOCopyWith<_$_ResponseRepoDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
