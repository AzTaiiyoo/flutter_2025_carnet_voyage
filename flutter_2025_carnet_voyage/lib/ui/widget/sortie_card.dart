import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/sortie.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme_extensions.dart';
import 'photo_dialog.dart';

/// Carte affichant une sortie avec un design premium Life-log
/// Photos vibrantes, coins arrondis 24px, ombres douces
class SortieCard extends StatelessWidget {
  final Sortie sortie;
  final VoidCallback? onTap;

  const SortieCard({super.key, required this.sortie, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final lifeLogTheme = theme.extension<LifeLogThemeExtension>()!;
    final dateFormat = DateFormat('dd MMMM yyyy');

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.xs,
      ),
      decoration: lifeLogTheme.cardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSpacing.cardRadius,
          child: Padding(
            padding: AppSpacing.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildPhotoOrIcon(context, lifeLogTheme, colorScheme),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(sortie.name, style: textTheme.titleLarge),
                          SizedBox(height: AppSpacing.xs),
                          Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                size: AppSpacing.iconSm,
                                color: lifeLogTheme.iconColorSecondary,
                              ),
                              SizedBox(width: AppSpacing.xs),
                              Expanded(
                                child: Text(
                                  sortie.address.city,
                                  style: textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (sortie.rating != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: lifeLogTheme.ratingBadgeDecoration,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: AppSpacing.iconSm,
                              color: lifeLogTheme.ratingStarColor,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Text(
                              sortie.rating!.toStringAsFixed(1),
                              style: textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: lifeLogTheme.ratingTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: AppSpacing.ms),
                Divider(height: 1, color: colorScheme.outline.withOpacity(0.3)),
                SizedBox(height: AppSpacing.ms),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: AppSpacing.iconSm,
                      color: colorScheme.primary,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Text(
                      dateFormat.format(sortie.date),
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
                if (sortie.note != null && sortie.note!.isNotEmpty) ...[
                  SizedBox(height: AppSpacing.ms),
                  Container(
                    padding: EdgeInsets.all(AppSpacing.ms),
                    decoration: lifeLogTheme.noteContainerDecoration,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.note,
                          size: AppSpacing.iconSm,
                          color: lifeLogTheme.iconColorSecondary,
                        ),
                        SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            sortie.note!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoOrIcon(
    BuildContext context,
    LifeLogThemeExtension lifeLogTheme,
    ColorScheme colorScheme,
  ) {
    if (sortie.imageUrl != null && sortie.imageUrl!.isNotEmpty) {
      // Photo vibrante avec effet de saturation/contraste boost
      return GestureDetector(
        onTap: () => PhotoDialog.show(context, sortie.imageUrl!),
        child: Container(
          width: AppSpacing.avatarStd,
          height: AppSpacing.avatarStd,
          decoration: lifeLogTheme.photoDecoration,
          child: ClipRRect(
            borderRadius: AppSpacing.photoRadius,
            child: ColorFiltered(
              // Boost de saturation pour rendre les photos plus vibrantes
              colorFilter: const ColorFilter.matrix(<double>[
                1.1, 0, 0, 0, 0, // Red
                0, 1.1, 0, 0, 0, // Green
                0, 0, 1.1, 0, 0, // Blue
                0, 0, 0, 1, 0, // Alpha
              ]),
              child: Image.file(
                File(sortie.imageUrl!),
                width: AppSpacing.avatarStd,
                height: AppSpacing.avatarStd,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultIcon(colorScheme);
                },
              ),
            ),
          ),
        ),
      );
    } else {
      return _buildDefaultIcon(colorScheme);
    }
  }

  Widget _buildDefaultIcon(ColorScheme colorScheme) {
    return Container(
      width: AppSpacing.avatarStd,
      height: AppSpacing.avatarStd,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: AppSpacing.photoRadius,
      ),
      child: Icon(
        Icons.place,
        color: colorScheme.onPrimaryContainer,
        size: AppSpacing.iconMl,
      ),
    );
  }
}
