import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme_extensions.dart';

/// En-tête de section avec icône et titre
/// Utilisé dans les formulaires pour identifier chaque section
class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lifeLogTheme = theme.extension<LifeLogThemeExtension>()!;
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Icon(icon, color: lifeLogTheme.iconColorSecondary),
        SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (trailing != null) ...[
          const Spacer(),
          trailing!,
        ],
      ],
    );
  }
}
