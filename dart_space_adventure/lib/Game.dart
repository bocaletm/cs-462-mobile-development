
import 'dart:core';
import 'dart:io';
import 'package:dart_space_adventure/Message.dart';
import 'package:dart_space_adventure/Planets.dart';

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
    if (_planets.complete != true) {
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
