import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/component/generic/image_card.dart';
import 'package:placeholder_ufra_app/application/component/generic/single_child_flexible_row.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';

class Documentos extends ConsumerWidget {
  const Documentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SingleChildFlexibleRow(
            horizontalFlex: ref.read(layoutProvider).isMobile ? 95 : 30,
            child: ImageCard(
              title: "Declaração de Vínculo",
              subtitle:
                  "Trata-se de um documento que atesta um vínculo entre a universidade e o discente.",
              imagePath: "assets/teste.png",
              onTap: () => navigateVinculo(context),
            ),
          ),
          SingleChildFlexibleRow(
            horizontalFlex: ref.read(layoutProvider).isMobile ? 95 : 30,
            child: ImageCard(
              title: "Histórico Escolar",
              subtitle:
                  "Trata-se de um documento que exibe informações sobre o discente e o seu progresso no curso.",
              imagePath: "assets/teste2.png",
              onTap: () => navigateHistorico(context),
            ),
          ),
        ],
      ),
    );
  }

  void navigateHistorico(BuildContext context) {
    return Beamer.of(context)
                .root
                .beamToNamed('/ufrapp/integracao-sigaa/emissao/historico');
  }

  void navigateVinculo(BuildContext context) {
    return Beamer.of(context)
                .root
                .beamToNamed('/ufrapp/integracao-sigaa/emissao/vinculo');
  }
}
