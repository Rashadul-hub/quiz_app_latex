import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class LatexText extends StatelessWidget {
  final String tex;
  final TextStyle? style;
  const LatexText({super.key, required this.tex, this.style});

  @override
  Widget build(BuildContext context) {
    return Math.tex(tex, textStyle: style);
  }
}
