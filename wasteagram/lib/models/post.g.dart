// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['imageUrl'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['count'] as int,
    json['name'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'date': instance.date?.toIso8601String(),
      'count': instance.count,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
