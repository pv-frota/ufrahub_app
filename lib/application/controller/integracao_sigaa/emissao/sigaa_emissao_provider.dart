import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_file/internet_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:placeholder_ufra_app/application/controller/integracao_sigaa/emissao/classes/sigaa_tipo_documento.dart';
import 'package:placeholder_ufra_app/application/controller/login/classes/login_state.dart';
import 'package:placeholder_ufra_app/application/controller/login/login_provider.dart';

final sigaaEmissaoControllerProvider = ChangeNotifierProvider.autoDispose
    .family<SigaaEmissaoController, TipoDocumentoEnum>(
  (ref, tipo) => SigaaEmissaoController(ref, tipo),
);

class SigaaEmissaoController extends ChangeNotifier {
  final Ref _ref;
  final String _path = '/api/aluno/arquivo';

  PdfController? _pdfController;
  late Uint8List _file;
  final TipoDocumentoEnum _tipoDocumento;

  SigaaEmissaoController(this._ref, this._tipoDocumento);

  bool get isInitialized => _pdfController != null;

  PdfController get controller => _pdfController!;

  void initialize() async {
    String urlBase = dotenv.get('API_URL');
    LoggedInState infoLogin =
        _ref.read(loginControllerProvider) as LoggedInState;
    String usuario = infoLogin.usuario;
    String url = urlBase + _path + '?usuario=$usuario';

    if (_tipoDocumento == TipoDocumentoEnum.vinculo) {
      _file = await InternetFile.get(
        url + '&tipoArquivo=VINCULO',
        headers: {'Authorization': infoLogin.token},
      );
    } else {
      _file = await InternetFile.get(
        url + '&tipoArquivo=HISTORICO',
        headers: {'Authorization': infoLogin.token},
      );
    }

    _pdfController =
        PdfController(document: PdfDocument.openData(_file), initialPage: 0);
    notifyListeners();
  }

  void downloadPdf() async {
    Directory? directory;
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists())
        directory = await getExternalStorageDirectory();
    }
    File file =
        await File('${directory?.path}/${_tipoDocumento.name}.pdf').create();
    file.writeAsBytesSync(_file);
  }

  @override
  void dispose() {
    _pdfController!.dispose();
    super.dispose();
  }
}
