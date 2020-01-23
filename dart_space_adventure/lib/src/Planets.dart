import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dart_space_adventure/space_adventure.dart';
import 'dart:math';

class Planets {
  final String planetsUri;
  String systemName;
  static const int numPlanets = 9;
  static const int timesToTry = 10;
  bool complete;
  final Map<String,String> _planetList;

  Planets(this.planetsUri) : complete = false, _planetList = new Map(), systemName = 'Galaxy Far, Far Away';

  String get numPlanetsStr {
    return numPlanets.toString();
  }

  List getRandom() {
    var nameDescription = List(2);
    var randKey = _planetList.keys.elementAt(Random().nextInt(_planetList.length));
    nameDescription[0] = randKey;
    nameDescription[1] = _planetList[randKey];
    return nameDescription;
  }

  List getUserSelection(String planetName) {
    var nameDescription = List(2);
    var description = 'Nothing is known about this planet';
    if (_planetList.containsKey(planetName)) {
      description = _planetList[planetName];
    } 
    nameDescription[0] = planetName;
    nameDescription[1] = description;
    return nameDescription;
  }

  void populateFromStaticJson() async{
    var jsonParsed;
    try {
      jsonParsed = convert.jsonDecode(await File(planetsUri).readAsString());
      systemName = jsonParsed['name'];
      for (var entry in jsonParsed['planets']) {
          var name = entry['name'];
          var description = entry['description'];
          _planetList[name.toString()] = description.toString();
      }
      complete = true;
    } catch(e) {
      stderr.write('ERROR: Could not read file at $planetsUri\n');
      complete = false;
    }
  }
  
  void getNameDescriptionFromJson(var jsonParsed) {
    var name = jsonParsed['name'];
    var climate = jsonParsed['climate'];
    var terrain = jsonParsed['terrain'];
    var size = '';
    if (int.parse(jsonParsed['diameter']) < 10000) {
      size = 'small,';
    } else if (int.parse(jsonParsed['diameter']) < 100000) {
      size = 'medium,';
    } else {
      size = 'giant,';
    }
    _planetList[name.toString()] = 'A $size distant, $climate planet composed of $terrain';
  }

  void populateFromAPI() async{
    var client = http.Client();
    var response;
    complete = true;
    String url;
    for (var i = 1; i <= numPlanets; i++) {
      url = '$planetsUri$i';
      response = null;
      try{
        response = await client.get(url);
        if (response == null) {
          throw RestException('null');
        }
        if (response.statusCode == 200) {
          getNameDescriptionFromJson(convert.jsonDecode(response.body));
        } else {
          throw RestException(response.statusCode);
        }
      } catch(e) {
          complete = false;
          if (e is SocketException) {
            stderr.write('ERROR: Unable to reach $url\n');
          } else if (e is RestException){
            stderr.write(e.errMsg());
          } else {
            stderr.write('ERROR: Unknown\n');
          }
      }
    }
  }
}