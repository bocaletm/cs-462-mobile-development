
import 'package:test/test.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/post_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('initialization and parsing:', () {
    var dateString = '2020-03-14 15:11:40.615156';
    var url = 'www.test.com';  
    var date = DateTime.parse('2020-03-14 15:11:40.615156');   
    var count = 1;
    var latitude = 1.0;
    var longitude = 1.0;    
    final testPost = Post(url,date,count,'title',latitude,longitude);
   
    test('initialization', () {     
        expect(testPost.imageUrl, isNotNull);
        expect(testPost.date, isNotNull);
        expect(testPost.dateString, isNotNull);
        expect(testPost.count, isNotNull);
        expect(testPost.latitude, isNotNull);
        expect(testPost.longitude, isNotNull);
        expect(testPost.date.toString(), equals(dateString)); 
    });
    test('parsing', () {
      var jsonPost = testPost.toJson();
      jsonPost['date'] = Timestamp.fromDate(date); //mimic date returned from firebase
      var postFromJson = PostController.postFromData(jsonPost);

      expect(postFromJson.date, equals(testPost.date));
      expect(postFromJson.dateString, equals(testPost.dateString));
      expect(postFromJson.imageUrl, equals(testPost.imageUrl));
      expect(postFromJson.count, equals(testPost.count));
      expect(postFromJson.latitude, equals(testPost.longitude));
      expect(postFromJson.name, equals(testPost.name));
    });
  });  
}