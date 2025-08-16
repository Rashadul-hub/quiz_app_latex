import 'package:flutter/material.dart';
import 'package:latext/latext.dart';


class LatexText extends StatelessWidget {
  final String? tex;
  final TextStyle? style;

  const LatexText({super.key, required this.tex, this.style});

  @override
  Widget build(BuildContext context) {
    final safeTex = tex?.trim();
    if (safeTex == null || safeTex.isEmpty) {
      return Text(" ", style: style ?? const TextStyle(fontSize: 16));
    }

    return LaTexT(
      laTeXCode: Text(
        safeTex,
        style: style ?? const TextStyle(fontSize: 16),
      ),
    );
  }
}