import 'package:flutter/material.dart';
import 'package:quiz_app_latex/widgets/latex_text.dart';

class OptionTile extends StatelessWidget {
  final String label;
  final bool selected;
  final bool correct;
  final bool locked;
  final VoidCallback onTap;
  const OptionTile({super.key, required this.label, required this.selected, required this.correct, required this.locked, required this.onTap});


  Color _color(BuildContext context){
    if(locked) return Theme.of(context).colorScheme.surfaceContainerHighest;
    if(selected && correct) return Colors.green.withOpacity(.2);
    if(selected && !correct) return Colors.red.withOpacity(.2);
    if(correct) return Colors.green.withOpacity(.15);
    return Theme.of(context).colorScheme.surfaceContainerHighest;
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: locked? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        margin:  const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: _color(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: LatexText(
          tex: label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
