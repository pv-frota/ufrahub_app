import 'package:flutter/material.dart';

class SingleChildFlexibleRow extends StatelessWidget {
  final int horizontalFlex;
  final Widget child;
  final MainAxisAlignment mainAxisAlignment;

  const SingleChildFlexibleRow({
    required this.horizontalFlex,
    required this.child,
    this.mainAxisAlignment = MainAxisAlignment.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidget();
  }

  Row buildWidget() {
    if(horizontalFlex < 100) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Spacer(
            flex: calculateRemaining(),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: horizontalFlex,
            child: child,
          ),
          Spacer(
            flex: calculateRemaining(),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: horizontalFlex,
            child: child,
          ),
        ],
      );
    }
  }

  int calculateRemaining() {
    return ((100 - horizontalFlex) / 2).ceil();
  }
}
