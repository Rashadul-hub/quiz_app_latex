import 'package:flutter/material.dart';
import 'package:quiz_app_latex/widgets/latex_text.dart';

// class OptionTile extends StatelessWidget {
//   final String label;
//   final bool selected;
//   final bool correct;
//   final bool locked;
//   final VoidCallback onTap;
//
//   const OptionTile({
//     super.key,
//     required this.label,
//     required this.selected,
//     required this.correct,
//     required this.locked,
//     required this.onTap
//   });
//
//   Color _color(BuildContext context){
//     if(selected && correct) return Colors.green.withOpacity(.25);
//     if(selected && !correct) return Colors.red.withOpacity(.25);
//     return Theme.of(context).colorScheme.surfaceContainerHighest;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: locked ? null : onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         decoration: BoxDecoration(
//           color: _color(context),
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//             color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
//             width: 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(0,2),
//             ),
//           ],
//         ),
//         child: LatexText(
//           tex: label,
//           style: Theme.of(context).textTheme.bodyLarge ?? const TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }
// }


class OptionTile extends StatefulWidget {
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
    required this.onTap,
  });

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 60),
      lowerBound: 0.0,
      upperBound: 0.05,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _backgroundColor(BuildContext context) {
    if (widget.selected && widget.correct) {
      return Colors.green.withOpacity(0.2);
    }
    if (widget.selected && !widget.correct) {
      return Colors.red.withOpacity(0.2);
    }
    return Theme.of(context).colorScheme.surface;
  }

  LinearGradient _gradient() {
    if (widget.selected && widget.correct) {
      return const LinearGradient(colors: [Colors.greenAccent, Colors.green]);
    }
    if (widget.selected && !widget.correct) {
      return const LinearGradient(colors: [Colors.redAccent, Colors.red]);
    }
    return const LinearGradient(colors: [Colors.white, Colors.white]);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        if (!widget.locked) widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 - _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.045,
            horizontal: screenWidth * 0.04,
          ),
          margin: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
          decoration: BoxDecoration(
            gradient: _gradient(),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: LatexText(
            tex: widget.label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}