import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_ufra_app/application/controller/integracao_sigaa/emissao/classes/sigaa_tipo_documento.dart';
import 'package:placeholder_ufra_app/application/view/integracao_sigaa/emissao/emissao.dart';

class SigaaEmissaoLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/ufrapp/integracao-sigaa/emissao/:tipo'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pathParam = state.pathParameters['tipo'];
    TipoDocumentoEnum? tipoDocumento;
    if(pathParam != null) {
      switch(pathParam) {
        case 'vinculo':
          tipoDocumento = TipoDocumentoEnum.vinculo;
          break;
        case 'historico':
          tipoDocumento = TipoDocumentoEnum.historico;
          break;
      }
    }
    final tipo = tipoDocumento ?? TipoDocumentoEnum.vinculo;
    return [
      BeamPage(
        key: const ValueKey('emissao'),
        title: 'Emissão de Documento',
        child: Emissao(tipo),
      )
    ];
  }
}
