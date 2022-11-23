import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBlock1 extends StatelessWidget {
  const BlurredBlock1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: const Center(
            child: Text('Blurred block 1'),
          ),
        ),
      ),
    );
  }
}
