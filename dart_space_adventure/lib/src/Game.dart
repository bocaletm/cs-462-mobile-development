import 'dart:core';
import 'dart:io';
import 'package:dart_space_adventure/space_adventure.dart';

class Game {
  final Message _message;
  Planets _planets;
  String _username;
  String _selection;

  Game() : _message = Message(), _username = 'Roger Wilco', _selection = '' {
    try {
      _planets = Planets();
    } 
    catch (e) {
      print(e.errMsg());
    }
  }

  void runGame() async {
    startGame();
    await readPlanets();
    getUserName();
    greetUser();
    useRandomPlanets();
  }

  void getUserName() {
    _message.printMessage(MessageType.nameprompt);
    _username = stdin.readLineSync();
  }
  void greetUser() {
    _message.printMessage(MessageType.greeting,_username);
  }

  void readPlanets() async {
    await _planets.populateFromAPI();
    if (_planets.complete != true) {
      _planets.populateFromStaticJson('.');
    }
  }

  void useRandomPlanets() {
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
    if (_selection  == 'Y') {
      _message.printMessage(MessageType.randomprompt);
      print(_planets.getRandom());
    } else if (_selection  == 'N') {
      _message.printMessage(MessageType.planetprompt);
      print(_planets.getUserSelection(stdin.readLineSync()));
    }
  }

  void startGame() {
    _message.printMessage(MessageType.intro);
  }
}