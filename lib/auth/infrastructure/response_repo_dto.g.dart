// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_repo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResponseRepoDTO _$$_ResponseRepoDTOFromJson(Map<String, dynamic> json) =>
    _$_ResponseRepoDTO(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$$_ResponseRepoDTOToJson(_$_ResponseRepoDTO instance) =>
    <String, dynamic>{
      'albumId': instance.albumId,
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
    };
