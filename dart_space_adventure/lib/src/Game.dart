import 'dart:core';
import 'dart:io';
import 'package:dart_space_adventure/space_adventure.dart';

class Game {
  final Message _message;
  Planets _planets;
  String _username;
  String _selection;

  Game(String planetsUri) : _message = Message(), _username = 'Roger Wilco', _selection = '' {
    try {
      _planets = Planets(planetsUri);
    } 
    catch (e) {
      stderr.write('ERROR: Unable to instantiate Planets\n');
    }
  }

  void runGame() async {
    await readPlanets();
    startGame();
    getUserName();
    greetUser();
    useRandomPlanets();
  }

  void getUserName() {
    _message.printMessage(MessageType.nameprompt);
    _username = stdin.readLineSync();
  }

  void greetUser() {
    _message.printMessage(MessageType.greeting,userName: _username);
  }

  void readPlanets() async {
    if (_planets.planetsUri.contains('http')) { 
      await _planets.populateFromAPI();
    } else {
      await _planets.populateFromStaticJson();
    }

    if (_planets.complete != true) {
      stderr.write('ERROR: Unable to read planet data\n');
      exit(1);
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
    List nameDescription;
    if (_selection  == 'Y') {
      _message.printMessage(MessageType.randomprompt);
      nameDescription = _planets.getRandom();
    } else if (_selection  == 'N') {
      _message.printMessage(MessageType.planetprompt);
      nameDescription = _planets.getUserSelection(stdin.readLineSync());
    }
    _message.printMessage(MessageType.traveling, planetName: nameDescription[0]);
    _message.printMessage(MessageType.arrived, planetName: nameDescription[0], planetDescription: nameDescription[1]);
  }

  void startGame() {
    _message.printMessage(MessageType.intro,systemName: _planets.systemName);
  }
}