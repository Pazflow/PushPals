import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color foregroundColor;
  final ShapeBorder shape;
  final EdgeInsetsGeometry? padding;
  final String? tooltip;

  const FloatingButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 56,
    this.iconSize = 24,
    this.backgroundColor = Colors.white,
    this.foregroundColor = const Color(0xFF2196F3),
    this.shape = const CircleBorder(),
    this.padding,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: shape,
        tooltip: tooltip,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Icon(icon, size: iconSize),
        ),
      ),
    );
  }
}
