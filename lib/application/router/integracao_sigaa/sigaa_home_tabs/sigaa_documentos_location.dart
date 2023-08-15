import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_ufra_app/application/view/integracao_sigaa/sigaa_home/tabs/documentos_tab.dart';

class SigaaDocumentosLocation extends BeamLocation {
  @override
  List<Pattern> get pathPatterns => ['/ufrapp/integracao-sigaa/documentos'];

  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [
      const BeamPage(
        key: ValueKey('documentos'),
        title: 'Emissão de Documentos',
        type: BeamPageType.material,
        child: Documentos(),
      )
    ];
  }
}
