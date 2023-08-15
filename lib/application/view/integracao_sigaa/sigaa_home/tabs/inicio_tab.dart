import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/component/generic/aluno_descricao.dart';
import 'package:placeholder_ufra_app/application/component/generic/single_child_flexible_row.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';
import 'package:placeholder_ufra_app/application/controller/login/classes/login_state.dart';
import 'package:placeholder_ufra_app/application/controller/login/login_provider.dart';

class Usuario extends ConsumerWidget {
  const Usuario({Key? key}) : super(key: key);

  void irAvisar(BuildContext context) {
    Beamer.of(context).root.beamToNamed('/ufrapp/integracao-sigaa/atendimento');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoggedInState user = ref.read(loginControllerProvider) as LoggedInState;
    return Column(
      children: [
        const Spacer(
          flex: 1,
        ),
        Flexible(
          flex: 30,
          child: SingleChildFlexibleRow(
            horizontalFlex: ref.read(layoutProvider).isMobile ? 80 : 60,
            child: CircleAvatar(
              backgroundImage: Image.asset('assets/usuario.png').image,
              backgroundColor: Colors.green,
              radius: 120,
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Flexible(
          flex: 40,
          child: SingleChildFlexibleRow(
            horizontalFlex: ref.read(layoutProvider).isMobile ? 80 : 60,
            child: SizedBox(
              height: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      AlunoDescricao(
                          title: "Matrícula", subtitle: user.matricula),
                      const Spacer(
                        flex: 1,
                      ),
                      AlunoDescricao(title: "Curso", subtitle: user.curso),
                      const Spacer(
                        flex: 1,
                      ),
                      AlunoDescricao(title: "Nível", subtitle: user.nivel),
                      const Spacer(
                        flex: 1,
                      ),
                      AlunoDescricao(title: "MC", subtitle: user.mc.toString()),
                      const Spacer(
                        flex: 1,
                      ),
                      AlunoDescricao(
                          title: "IRA", subtitle: user.ira.toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 20,
          child: SingleChildFlexibleRow(
            horizontalFlex: ref.read(layoutProvider).isMobile ? 80 : 60,
            child: Card(
              child: InkWell(
                splashColor: Colors.green,
                onTap: () => irAvisar(context),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.chat, size: 35.0),
                    title: Text('Atendimento ao Aluno'),
                    subtitle: Text(
                        'Acessar tela de enviar suas perguntas à coordenação.'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
