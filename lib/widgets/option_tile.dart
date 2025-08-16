import 'package:flutter/material.dart';
import 'package:quiz_app_latex/widgets/latex_text.dart';

class OptionTile extends StatelessWidget {
  final String label;
  final bool selected;
  final bool correct;
  final bool locked;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.label,
    required this.selected,
    required this.correct,
    required this.locked,
    required this.onTap
  });

  Color _color(BuildContext context){
    if(selected && correct) return Colors.green.withOpacity(.25);
    if(selected && !correct) return Colors.red.withOpacity(.25);
    return Theme.of(context).colorScheme.surfaceContainerHighest;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: locked ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: _color(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0,2),
            ),
          ],
        ),
        child: LatexText(
          tex: label,
          style: Theme.of(context).textTheme.bodyLarge ?? const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
