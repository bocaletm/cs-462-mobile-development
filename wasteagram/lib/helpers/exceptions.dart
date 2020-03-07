class RestException implements Exception {
  final _code;
  final String _uri;
  String errMsg() => 'Rest call error code: $_code trying to reach $_uri\n';

  RestException(this._code, this._uri);
}

class LocationServicesException implements Exception {
  final String _msg;
  String errMsg() => 'Unable to obtain location data: $_msg\n';

  LocationServicesException(this._msg);
}

class ImageUploadException implements Exception {
  final String _msg;
  String errMsg() => 'Unable to upload image: $_msg\n';

  ImageUploadException(this._msg);
}

