import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dart_space_adventure/space_adventure.dart';

class Planets {
  static const String _planets_uri = 'https://swapi.co/api/planets/';
  static const int _numPlanets = 9;
  bool complete;
  Map<String,String> _planetList;

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
        //_planetList.putIfAbsent(jsonParsed['name'],jsonParsed['climate']);
        var name = jsonParsed['name'];
        var climate = jsonParsed['climate'];
        print('name: $name  climate: $climate');
      } else {
        complete = false;
        throw RestException(response.statusCode);
      }
    }
  }
}