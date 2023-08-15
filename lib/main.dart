import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';
import 'package:placeholder_ufra_app/application/controller/login/login_provider.dart';
import 'package:placeholder_ufra_app/application/router/routes.dart';
import 'package:placeholder_ufra_app/domain/provider/util/http_client_provider.dart';

import 'package:placeholder_ufra_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  final routeConfiguration = createRouteConfiguration(container.read);

  const bool isProduction = bool.fromEnvironment('dart.vm.product');

  if (isProduction) {
    await dotenv.load(fileName: ".env.prd");
  } else {
    await dotenv.load(fileName: ".env.dev");
  }

  container.read(httpClientProvider.notifier).initialize();
  container.read(loginControllerProvider.notifier).initialize();

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
  }

  runApp(
    getApp(container, routeConfiguration),
  );
}

Widget getApp(ProviderContainer container, BeamerDelegate routeConfiguration) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: routeConfiguration,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routeConfiguration,
      ),
      builder: (context, router) => getBuilder(container, context, router),
    ),
  );
}

Widget getBuilder(
    ProviderContainer container, BuildContext context, Widget? router) {
  final layoutController = container.read(layoutProvider.notifier);

  if (!layoutController.initialized) {
    layoutController.initialize(context);
  }

  return router!;
}
