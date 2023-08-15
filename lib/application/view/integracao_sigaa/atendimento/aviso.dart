import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/component/generic/single_child_flexible_row.dart';
import 'package:placeholder_ufra_app/application/component/generic/ufra_app_bar.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';

class SigaaAviso extends ConsumerWidget {
  const SigaaAviso({Key? key}) : super(key: key);

  void irAtender(BuildContext context) {
    Beamer.of(context).beamToNamed('/ufrapp/integracao-sigaa/atendimento/enviar');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarUfra(),
      body: Column(
        children: [
          const Spacer(
            flex: 5,
          ),
          SingleChildFlexibleRow(
            horizontalFlex: ref.read(layoutProvider).isMobile ? 90 : 60,
            child: const SingleChildScrollView(
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'AVISO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 5,
          ),
          SingleChildFlexibleRow(
              horizontalFlex: ref.read(layoutProvider).isMobile ? 90 : 60,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: const [
                  SizedBox(
                    child: Card(
                      color: Color(0xFFb5b551),
                      child: ListTile(
                          title: Text(
                              'Atendimento ao Aluno é um canal de comunicação entre o estudante e a coordenação.\n'
                              'Este canal de relacionamento foi desenvolvido para que você possa entrar em contato com a Coordenacao e tirar todas as dúvidas.\n'
                              'A mensagem de resposta será enviada para seu email cadastrado no SIGAA.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontStyle: FontStyle.italic))),
                    ),
                  )
                ],
              )),
          const Spacer(
            flex: 20,
          ),
          SingleChildFlexibleRow(
            horizontalFlex: 90,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () => irAtender(context),
                child: const Text('Continuar'),
              ),
            ),
          ),
          const Spacer(
            flex: 10,
          )
        ],
      ),
    );
  }
}
