import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:placeholder_ufra_app/application/router/routes.dart';
import 'package:placeholder_ufra_app/domain/dto/CredentialsDTO.dart';
import 'package:placeholder_ufra_app/domain/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/login.mocks.dart';

void main() {
  late ProviderContainer container;
  final MockAuthProvider mockAuth = MockAuthProvider();

  setUp(() {
    SharedPreferences.setMockInitialValues({});

    container = ProviderContainer(
      overrides: [
        authProvider.overrideWithValue(mockAuth),
      ],
    );
    addTearDown(container.dispose);
  });

  testWidgets("login success", (tester) async {
    final routeConfiguration = createRouteConfiguration(container.read);

    when(
      mockAuth.login("pv_frota", "pedro123"),
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

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routeInformationParser: BeamerParser(),
          routerDelegate: routeConfiguration,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final moduleSigaaButton = find.byKey(const ValueKey("module0"));
    await tester.tap(moduleSigaaButton);
    await tester.pumpAndSettle();

    final userFormField = find.byKey(const ValueKey("userFormField"));
    final passwordFormField = find.byKey(const ValueKey("passwordFormField"));
    final loginButton = find.byKey(const ValueKey("loginButton"));
    await tester.enterText(userFormField, 'pv_frota');
    await tester.enterText(passwordFormField, 'pedro123');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text("Matrícula"), findsOneWidget);
  });

  testWidgets("login failed", (tester) async {
    final routeConfiguration = createRouteConfiguration(container.read);

    when(
      mockAuth.login("pv_frota", "pedro123"),
    ).thenAnswer(
      (_) => Future.value({} as dynamic),
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routeInformationParser: BeamerParser(),
          routerDelegate: routeConfiguration,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final moduleSigaaButton = find.byKey(const ValueKey("module0"));
    await tester.tap(moduleSigaaButton);
    await tester.pumpAndSettle();

    final userFormField = find.byKey(const ValueKey("userFormField"));
    final passwordFormField = find.byKey(const ValueKey("passwordFormField"));
    final loginButton = find.byKey(const ValueKey("loginButton"));
    await tester.enterText(userFormField, 'pv_frota');
    await tester.enterText(passwordFormField, 'pedro123');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text("Usuário ou senha incorretos."), findsOneWidget);
  });
}
