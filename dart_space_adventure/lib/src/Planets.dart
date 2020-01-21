import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dart_space_adventure/space_adventure.dart';

class Planets {
  static const String _planets_uri = 'https://swapi.co/api/planets/';
  static const int _numPlanets = 8;
  static const int timesToTry = 10;
  bool complete;
  final Map<String,String> _planetList;

  Planets() : complete = false, _planetList = new Map();

  String getRandom() {
    var error = true;
    for (var i = 0; i < timesToTry; i++) {
      if (complete) {
        return 'random';
        error = false;
      } 
      if (error) {
        throw Exception('ERROR: Could not load planet info.');
      }
    }
  }

  String getUserSelection(String planetName) {
    return '$planetName';
  }

  void populateFromStaticJson(String json_filepath) {
    print('using static json');
  }

  void populateFromAPI() async{
    var client = http.Client();
    var response;
    var jsonParsed;
    complete = true;
    String url;
    for (var i = 1; i <= _numPlanets; i++) {
      url = '$_planets_uri$i';
      response = null;
      try{
        response = await client.get(url);
      } 
      catch(e) {
        complete = false;
      }
      if (response.statusCode == 200) {
        jsonParsed = convert.jsonDecode(response.body);
        var name = jsonParsed['name'];
        var climate = jsonParsed['climate'];
        _planetList[name.toString()] = climate.toString();
      } else {
        complete = false;
        throw RestException(response.statusCode);
      }
    }
  }
}