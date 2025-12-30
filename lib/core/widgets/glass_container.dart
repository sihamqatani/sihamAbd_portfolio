import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/purple_theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? color;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 20.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.08)
                : PurpleTheme.primaryPurple
                    .withOpacity(0.08), // Stronger shadow in light mode
            blurRadius: 32,
            spreadRadius: 2, // Tighter spread for more defined look
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color ??
                  (isDark
                      ? Colors.white.withOpacity(0.07)
                      : Colors.white.withOpacity(
                          0.85)), // More solid in light mode for better contrast
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.2)
                    : PurpleTheme.primaryPurple
                        .withOpacity(0.15), // Clearer border
                width: 1.5, // Slightly thicker border for definition
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.05),
                      ]
                    : [
                        Colors.white.withOpacity(
                            0.4), // Reflection gleam for light mode
                        Colors.white.withOpacity(0.1),
                      ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
