import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:string_validator/string_validator.dart' as string_validator;
import 'dart:convert' as convert;
import 'package:dart_space_adventure/space_adventure.dart';
import 'dart:math';

class Planets {
  static const int timesToTry = 10;
  final Map<String,String> _planetList;
  final String planetsUri;
  String systemName;
  int _apiPlanetCount;
  bool complete;
  
  Planets(this.planetsUri) : complete = false, _planetList = new Map(), systemName = 'Galaxy Far, Far Away';

  void getApiPlanetCount() async {
    var client = http.Client();
    try {
      var response = await client.get(planetsUri);
      if (response == null) {
        throw RestException(response,planetsUri);
      }
      if (response.statusCode == 200) {
        _apiPlanetCount = convert.jsonDecode(response.body)['count'].toInt();
      } else {
        print(response.statusCode);
        throw RestException(response.statusCode,planetsUri);
      }
    } catch(e) {
      if (e is SocketException) {
        stderr.write('ERROR: Unable to reach $planetsUri\n');
      } else if (e is RestException){
        stderr.write(e.errMsg());
      } else {
        stderr.write('ERROR: Unknown\n');
        stderr.write(e);
      }
    }
  }

  int get numPlanets => _planetList.length;

  String get numPlanetsStr => numPlanets.toString();

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
    var diameter = jsonParsed['diameter'];
    if (string_validator.isAlpha(diameter)) {
      size = diameter;
    } else if (int.parse(diameter) < 10000) {
      size = 'small,';
    } else if (int.parse(diameter) < 100000) {
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
    await getApiPlanetCount();
    for (var i = 1; i <= _apiPlanetCount; i++) {
      url = '$planetsUri$i';
      response = null;
      try{
        response = await client.get(url);
        if (response == null) {
          throw RestException(response,url);
        }
        if (response.statusCode == 200) {
           getNameDescriptionFromJson(convert.jsonDecode(response.body));
        } else {
          print(response.statusCode);
          throw RestException(response.statusCode,url);
        }
      } catch(e) {
        complete = false;
        if (e is SocketException) {
          stderr.write('ERROR: Unable to reach $url\n');
        } else if (e is RestException){
          stderr.write(e.errMsg());
        } else {
          stderr.write('ERROR: Unknown\n');
          stderr.write(e);
        }
      }
    }
  }
}