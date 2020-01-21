class RestException implements Exception {
  var _code;
  String errMsg() => 'Rest call error code: $_code\n';

  RestException(String code) {
    _code = code;
  }
}