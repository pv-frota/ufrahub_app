import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/controller/home/home_provider.dart';
import 'package:placeholder_ufra_app/theme.dart';

class ModuleList extends ConsumerWidget {
  const ModuleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: ref.read(homeControllerProvider).moduleCount,
      itemExtent: 100,
      itemBuilder: (context, index) {
        final module = ref.read(homeControllerProvider).modules[index];
        final keyValue = "module" + index.toString();
        return Card(
          elevation: 5,
          child: InkWell(
            key: ValueKey(keyValue),
            splashColor: Colors.green,
            onTap: () => ref
                .read(homeControllerProvider)
                .navigateToModule(context, module.caminhoInicial),
            child: Center(
              child: ListTile(
                title: Text(module.nome),
                subtitle: Text(module.descricao),
              ),
            ),
          ),
          color: Theme.of(context).brightness != Brightness.light
              ? index % 2 == 0
                  ? lightSwatch.shade900
                  : lightSwatch.shade700
              : index % 2 == 0
                  ? lightSwatch.shade300
                  : lightSwatch.shade100,
        );
      },
    );
  }
}
