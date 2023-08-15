import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sigaaHomeNavigationIndexProvider = StateProvider<int>((ref) => 0);
final sigaaHomeNavigationKeyProvider = StateProvider<GlobalKey<BeamerState>>((ref) => GlobalKey<BeamerState>());