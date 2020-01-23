enum MessageType {
  intro,
  greeting,
  nameprompt,
  randomprompt,
  planetprompt,
  misunderstood,
  traveling,
  arrived
}

class Message {
  bool printMessage(MessageType message, {
      String userName = 'Roger Wilco', 
      String systemName = 'Unnamed System', 
      String planetName = 'Unexplored Planet',
      String planetDescription = 'Nothing is known about this planet.',
      String numPlanets = '0'
  }) {
    switch (message) {
      case MessageType.intro:
        print(
          'Welcome to the $systemName!\n'
          'There are $numPlanets planets to explore.'
        );
        break;
      case MessageType.greeting:
        print(
          'Nice to meet you, $userName. My name is Eliza, '
          'I\'m an old friend of Alexa.\n'
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
        print('Name the planet you would like to visit.');
        break;
      case MessageType.misunderstood:
        print('Sorry. I didn\'t get that.');
        break;
      case MessageType.traveling:
        print('Traveling to $planetName...');
        break;
      case MessageType.arrived:
        print('Arrived at $planetName. $planetDescription.');
        break;
    }
    return true;
  }
}