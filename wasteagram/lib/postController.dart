import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/models/post.dart';

class PostController {
  Post _post;

  Future uploadImage() async {
    var image;
    String url;
    try {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      StorageReference storageReference = 
        FirebaseStorage.instance.ref().child(new DateTime.now().millisecondsSinceEpoch.toString());
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      final url = await storageReference.getDownloadURL();
      print('Successfully uploaded $url');
    } catch(e) {
      print('ERROR: uploadImage() failed');
      print(e);
    }

    if (url.isNotEmpty) {
      _post = Post(url,DateTime.now(), 0,'title',0,0);
      try {
        await _addToDB();
        await _getLatitudeAndLongitude();
      } catch (e) {

      }
    } 
  }

  Future _getLatitudeAndLongitude() {

  }

  Future _addToDB() async {
    
  }
  


}