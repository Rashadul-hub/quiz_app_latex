import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String label;
  final bool selected;
  final bool correct;
  final bool locked;
  final VoidCallback onTap;
  const OptionTile({super.key, required this.label, required this.selected, required this.correct, required this.locked, required this.onTap});


  Color _color(BuildContext context){
    if(locked) return Theme.of(context).colorScheme.surfaceContainerHighest;
    if(correct) return Colors.green;
    if(selected) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
