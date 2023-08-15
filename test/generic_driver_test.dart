import 'package:flutter_driver/flutter_driver.dart';

class GenericDriverTest {
  final FlutterDriver _driver;
  final List<SerializableFinder> _widgets;

  GenericDriverTest(this._driver, this._widgets);

  FlutterDriver get driver => _driver;
  List<SerializableFinder> get widgets => _widgets;
}