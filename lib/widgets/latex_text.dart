import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class LatexText extends StatelessWidget {
  final String tex;
  final TextStyle? style;
  const LatexText({super.key, required this.tex, this.style});

  @override
  Widget build(BuildContext context) {
    return TeXView(
      child: TeXViewDocument(
        tex,
        style: TeXViewStyle(
          padding: TeXViewPadding.all(8),
          backgroundColor: Colors.transparent,
        ),
      ),
      style: TeXViewStyle(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
