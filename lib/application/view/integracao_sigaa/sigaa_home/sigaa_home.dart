import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/component/generic/ufra_app_bar.dart';
import 'package:placeholder_ufra_app/application/controller/integracao_sigaa/home/sigaa_home_provider.dart';
import 'package:placeholder_ufra_app/application/router/integracao_sigaa/sigaa_home_tabs/sigaa_documentos_location.dart';
import 'package:placeholder_ufra_app/application/router/integracao_sigaa/sigaa_home_tabs/sigaa_inicio_location.dart';

class SigaaHome extends ConsumerWidget {
  SigaaHome({Key? key}) : super(key: key);

  final _beamerDelegate = BeamerDelegate(
    initialPath: '/ufrapp/integracao-sigaa/inicio',
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [SigaaInicioLocation(), SigaaDocumentosLocation()],
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarUfra(),
      body: Beamer(
        key: ref.read(sigaaHomeNavigationKeyProvider),
        routerDelegate: _beamerDelegate,
      ),
      bottomNavigationBar: _createNavigationBar(ref),
    );
  }

  Widget _createNavigationBar(WidgetRef ref) {
    return BottomNavigationBar(
      currentIndex: ref.watch(sigaaHomeNavigationIndexProvider),
      onTap: (index) => navigateBetweenItems(index, ref),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_present),
          label: 'Documentos',
        ),
      ],
    );
  }

  navigateBetweenItems(int index, WidgetRef ref) {
    final currentBeamLocation = ref
        .read(sigaaHomeNavigationKeyProvider)
        .currentState
        ?.routerDelegate
        .currentBeamLocation;
    if (currentBeamLocation is SigaaInicioLocation && index != 0 ||
        currentBeamLocation is SigaaDocumentosLocation && index != 1) {
      ref.read(sigaaHomeNavigationIndexProvider.state).state = index;
      ref
          .read(sigaaHomeNavigationKeyProvider)
          .currentState!
          .routerDelegate
          .beamToNamed(index == 0 ? '/ufrapp/integracao-sigaa/inicio' : '/ufrapp/integracao-sigaa/documentos');
    }
  }
}
