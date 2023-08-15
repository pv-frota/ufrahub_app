import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_ufra_app/application/view/integracao_sigaa/sigaa_home/tabs/inicio_tab.dart';

class SigaaInicioLocation extends BeamLocation {
  @override
  List<Pattern> get pathPatterns => ['/ufrapp/integracao-sigaa/inicio'];

  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [
      const BeamPage(
        key: ValueKey('inicio'),
        title: 'Início',
        type: BeamPageType.material,
        child: Usuario(),
      )
    ];
  }
}
