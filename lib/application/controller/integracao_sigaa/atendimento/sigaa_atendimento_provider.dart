import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/controller/integracao_sigaa/atendimento/classes/sigaa_atendimento_exceptions.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';
import 'package:placeholder_ufra_app/application/controller/login/classes/login_state.dart';
import 'package:placeholder_ufra_app/application/controller/login/login_provider.dart';
import 'package:placeholder_ufra_app/domain/provider/util/http_client_provider.dart';

final sigaaAtendimentoControllerProvider =
    ChangeNotifierProvider.autoDispose<SigaaAtendimentoController>(
        (ref) => SigaaAtendimentoController(ref));

class SigaaAtendimentoController extends ChangeNotifier {
  final Ref _ref;
  final String _path = '/api/aluno/mensagem';

  bool isEnviando = false;

  final GlobalKey<FormState> _formAtendKey = GlobalKey<FormState>();
  final TextEditingController _tituloEditingController =
      TextEditingController();
  final TextEditingController _perguntaEditingController =
      TextEditingController();
  final ScrollController _atendimentoScrollController = ScrollController();

  SigaaAtendimentoController(this._ref);

  GlobalKey<FormState> get formAtendKey => _formAtendKey;

  TextEditingController get tituloController => _tituloEditingController;

  TextEditingController get perguntaController => _perguntaEditingController;

  ScrollController get atendimentoScrollController =>
      _atendimentoScrollController;

  Future<void> enviar() async {
    LoggedInState infoLogin =
        _ref.read(loginControllerProvider) as LoggedInState;
    isEnviando = true;
    notifyListeners();
    String titulo = _tituloEditingController.text;
    String pergunta = _perguntaEditingController.text;
    try {
      final response = await _ref.read(httpClientProvider).post(_path, {
        "username": infoLogin.usuario,
        "title": titulo,
        "question": pergunta,
      });
    } on Exception catch (e) {
      isEnviando = false;
      notifyListeners();
      _tituloEditingController.value = TextEditingValue.empty;
      _perguntaEditingController.value = TextEditingValue.empty;
      throw QuestionsException(message: 'Ocorreu um erro.');
    }
    isEnviando = false;
    notifyListeners();
  }

  void scrollOnFocus() {
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        final offset = _ref.read(layoutProvider).height / 20;
        Future.delayed(
          const Duration(milliseconds: 500),
          () => atendimentoScrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _tituloEditingController.dispose();
    _perguntaEditingController.dispose();
    _atendimentoScrollController.dispose();
    super.dispose();
  }
}
