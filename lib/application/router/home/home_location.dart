import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_ufra_app/application/view/home/home.dart';

class HomeLocation extends BeamLocation {
  @override
  List<Pattern> get pathPatterns => ['/ufrapp/home'];

  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [
      const BeamPage(
        key: ValueKey('home'),
        title: 'Home - Ufrapp',
        child: Home(),
      )
    ];
  }
}
