import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/controller/home/classes/module_info.dart';
import 'package:beamer/beamer.dart';

const _integracaoSigaaModuleInfo = ModuleInfo(
  "Integração Sigaa",
  "Módulo de informações do aluno, comunicação e emissão de documentos.",
  "/ufrapp/login/sigaa",
);
const _localicazaoBajeModuleInfo = ModuleInfo(
  "Onde está o Bajé?",
  "Módulo de localização do transporte da UFRA.",
  "/ufrapp/baje",
);
const _segurancaUfraModuleInfo = ModuleInfo(
  "Chamar Segurança",
  "Módulo de Alertar Segurança da UFRA.",
  "/ufrapp/login/seguranca",
);

final homeControllerProvider = ChangeNotifierProvider<HomeController>(
  (ref) => HomeController(),
);

class HomeController extends ChangeNotifier {
  final modules = [
    _integracaoSigaaModuleInfo,
    _localicazaoBajeModuleInfo,
    _segurancaUfraModuleInfo,
  ];

  int get moduleCount => modules.length;

  void navigateToModule(BuildContext context, String path) {
    context.beamToNamed(path);
  }
}
