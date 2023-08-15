import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart' hide find;
import '../test/login/integration/login_test.dart';


void main() {
  final moduleSigaaButton = find.byValueKey("module0");
  final userFormField = find.byValueKey("userFormField");
  final passwordFormField = find.byValueKey("passwordFormField");
  final loginButton = find.byValueKey("loginButton");

  late FlutterDriver driver;

  Future<bool> isPresent(SerializableFinder byValueKey,
      {Duration timeout = const Duration(seconds: 1)}) async {
    try {
      await driver.waitFor(byValueKey, timeout: timeout);
      return true;
    } catch (exception) {
      return false;
    }
  }

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    driver.close();
  });

  test('login success', () async {
    final widgetInSequence = [
      moduleSigaaButton,
      userFormField,
      passwordFormField,
      loginButton,
    ];
    final underTest = LoginTest(driver, widgetInSequence);
    await underTest.firstTest();
    expect(isPresent(find.text("Matrícula")), true);
  });
}
