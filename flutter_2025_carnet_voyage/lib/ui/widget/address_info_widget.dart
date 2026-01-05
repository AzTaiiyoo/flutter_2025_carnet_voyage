import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_2025_carnet_voyage/blocs/map_cubit.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_theme_extensions.dart';

/// Widget affichant les informations d'une adresse et sa météo
/// Design Life-log premium avec coins arrondis et ombres douces
class AddressInfoWidget extends StatelessWidget {
  const AddressInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final lifeLogTheme = theme.extension<LifeLogThemeExtension>()!;

    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        // Si pas d'adresse sélectionnée, afficher un message
        if (!state.hasSelectedAddress) {
          return Container(
            padding: AppSpacing.cardPadding,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: AppSpacing.cardRadius,
              boxShadow: AppShadows.card,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.touch_app,
                  color: lifeLogTheme.iconColorSecondary,
                  size: AppSpacing.iconLg,
                ),
                SizedBox(width: AppSpacing.ms),
                Expanded(
                  child: Text(
                    'Recherchez une adresse ou touchez la carte',
                    style: textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        }

        final address = state.selectedAddress!;
        final weather = state.weather;

        return Container(
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: AppSpacing.cardRadius,
            boxShadow: AppShadows.card,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // En-tête avec titre et température
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Informations sur l'adresse
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weather',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          weather?.locationName ?? address.city,
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  // Température et description météo
                  if (weather != null) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          weather.formattedTemperature,
                          style: textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w300,
                            color: colorScheme.primary,
                          ),
                        ),
                        Text(
                          _capitalizeFirst(weather.description),
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ] else if (state.isLoading) ...[
                    SizedBox(
                      width: AppSpacing.iconMd,
                      height: AppSpacing.iconMd,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ],
              ),

              SizedBox(height: AppSpacing.md),

              // Détails météo
              if (weather != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _WeatherDetailItem(
                      icon: Icons.water_drop_outlined,
                      label: 'Humidity',
                      value: weather.formattedHumidity,
                    ),
                    _WeatherDetailItem(
                      icon: Icons.air,
                      label: 'Wind',
                      value: weather.formattedWindSpeed,
                    ),
                    _WeatherDetailItem(
                      icon: Icons.visibility_outlined,
                      label: 'Visibility',
                      value: weather.formattedVisibility,
                    ),
                  ],
                ),

              // Erreur météo
              if (state.errorMessage != null && !state.hasWeather)
                Padding(
                  padding: EdgeInsets.only(top: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: colorScheme.tertiary,
                        size: AppSpacing.iconSm,
                      ),
                      SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          state.errorMessage!,
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Coordonnées (optionnel)
              if (address.hasCoordinates)
                Padding(
                  padding: EdgeInsets.only(top: AppSpacing.ms),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: lifeLogTheme.iconColorSecondary,
                        size: AppSpacing.iconSm - 2,
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        address.formattedCoordinates,
                        style: textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

/// Widget pour afficher un détail météo (humidité, vent, visibilité)
class _WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppSpacing.iconSm, color: colorScheme.secondary),
            SizedBox(width: AppSpacing.xs),
            Text(label, style: textTheme.labelSmall),
          ],
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
