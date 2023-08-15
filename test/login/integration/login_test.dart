import '../../generic_driver_test.dart';

class LoginTest extends GenericDriverTest {
  LoginTest(super.driver, super.widgets);

  Future<void> firstTest() async  {
    await driver.tap(widgets[0]);
    await driver.waitFor(widgets[1]);

    await driver.tap(widgets[1]);
    await driver.enterText("pv_frota");
    await driver.tap(widgets[2]);
    await driver.enterText("pedro123");

    await driver.tap(widgets[3]);
  }
}


