import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dart_space_adventure/space_adventure.dart';
import 'dart:math';

class Planets {
  static const String _planets_uri = 'https://swapi.co/api/planets/';
  static const int _numPlanets = 8;
  static const int timesToTry = 10;
  bool complete;
  Map<String,String> _planetList;

  Planets() : complete = false, _planetList = new Map();

  List getRandom() {
    var nameDescription = List(2);
    var randKey = _planetList.keys.elementAt(Random().nextInt(_planetList.length));
    nameDescription[0] = randKey;
    nameDescription[1] = _planetList[randKey];
    return nameDescription;
  }

  List getUserSelection(String planetName) {
    var nameDescription = List(2);
    var description = 'mysterious';
    if (_planetList.containsKey(planetName)) {
      description = _planetList[planetName];
    } 
    nameDescription[0] = planetName;
    nameDescription[1] = description;
    return nameDescription;
  }

  void populateFromStaticJson(String jsonFilepath) async{
    print('using static json');
    var jsonParsed;
    try {
      jsonParsed = convert.jsonDecode(await File(jsonFilepath).readAsString())['planets'];
      for (var entry in jsonParsed) {
          var name = entry['name'];
          var description = entry['description'];
          _planetList[name.toString()] = description.toString();
      }
      complete = true;
    } catch(e) {
      stderr.write('ERROR: Could not read file at $jsonFilepath\n');
      complete = false;
    }
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
        if (response == null) {
          throw RestException('null');
        }
        if (response.statusCode == 200) {
          jsonParsed = convert.jsonDecode(response.body);
          var name = jsonParsed['name'];
          var climate = jsonParsed['climate'].toString();
          _planetList[name.toString()] = 'A distant, $climate planet';
        } else {
          throw RestException(response.statusCode);
        }
      } catch(e) {
          complete = false;
          if (e is SocketException) {
            stderr.write('ERROR: Unable to reach $url\n');
          } else {
            stderr.write(e.errMsg());
          }
      }
    }
  }
}