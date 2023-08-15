import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/component/generic/single_child_flexible_row.dart';
import 'package:placeholder_ufra_app/application/component/generic/ufra_app_bar.dart';
import 'package:placeholder_ufra_app/application/controller/integracao_sigaa/atendimento/sigaa_atendimento_provider.dart';
import 'package:placeholder_ufra_app/application/controller/integracao_sigaa/atendimento/classes/sigaa_atendimento_exceptions.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';

class SigaaAtendimento extends ConsumerWidget {
  const SigaaAtendimento({Key? key}) : super(key: key);

  void enviar(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(sigaaAtendimentoControllerProvider.notifier).enviar();
      context.beamToNamed('/ufrapp/integracao-sigaa/atendimento/enviado');
    } on QuestionsException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ocorreu um erro."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarUfra(),
      body: SingleChildScrollView(
        physics:
            const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        controller: ref
            .read(sigaaAtendimentoControllerProvider.notifier)
            .atendimentoScrollController,
        child: SizedBox(
          height: ref.read(layoutProvider).height - 55,
          child: Form(
            key: ref.read(sigaaAtendimentoControllerProvider).formAtendKey,
            child: Column(
              children: [
                const Spacer(
                  flex: 3,
                ),
                SingleChildFlexibleRow(
                    horizontalFlex: ref.read(layoutProvider).isMobile ? 80 : 60,
                    child: TextFormField(
                      controller: ref
                          .read(sigaaAtendimentoControllerProvider.notifier)
                          .tituloController,
                      onTap: () => ref
                          .read(sigaaAtendimentoControllerProvider.notifier)
                          .scrollOnFocus(),
                      validator: (value) => validatorTitulo(value),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Informe um Título *',
                      ),
                    )),
                const Spacer(
                  flex: 1,
                ),
                SingleChildFlexibleRow(
                    horizontalFlex: ref.read(layoutProvider).isMobile ? 80 : 60,
                    child: TextFormField(
                      controller: ref
                          .read(sigaaAtendimentoControllerProvider.notifier)
                          .perguntaController,
                      onTap: () => ref
                          .read(sigaaAtendimentoControllerProvider.notifier)
                          .scrollOnFocus(),
                      validator: (value) => validatorPergunta(value),
                      maxLines: null,
                      minLines: 9,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Elabore sua Pergunta *',
                      ),
                    )),
                const Spacer(
                  flex: 3,
                ),
                SingleChildFlexibleRow(
                  horizontalFlex: 90,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => validarForm(context, ref),
                      child: ref.watch(sigaaAtendimentoControllerProvider).isEnviando
                          ? const CircularProgressIndicator()
                          : const Text('Enviar'),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validarForm(BuildContext context, WidgetRef ref) {
    FocusScope.of(context).unfocus();
    if (ref
        .read(sigaaAtendimentoControllerProvider)
        .formAtendKey
        .currentState!
        .validate()) {
      enviar(context, ref);
    }
  }

  String? validatorPergunta(String? value) {
    return (value == null || value.isEmpty)
        ? 'Favor fornecer uma Pergunta.'
        : null;
  }

  String? validatorTitulo(String? value) {
    return (value == null || value.isEmpty)
        ? 'Favor fornecer um Título.'
        : null;
  }
}
