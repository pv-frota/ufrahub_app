import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';
import 'package:placeholder_ufra_app/application/controller/login/classes/login_exceptions.dart';
import 'package:placeholder_ufra_app/application/controller/login/classes/login_state.dart';
import 'package:placeholder_ufra_app/domain/dto/CredentialsDTO.dart';
import 'package:placeholder_ufra_app/domain/provider/auth_provider.dart';
import 'package:placeholder_ufra_app/domain/provider/util/http_client_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
        (ref) => LoginController(ref));

class LoginController extends StateNotifier<LoginState> {
  final Ref _ref;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioTextEditingController =
      TextEditingController();
  final TextEditingController _senhaTextEditingController =
      TextEditingController();
  final ScrollController _loginScrollController = ScrollController();

  LoginController(this._ref) : super(LoggedOutState());

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get usuarioController => _usuarioTextEditingController;
  TextEditingController get senhaController => _senhaTextEditingController;
  ScrollController get loginScrollController => _loginScrollController;

  void initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final String? usuario = prefs.getString('usuario');

    if (usuario != null) _usuarioTextEditingController.text = usuario;
  }

  Future<void> login() async {
    state = LoggingInState();
    String usuario = _usuarioTextEditingController.text;
    String senha = _senhaTextEditingController.text;

    final response = await _ref.read(authProvider).login(usuario, senha);

    if(response is CredentialsDTO) {
      _senhaTextEditingController.value = TextEditingValue.empty;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('usuario', response.username);
      _ref.read(httpClientProvider.notifier).afterLogin(response.accessToken);

      state = LoggedInState(
        usuario: response.username,
        token: 'Bearer ${response.accessToken}',
        matricula: response.matricula,
        curso: response.curso,
        nivel: response.nivel,
        ira: response.ira,
        mc: response.mc,
      );
    } else {
      state = LoggedOutState();
      _senhaTextEditingController.value = TextEditingValue.empty;
      throw CredentialsException(message: "Usuário ou senha incorretos.");
    }
  }

  void scrollOnFocus() {
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        final offset = _ref.read(layoutProvider).height / 10;
        Future.delayed(
          const Duration(milliseconds: 300),
          () => _loginScrollController.animateTo(
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
    _usuarioTextEditingController.dispose();
    _senhaTextEditingController.dispose();
    _loginScrollController.dispose();
    super.dispose();
  }
}
