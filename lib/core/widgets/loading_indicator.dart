import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/purple_theme.dart';

class PurpleLoadingIndicator extends StatelessWidget {
  const PurpleLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: PurpleTheme.glassGradient,
              boxShadow: [
                BoxShadow(
                  color: PurpleTheme.primaryPurple,
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Text(
              'SA.',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1.1, 1.1),
                duration: 1000.ms,
                curve: Curves.easeInOut,
              )
              .shimmer(
                duration: 2000.ms,
                color: Colors.white.withOpacity(0.5),
              ),
          const SizedBox(height: 20),
          const SizedBox(
            width: 150,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white10,
              color: PurpleTheme.lightPurple,
              minHeight: 2,
            ),
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }
}
