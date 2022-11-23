import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBlock0 extends StatelessWidget {
  const BlurredBlock0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          top: 100,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: size.width,
                height: 100,
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.5)),
                child: const Center(
                  child: Text('Blurred block 0'),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
