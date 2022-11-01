import 'package:flutter/material.dart';

class Moveable extends StatefulWidget {
  final Widget child;

  final Offset initPosition;

  const Moveable({
    Key? key,
    required this.child,
    required this.initPosition,
  }) : super(key: key);

  @override
  State<Moveable> createState() => _MoveableState();
}

class _MoveableState extends State<Moveable> {
  double _x = 0.0;

  double _y = 0.0;

  @override
  void initState() {
    super.initState();

    _x = widget.initPosition.dx;
    _y = widget.initPosition.dy;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _y,
          left: _x,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _y += details.delta.dy;
                _x += details.delta.dx;
              });
            },
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
