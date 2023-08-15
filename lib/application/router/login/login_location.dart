import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_ufra_app/application/view/login/login.dart';

class LoginLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/ufrapp/login/:destino'];

  String _getDestination(pathParam) {
    if (pathParam != null) {
      switch (pathParam) {
        case 'sigaa':
          return '/ufrapp/integracao-sigaa/inicio';
        default:
          return '/404';
      }
    }
    return "";
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pathParam = state.pathParameters['destino'];
    String destino = _getDestination(pathParam);

    return [
      BeamPage(
        key: const ValueKey('login'),
        title: 'Login - Ufrapp',
        child: Login(destino),
      )
    ];
  }
}
