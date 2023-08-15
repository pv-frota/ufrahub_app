import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/controller/navigation/navigation_controller_provider.dart';
import 'package:placeholder_ufra_app/theme.dart';

class AppBarUfra extends ConsumerWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const AppBarUfra({this.actions, Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      toolbarHeight: 55,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          height: 45,
        ),
      ),
      leading: buildLeading(context, ref),
      actions: actions,
    );
  }

  Widget buildLeading(BuildContext context, WidgetRef ref) {
    NavigationController controller = ref.read(navigationController);
    if (!controller.showBackButton(context)) {
      return Container();
    } else {
      return BackButton(
        color: Theme.of(context).brightness == Brightness.light
            ? lightSwatch.shade200
            : lightSwatch.shade600,
        onPressed: () => controller.goBack(context),
      );
    }
  }
}
