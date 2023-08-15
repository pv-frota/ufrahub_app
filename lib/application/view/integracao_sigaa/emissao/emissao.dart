import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';
import 'package:placeholder_ufra_app/application/component/generic/ufra_app_bar.dart';
import 'package:placeholder_ufra_app/application/controller/integracao_sigaa/emissao/classes/sigaa_tipo_documento.dart';
import 'package:placeholder_ufra_app/application/controller/integracao_sigaa/emissao/sigaa_emissao_provider.dart';

class Emissao extends ConsumerWidget {
  final TipoDocumentoEnum tipoDocumento;

  const Emissao(this.tipoDocumento, {Key? key}) : super(key: key);

  void download(BuildContext context, WidgetRef ref) {
    try {
      ref.read(sigaaEmissaoControllerProvider(tipoDocumento)).downloadPdf();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Download feito com sucesso."),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized =
        ref.watch(sigaaEmissaoControllerProvider(tipoDocumento)).isInitialized;
    if (!isInitialized) {
      ref.read(sigaaEmissaoControllerProvider(tipoDocumento)).initialize();
    }
    return Scaffold(
      appBar: AppBarUfra(
        actions: [
          IconButton(
              onPressed: () => download(context, ref),
              icon: Icon(
                Icons.download,
                color: Theme.of(context).brightness != Brightness.light
                    ? Colors.white
                    : Colors.black,
              ))
        ],
      ),
      body: !isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Builder(
              builder: (context) {
                final pdfController = ref
                    .read(sigaaEmissaoControllerProvider(tipoDocumento))
                    .controller;
                return Stack(
                  children: [
                    PdfView(
                      controller: pdfController,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: PdfPageNumber(
                        controller: pdfController,
                        // When `loadingState != PdfLoadingState.success`  `pagesCount` equals null_
                        builder: (_, state, page, pagesCount) {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Página $page/${pagesCount ?? 0}',
                              style: const TextStyle(fontSize: 22),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
