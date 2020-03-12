import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final DateFormat _dateFormat = DateFormat("EEEE, MMMM d, yyyy");  
  final String imageUrl;
  final DateTime date;
  String dateString;
  final int count;
  final String name;
  final double latitude;
  final double longitude;

  Post(this.imageUrl, this.date, this.count, this.name, this.latitude, this.longitude) {
    dateString = _dateFormat.format(date);    
  }

  void datePost() {
    dateString = _dateFormat.format(date);    
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PostToJson(this);
}