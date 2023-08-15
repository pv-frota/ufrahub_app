import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';

class AnimatedCheckIcon extends StatefulWidget {
  final double size;
  final Color color;

  const AnimatedCheckIcon({
    required this.color,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedCheckIconState createState() => _AnimatedCheckIconState();
}

class _AnimatedCheckIconState extends State<AnimatedCheckIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCirc));
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return AnimatedCheck(
      progress: _animation,
      color: widget.color,
      size: widget.size,
    );
  }
}
