
import 'package:placeholder_ufra_app/application/controller/layout/classes/screen_size.dart';

class ResponsiveConstraints {
  final Screen screen;
  ResponsiveConstraints(this.screen);

  double get width => screen.width;
  double get height => screen.height;

  bool get isMobile => width < 600;
}