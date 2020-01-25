class RestException implements Exception {
  final _code;
  final String _uri;
  String errMsg() => 'Rest call error code: $_code trying to reach $_uri\n';

  RestException(this._code, this._uri);
}