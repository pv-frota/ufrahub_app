import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_ufra_app/application/view/integracao_sigaa/atendimento/atendimento.dart';
import 'package:placeholder_ufra_app/application/view/integracao_sigaa/atendimento/aviso.dart';
import 'package:placeholder_ufra_app/application/view/integracao_sigaa/atendimento/fim_atendimento.dart';

class SigaaAtendimentoLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [
        '/ufrapp/integracao-sigaa/atendimento',
        '/ufrapp/integracao-sigaa/atendimento/enviar',
        '/ufrapp/integracao-sigaa/atendimento/enviado',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('atendimento'),
        title: 'Aviso - Atendimento ao Aluno',
        type: BeamPageType.noTransition,
        child: SigaaAviso(),
      ),
      if (state.uri.pathSegments.contains('enviar'))
        const BeamPage(
          key: ValueKey('enviar'),
          title: 'Enviar - Atendimento ao Aluno',
          type: BeamPageType.noTransition,
          child: SigaaAtendimento(),
        ),
      if (state.uri.pathSegments.contains('enviado'))
        const BeamPage(
          key: ValueKey('enviado'),
          title: 'Enviado - Atendimento ao Aluno',
          type: BeamPageType.noTransition,
          child: SigaaFimAtendimento(),
        )
    ];
  }
}
