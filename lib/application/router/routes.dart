import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/controller/login/classes/login_state.dart';
import 'package:placeholder_ufra_app/application/controller/login/login_provider.dart';
import 'package:placeholder_ufra_app/application/router/integracao_sigaa/sigaa_atendimento_location.dart';
import 'package:placeholder_ufra_app/application/router/integracao_sigaa/sigaa_emissao_location.dart';
import 'package:placeholder_ufra_app/application/router/home/home_location.dart';
import 'package:placeholder_ufra_app/application/router/integracao_sigaa/sigaa_home_location.dart';
import 'package:placeholder_ufra_app/application/router/login/login_location.dart';

BeamerDelegate createRouteConfiguration(Reader read) {
  return BeamerDelegate(
    initialPath: '/ufrapp/home',
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        LoginLocation(),
        SigaaHomeLocation(),
        SigaaAtendimentoLocation(),
        SigaaEmissaoLocation(),
      ]
    ),
    guards: [
      BeamGuard(
        pathPatterns: [
          '/ufrapp/integracao-sigaa/**'
        ],
        check: (_, __) => read(loginControllerProvider) is LoggedInState,
        beamToNamed: (origin, target) => '/ufrapp/home',
      ),
    ],
  );
}