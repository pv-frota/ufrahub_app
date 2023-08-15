import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_ufra_app/application/view/integracao_sigaa/sigaa_home/sigaa_home.dart';

class SigaaHomeLocation extends BeamLocation {
  @override
  List<Pattern> get pathPatterns => [
        '/ufrapp/integracao-sigaa/inicio',
        '/ufrapp/integracao-sigaa/documentos',
      ];

  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [
      BeamPage(
        key: const ValueKey('sigaa'),
        title: 'Início - Integração Sigaa',
        child: SigaaHome(),
      )
    ];
  }
}
