import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:core';
import 'dart:io';

enum MessageType {
  intro,
  greeting,
  nameprompt,
  randomprompt,
  planetprompt,
  misunderstood
}

class Message {
  void printMessage(MessageType message, [String username]) {
    switch (message) {
      case MessageType.intro:
        print(
          'Welcome to the Solar System!\n'
          'There are 9 planets to explore.'
        );
        break;
      case MessageType.greeting:
        var name = 'Roger Wilco';
        if (username != null) {
          name = username;
        }
        print(
          'Nice to meet you, $name. My name is Eliza, '
          'I\'m an old friend of Alexa\n'
          'Let\'s go on an adventure!'
        );
        break;
      case MessageType.nameprompt:
        print('What is your name?');
        break;
      case MessageType.randomprompt:
        print('Shall I randomly choose a planet for you to visit? (Y or N)');
        break;
      case MessageType.planetprompt:
        print('Name the planet you would like to visit');
        break;
      case MessageType.misunderstood:
        print('Sorry. I didn\'t get that');
        break;
    }
  }

  void printPlanets(Planets planets){
    print('printing planets');
  }
}
class RestException implements Exception {
  var _code;
  String errMsg() => 'Rest call error code: $_code';

  RestException(String code) {
    _code = code;
  }
}

class Planets {
  static const String _planets_uri = 'https://swapi.co/api/planets/';
  static const int _numPlanets = 9;
  bool _complete = true;
  Map<String,String> _planetList;

  void populateFromStaticJson(String json_filepath) {
    print('using static json');
  }

  void populateFromAPI() async{
    var client = http.Client();
    var response;
    var jsonParsed;
    String url;
    for (var i = 1; i <= _numPlanets; i++) {
      url = '$_planets_uri$i';
      response = null;
      try{
        response = await client.get(url);
      } 
      catch(e) {
        _complete = false;
      }
      if (response.statusCode == 200) {
        jsonParsed = convert.jsonDecode(response.body);
        //_planetList.putIfAbsent(jsonParsed['name'],jsonParsed['climate']);
        var name = jsonParsed['name'];
        var climate = jsonParsed['climate'];
        print('name: $name  climate: $climate');
      } else {
        _complete = false;
        throw RestException(response.statusCode);
      }
    }
  }
}

class Game {
  Message _message;
  Planets _planets;
  String _username;
  String _selection;

  Game(){
    _message = Message();
    _username = 'Roger Wilco';
    _selection = null;
    try {
      _planets = Planets();
    } 
    catch (e) {
      print(e.errMsg());
    }
  }

  void startGame() async {
    _message.printMessage(MessageType.intro);
    _message.printMessage(MessageType.nameprompt);
    _username = stdin.readLineSync();
    _message.printMessage(MessageType.greeting,_username);
    _message.printMessage(MessageType.randomprompt);
    var invalidSelection = true;
    while (invalidSelection) {
      _selection  = stdin.readLineSync();
      _selection  = _selection.toUpperCase();
      invalidSelection = _selection  != 'Y' && _selection  != 'N'; 
      if (invalidSelection) {
        _message.printMessage(MessageType.misunderstood);
      }
    }
    await _planets.populateFromAPI();
    if (_planets._complete != true) {
      _planets.populateFromStaticJson('.');
    }

    if (_selection  == 'Y') {
      _message.printMessage(MessageType.randomprompt);
    } else if (_selection  == 'N') {
      _message.printMessage(MessageType.planetprompt);
      //_message.printPlanets(this._planets);
    }
  }
}
