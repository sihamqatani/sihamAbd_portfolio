import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purple_portfolio/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/glass_container.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Handling null safety for l10n is important, usually it is not null if setup correctly
    // But since this file doesn't exist yet, linter might complain if I don't use it carefully (not really, linter doesn't know about runtime)
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        GlassContainer(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                l10n?.contact ?? 'Contact',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialButton(
                    icon: FontAwesomeIcons.github,
                    url: 'https://github.com/sihamqatani',
                  ),
                  SizedBox(width: 20),
                  _SocialButton(
                    icon: FontAwesomeIcons.linkedin,
                    url: 'https://www.linkedin.com/in/siham-abdullah-332072214',
                  ),
                  SizedBox(width: 20),
                  _SocialButton(
                    icon: FontAwesomeIcons.whatsapp,
                    url: 'https://wa.me/967778404656',
                  ),
                  SizedBox(width: 20),
                  _SocialButton(
                    icon: FontAwesomeIcons.envelope,
                    url: 'mailto:siham1554@gmail.com',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone,
                          size: 16, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      Text('00967-778404656',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      Text('Sana\'a, Yemen',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "© 2026 All Rights Reserved.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOutQuart)
            .slideY(begin: 0.1, curve: Curves.easeOutQuart),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialButton({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(icon, color: Theme.of(context).primaryColor),
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
    );
  }
}
