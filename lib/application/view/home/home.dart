import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/component/home/module_list.dart';
import 'package:placeholder_ufra_app/application/component/generic/single_child_flexible_row.dart';
import 'package:placeholder_ufra_app/application/component/generic/ufra_gradient.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: UfraGradient(
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Flexible(
                flex: ref.read(layoutProvider).isMobile ? 8 : 5,
                child: Image.asset('assets/logo.png'),
              ),
              const Spacer(
                flex: 20,
              ),
              Flexible(
                flex: 50,
                child: SingleChildFlexibleRow(
                  horizontalFlex: ref.read(layoutProvider).isMobile ? 90 : 50,
                  child: const ModuleList(),
                ),
              ),
              const Spacer(
                flex: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
