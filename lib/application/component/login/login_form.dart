import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/component/generic/single_child_flexible_row.dart';
import 'package:placeholder_ufra_app/application/controller/login/classes/login_exceptions.dart';
import 'package:placeholder_ufra_app/application/controller/login/classes/login_state.dart';
import 'package:placeholder_ufra_app/application/controller/login/login_provider.dart';

class LoginForm extends ConsumerWidget {
  final String destino;

  const LoginForm(this.destino, {Key? key}) : super(key: key);

  void login(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(loginControllerProvider.notifier).login();
      context.beamToNamed(destino);
    } on CredentialsException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.read(loginControllerProvider.notifier).formKey,
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          SingleChildFlexibleRow(
            horizontalFlex: 90,
            child: TextFormField(
              key: const ValueKey("userFormField"),
              controller:
                  ref.read(loginControllerProvider.notifier).usuarioController,
              onTap: () =>
                  ref.read(loginControllerProvider.notifier).scrollOnFocus(),
              validator: (value) => validatorNome(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome de Usuário',
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          SingleChildFlexibleRow(
            horizontalFlex: 90,
            child: TextFormField(
              key: const ValueKey("passwordFormField"),
              controller:
                  ref.read(loginControllerProvider.notifier).senhaController,
              onTap: () =>
                  ref.read(loginControllerProvider.notifier).scrollOnFocus(),
              validator: (value) => validatorSenha(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
            ),
          ),
          const Spacer(
            flex: 10,
          ),
          SingleChildFlexibleRow(
            horizontalFlex: 90,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                key: const ValueKey("loginButton"),
                onPressed: () => onClickEntrar(context, ref),
                child: ref.watch(loginControllerProvider) is LoggingInState
                    ? const CircularProgressIndicator()
                    : const Text('Entrar'),
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  void onClickEntrar(BuildContext context, WidgetRef ref) {
    FocusScope.of(context).unfocus();
    if (ref
        .read(loginControllerProvider.notifier)
        .formKey
        .currentState!
        .validate()) {
      login(context, ref);
    }
  }

  String? validatorSenha(String? value) {
    return (value == null || value.isEmpty) ? 'Favor inserir senha.' : null;
  }

  String? validatorNome(String? value) {
    return (value == null || value.isEmpty)
        ? 'Favor inserir nome de usuário.'
        : null;
  }
}
