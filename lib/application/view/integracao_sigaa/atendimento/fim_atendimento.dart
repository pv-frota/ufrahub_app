import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/component/generic/animated_check_icon.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';

class SigaaFimAtendimento extends ConsumerWidget {
  const SigaaFimAtendimento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 3), () => Beamer.of(context).beamToReplacementNamed('/ufrapp/integracao-sigaa/inicio'));
    return Scaffold(
      body: Container(
        color: Colors.green,
        height: ref.read(layoutProvider).height,
        width: ref.read(layoutProvider).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: AnimatedCheckIcon(color: Colors.yellowAccent, size: 200),
            ),
          ],
        ),
      ),
    );
  }
}
