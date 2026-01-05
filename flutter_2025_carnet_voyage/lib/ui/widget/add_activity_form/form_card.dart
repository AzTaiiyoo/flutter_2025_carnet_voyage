import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme_extensions.dart';

/// Carte de formulaire réutilisable avec le style Life-log
/// Coins arrondis, ombres douces, support de tap optionnel
class FormCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const FormCard({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final lifeLogTheme = Theme.of(context).extension<LifeLogThemeExtension>()!;

    return Container(
      decoration: lifeLogTheme.cardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSpacing.cardRadius,
          child: Padding(
            padding: AppSpacing.cardPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}
