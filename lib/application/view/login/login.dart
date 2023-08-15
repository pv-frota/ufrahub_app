import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/component/login/login_form.dart';
import 'package:placeholder_ufra_app/application/component/generic/single_child_flexible_row.dart';
import 'package:placeholder_ufra_app/application/component/generic/ufra_gradient.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';
import 'package:placeholder_ufra_app/application/controller/login/login_provider.dart';

class Login extends ConsumerWidget {
  final String destino;

  const Login(this.destino, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
          controller:
              ref.read(loginControllerProvider.notifier).loginScrollController,
          child: UfraGradient(
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Flexible(
                  flex: ref.read(layoutProvider).isMobile ? 8 : 5,
                  child: Image.asset('assets/logo.png'),
                ),
                const Spacer(
                  flex: 20,
                ),
                Flexible(
                  flex: 50,
                  child: SingleChildFlexibleRow(
                    horizontalFlex: ref.read(layoutProvider).isMobile ? 60 : 30,
                    child: Card(
                      child: LoginForm(destino),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
