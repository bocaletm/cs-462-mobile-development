import 'package:dart_space_adventure/Planets.dart';

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