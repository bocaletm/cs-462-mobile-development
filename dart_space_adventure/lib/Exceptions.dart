class RestException implements Exception {
  var _code;
  String errMsg() => 'Rest call error code: $_code';

  RestException(String code) {
    _code = code;
  }
}