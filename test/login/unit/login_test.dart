import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:placeholder_ufra_app/application/controller/login/classes/login_exceptions.dart';
import 'package:placeholder_ufra_app/application/controller/login/classes/login_state.dart';
import 'package:placeholder_ufra_app/application/controller/login/login_provider.dart';
import 'package:placeholder_ufra_app/domain/dto/CredentialsDTO.dart';
import 'package:placeholder_ufra_app/domain/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../listener.dart';
import '../mocks/login.mocks.dart';

void main() {
  late ProviderContainer container;
  late Listener<LoginState> listener;
  final MockAuthProvider mockAuth = MockAuthProvider();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    listener = Listener<LoginState>();

    container = ProviderContainer(
      overrides: [
        authProvider.overrideWithValue(mockAuth),
      ],
    );
    addTearDown(container.dispose);

    container.listen(
      loginControllerProvider,
      listener,
      fireImmediately: true,
    );
  });

  test("login success", () async {
    final underTest = container.read(loginControllerProvider.notifier);

    when(
      mockAuth.login("", ""),
    ).thenAnswer(
      (_) => Future.value(
        CredentialsDTO.named(
            name: "Pedro",
            username: "pv_frota",
            roles: [],
            accessToken: "accessToken",
            tokenType: "tokenType",
            matricula: "matricula",
            curso: "curso",
            nivel: "nivel",
            ira: 1,
            mc: 1) as dynamic,
      ),
    );
    await underTest.login();

    verifyInOrder([
      listener(null, LoggedOutState()),
      listener(LoggedOutState(), LoggingInState()),
      listener(
          LoggingInState(),
          LoggedInState(
            usuario: "pv_frota",
            token: "tokenType",
            matricula: "matricula",
            nivel: "nivel",
            curso: "curso",
            ira: 1,
            mc: 1,
          ))
    ]);
    verifyNoMoreInteractions(listener);
    verify(mockAuth.login("", "")).called(1);
  });

  test("login failed", () async {
    final underTest = container.read(loginControllerProvider.notifier);

    when(
      mockAuth.login("", ""),
    ).thenAnswer(
      (_) => Future.value({} as dynamic),
    );

    expect(() async => await underTest.login(),
        throwsA(isA<CredentialsException>()));
    verifyInOrder([
      listener(null, LoggedOutState()),
      listener(LoggedOutState(), LoggingInState()),
    ]);
    verifyNoMoreInteractions(listener);
    verify(mockAuth.login("", "")).called(1);
  });
}
