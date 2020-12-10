import 'package:flutter/material.dart';
import 'dart:math' as math;

class SubmenuFab extends StatefulWidget {
  final List<IconData> icons;
  final List<String> tooltips;
  final IconData mainIcon;
  final List<VoidCallback> pressHandlers;
  SubmenuFab({
    @required this.icons,
    @required this.mainIcon,
    @required this.pressHandlers,
    @required this.tooltips,
  }) : assert(icons.length == pressHandlers.length && icons.length == tooltips.length);
  @override
  _SubmenuFabState createState() => _SubmenuFabState();
}

class _SubmenuFabState extends State<SubmenuFab> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var icons = widget.icons;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(icons.length, (int index) {
        Widget child = Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Interval(0.0, 1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut),
            ),
            child: Tooltip(
              message: widget.tooltips[index],
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.white,
                mini: true,
                child: Icon(
                  icons[index],
                  color: Colors.blue,
                ),
                onPressed: widget.pressHandlers[index],
              ),
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          FloatingActionButton(
            heroTag: null,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Transform(
                  transform:
                      Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: Icon(
                      _controller.isDismissed ? widget.mainIcon : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
    );
  }
}
