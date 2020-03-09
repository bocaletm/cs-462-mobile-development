import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/helpers/exceptions.dart';
import 'package:wasteagram/models/post.dart';


class PostController {

  static const String firestoreCollection = 'posts';
  static const String firestoreCounter = 'counter';

  Post _post;

  String getLastUploaded() => _post?.imageUrl != null ? _post?.imageUrl : '';

  Future createPost(String title) async {
    try {
      final LocationData _locationData = await _getLatitudeAndLongitude();
      await _uploadImage(_locationData.latitude,_locationData.longitude,title);
      await _addToDB();
    } catch(e) {
      print(e);
    }
  }
  
  Future _uploadImage(double latitude, double longitude, String title) async {
    var image;
    String url;
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference storageReference = 
      FirebaseStorage.instance.ref().child('${title}_${DateTime.now().millisecondsSinceEpoch.toString()}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();
    print('Successfully uploaded $url');

    if (url.isNotEmpty) {
      _post = Post(url,DateTime.now(), 0,title,latitude,longitude);
      print('Populated Post object');
      print(_post.toJson().toString());
    } else {
      if (image == null) throw ImageUploadException('ImagePicker error, image is null');
      if (storageReference == null) throw ImageUploadException('unable to obtain storage reference');
      throw ImageUploadException('unable to obtain image url from storage');
    }
  }

  Future<LocationData> _getLatitudeAndLongitude() async {

    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw LocationServicesException('service not enabled');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        throw LocationServicesException('location permission not granted');
      }
    }
    return location.getLocation();
  }

  Future _addToDB() async {
    Timestamp _postDate =  Timestamp.fromMillisecondsSinceEpoch(_post.date.millisecondsSinceEpoch);
    await Firestore.instance.collection(firestoreCollection).document()
      .setData({ 
        'imageUrl': _post.imageUrl,
        'date': _postDate, 
        'count': _post.count, 
        'name': _post.name, 
        'latitude': _post.latitude,
        'longitude': _post.longitude,
      });
    print('Successfully wrote post \'${_post.name}\' to database');
  }

  Stream<QuerySnapshot> readPosts() {
    Firestore.instance.collection(firestoreCollection).snapshots();
  }

  void incrementCounter() async {
    await Firestore.instance
        .collection(firestoreCounter)
        .document(firestoreCounter)
        .updateData({
          "counter":FieldValue.increment(1)
        });
  }

  Future<dynamic> getNumPosts() async {

    var count = Firestore.instance
        .collection(firestoreCounter)
        .orderBy(firestoreCounter)
        .limit(1)
        .getDocuments()
        .then( (snapshot) => snapshot.documents[0].data[firestoreCounter]);
    return count;
  }
}