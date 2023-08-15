import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/theme.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';

class UfraGradient extends ConsumerWidget {
  final Widget child;

  const UfraGradient({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: child,
      height:
          ref.read(layoutProvider).height - MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.01, 1],
          colors: [
            Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black12,
            Theme.of(context).brightness == Brightness.light
                ? lightSwatch.shade200
                : lightSwatch.shade600,
          ],
        ),
      ),
    );
  }
}
