import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/purple_theme.dart';

class PurpleLoadingIndicator extends StatelessWidget {
  const PurpleLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A0710),
                  Color(0xFF130B1D),
                  Color(0xFF07050A)
                ],
                stops: [0.0, 0.5, 1.0],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFBEDEF),
                  Color(0xFFFFF5F7),
                  Color(0xFFFBEDEF)
                ],
                stops: [0.0, 0.5, 1.0],
              ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildAnimatedRing(
                      size: 100,
                      color: Theme.of(context).primaryColor,
                      duration: 1500.ms,
                      reverse: false),
                  _buildAnimatedRing(
                      size: 75,
                      color: PurpleTheme.lightPurple,
                      duration: 1200.ms,
                      reverse: true),
                  _buildAnimatedRing(
                      size: 50,
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                      duration: 1800.ms,
                      reverse: false),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  PurpleTheme.lightPurple,
                  Theme.of(context).primaryColor
                ],
              ).createShader(bounds),
              child: Text(
                'SA.',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
              ),
            )
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: true))
                .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1.05, 1.05),
                    duration: 1500.ms,
                    curve: Curves.easeInOut),
            const SizedBox(height: 24),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.white54 : Colors.black45,
                    letterSpacing: 1.5,
                  ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .fadeIn(duration: 800.ms)
                .then()
                .fadeOut(duration: 800.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedRing(
      {required double size,
      required Color color,
      required Duration duration,
      required bool reverse}) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: color.withOpacity(0.1),
      ),
    ).animate(onPlay: (controller) => controller.repeat()).rotate(
          duration: duration,
          begin: reverse ? 1 : 0,
          end: reverse ? 0 : 1,
          curve: Curves.linear,
        );
  }
}
