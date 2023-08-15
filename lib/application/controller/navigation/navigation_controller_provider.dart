import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/router/integracao_sigaa/sigaa_atendimento_location.dart';
import 'package:placeholder_ufra_app/application/router/integracao_sigaa/sigaa_emissao_location.dart';

final navigationController =
    Provider.autoDispose<NavigationController>((ref) => NavigationController());

class NavigationController {

  bool showBackButton(BuildContext context) {
    return context.currentBeamLocation is SigaaAtendimentoLocation || context.currentBeamLocation is SigaaEmissaoLocation;
  }

  void goBack(BuildContext context) {
    if(Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Beamer.of(context).beamBack();
    }
  }

}
