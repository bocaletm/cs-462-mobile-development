import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {

  group('counter: ', () {

    final counterTextFinder = find.byValueKey('post_list_title');
    final numPostsFinder = find
      .byType('ListTile')
      .serialize()
      .keys
      .length
      .toString();

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test('title counter matches number of tiles', () async {
      expect(await driver.getText(counterTextFinder), contains(numPostsFinder));
    });

  });

}