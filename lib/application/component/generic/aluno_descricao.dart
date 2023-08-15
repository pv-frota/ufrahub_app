import 'package:flutter/material.dart';
import 'package:placeholder_ufra_app/application/component/generic/single_child_flexible_row.dart';

class AlunoDescricao extends StatelessWidget {
  final String title;
  final String subtitle;

  const AlunoDescricao({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildFlexibleRow(
      horizontalFlex: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}
