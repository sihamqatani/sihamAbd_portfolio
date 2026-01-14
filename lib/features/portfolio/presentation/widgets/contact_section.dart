import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/purple_theme.dart';
import '../../../../core/widgets/glass_container.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      children: [
        GlassContainer(
          width: double.infinity,
          child: Column(
            children: [
              Text(l10n.contact,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: isMobile ? 24 : null))
                  .animate()
                  .fadeIn()
                  .blurXY(begin: 8, end: 0)
                  .then()
                  .shimmer(
                      delay: 1.seconds,
                      duration: 1500.ms,
                      color: PurpleTheme.primaryPurple.withOpacity(0.3)),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isMobile ? 12 : 20,
                runSpacing: 12,
                children: const [
                  _SocialButton(
                      icon: FontAwesomeIcons.github,
                      url: 'https://github.com/sihamqatani',
                      index: 0),
                  _SocialButton(
                      icon: FontAwesomeIcons.linkedin,
                      url:
                          'https://www.linkedin.com/in/siham-abdullah-332072214',
                      index: 1),
                  _SocialButton(
                      icon: FontAwesomeIcons.whatsapp,
                      url: 'https://wa.me/967778404656',
                      index: 2),
                  _SocialButton(
                      icon: FontAwesomeIcons.envelope,
                      url: 'mailto:siham1554@gmail.com',
                      index: 3),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  _buildContactItem(
                      context, Icons.phone, '00967-778404656', isMobile, -0.1),
                  const SizedBox(height: 10),
                  _buildContactItem(context, Icons.location_on,
                      'Sana\'a, Yemen', isMobile, 0.1),
                ],
              ),
              const SizedBox(height: 30),
              Text("© 2026 All Rights Reserved.",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: isMobile ? 11 : null))
                  .animate()
                  .fadeIn(delay: 600.ms),
            ],
          ),
        ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.15),
      ],
    );
  }

  Widget _buildContactItem(BuildContext context, IconData icon, String text,
      bool isMobile, double slideX) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: isMobile ? 13 : null)),
      ],
    ).animate().fadeIn(delay: 400.ms).slideX(begin: slideX);
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final int index;
  const _SocialButton(
      {required this.icon, required this.url, required this.index});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered
                ? Theme.of(context).primaryColor.withOpacity(0.15)
                : Theme.of(context).primaryColor.withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(
                color: _isHovered
                    ? Theme.of(context).primaryColor.withOpacity(0.5)
                    : Theme.of(context).primaryColor.withOpacity(0.2),
                width: 1.5),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2)
                  ]
                : [],
          ),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -4.0 : 0.0, 0.0),
          child: FaIcon(widget.icon,
              color: _isHovered
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(0.7),
              size: _isHovered ? 24 : 22),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (200 + widget.index * 100).ms)
        .scale(begin: Offset.zero, curve: Curves.elasticOut);
  }
}
