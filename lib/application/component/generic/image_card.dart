import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/component/generic/single_child_flexible_row.dart';
import 'package:placeholder_ufra_app/application/controller/layout/layout_provider.dart';

class ImageCard extends ConsumerWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final void Function() onTap;

  const ImageCard({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: ref.read(layoutProvider).height * 0.15,
      child: Card(
        elevation: 5,
        child: InkWell(
          splashColor: Colors.green,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(ref.read(layoutProvider).width * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: ref.read(layoutProvider).isMobile ? ref.read(layoutProvider).width * 0.30 : ref.read(layoutProvider).width * 0.05,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  width: ref.read(layoutProvider).width * 0.02,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      SingleChildFlexibleRow(
                        mainAxisAlignment: MainAxisAlignment.start,
                        horizontalFlex: 100,
                        child: Text(title),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      SingleChildFlexibleRow(
                        mainAxisAlignment: MainAxisAlignment.start,
                        horizontalFlex: 100,
                        child: Text(subtitle),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
