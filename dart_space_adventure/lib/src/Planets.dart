import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dart_space_adventure/space_adventure.dart';

class Planets {
  static const String _planets_uri = 'https://swapi.co/api/planets/';
  static const int _numPlanets = 9;
  bool complete;
  final Map<String,String> _planetList = new Map();

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
      print(_planetList);
    }
  }
}