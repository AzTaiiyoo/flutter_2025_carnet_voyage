import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme_extensions.dart';
import 'form_card.dart';

/// Section d'adresse avec lien vers la carte
/// Affiche rue, ville et code postal (champs désactivés, remplis via carte)
class AddressSection extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController postcodeController;
  final VoidCallback? onNavigateToMap;

  const AddressSection({
    super.key,
    required this.streetController,
    required this.cityController,
    required this.postcodeController,
    this.onNavigateToMap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final lifeLogTheme = theme.extension<LifeLogThemeExtension>()!;

    return FormCard(
      onTap: onNavigateToMap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(colorScheme, textTheme, lifeLogTheme),
          SizedBox(height: AppSpacing.md),
          _buildStreetField(),
          SizedBox(height: AppSpacing.ms),
          _buildCityPostcodeRow(),
        ],
      ),
    );
  }

  Widget _buildHeader(
    ColorScheme colorScheme,
    TextTheme textTheme,
    LifeLogThemeExtension lifeLogTheme,
  ) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: lifeLogTheme.iconColorSecondary,
        ),
        SizedBox(width: AppSpacing.sm),
        Text(
          'Adresse',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Icon(Icons.map, color: colorScheme.primary),
        SizedBox(width: AppSpacing.xs),
        Text(
          'Choisir sur la carte',
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildStreetField() {
    return TextFormField(
      controller: streetController,
      decoration: const InputDecoration(
        labelText: 'Rue (optionnel)',
      ),
      enabled: false,
    );
  }

  Widget _buildCityPostcodeRow() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              labelText: 'Ville',
            ),
            enabled: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ville requise';
              }
              return null;
            },
          ),
        ),
        SizedBox(width: AppSpacing.ms),
        Expanded(
          child: TextFormField(
            controller: postcodeController,
            decoration: const InputDecoration(
              labelText: 'Code postal (optionnel)',
            ),
            enabled: false,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
