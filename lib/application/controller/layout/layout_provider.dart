import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_ufra_app/application/controller/layout/classes/responsive_constraints.dart';
import 'package:placeholder_ufra_app/application/controller/layout/classes/screen_size.dart';

final layoutProvider =
    StateNotifierProvider<LayoutController, ResponsiveConstraints>(
        (ref) => LayoutController());

class LayoutController extends StateNotifier<ResponsiveConstraints> {
  LayoutController() : super(ResponsiveConstraints(mostCommonScreenSize));

  bool initialized = false;

  void initialize(BuildContext context) {
    state = ResponsiveConstraints(
      Screen(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
    initialized = true;
  }
}
