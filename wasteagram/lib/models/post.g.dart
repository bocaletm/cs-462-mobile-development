// GENERATED CODE - DO NOT REGENERATE 
// DATETIME CONVERSION HAD TO BE MODIFIED BY HAND 
// DUE TO FIRESTORE TIME FORMAT INCOMPATIBILITY

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['imageUrl'] as String,
    json['date'] == null ? null : json['date'],
    json['count'] as int,
    json['name'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  )..dateString = json['dateString'] as String;
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'date': instance.date?.toIso8601String(),
      'dateString': instance.dateString,
      'count': instance.count,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
