import 'package:dart_space_adventure/space_adventure.dart';
import 'dart:io';

void main(List<String> arguments) { 
  if (arguments.isEmpty || arguments.length > 1) {
    stderr.write('ERROR USAGE: dart main.dart <PLANETS_URI>\n');
    exit(1);
  }
  final game = Game(arguments[0]);
  game.runGame();
}