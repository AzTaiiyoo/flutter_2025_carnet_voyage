import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_shadows.dart';
import 'app_spacing.dart';

/// Extensions de thème personnalisées pour les composants Life-log
/// Utilisation: Theme.of(context).extension<LifeLogThemeExtension>()!
class LifeLogThemeExtension extends ThemeExtension<LifeLogThemeExtension> {
  const LifeLogThemeExtension({
    required this.cardDecoration,
    required this.cardDecorationHover,
    required this.photoDecoration,
    required this.ratingBadgeDecoration,
    required this.searchBarDecoration,
    required this.noteContainerDecoration,
    required this.iconColor,
    required this.iconColorSecondary,
    required this.ratingStarColor,
    required this.ratingTextColor,
  });

  /// Décoration pour les cartes principales
  final BoxDecoration cardDecoration;

  /// Décoration pour les cartes au hover
  final BoxDecoration cardDecorationHover;

  /// Décoration pour les photos (vibrantes)
  final BoxDecoration photoDecoration;

  /// Décoration pour les badges de notation
  final BoxDecoration ratingBadgeDecoration;

  /// Décoration pour la barre de recherche
  final BoxDecoration searchBarDecoration;

  /// Décoration pour les conteneurs de notes
  final BoxDecoration noteContainerDecoration;

  /// Couleur des icônes principales
  final Color iconColor;

  /// Couleur des icônes secondaires
  final Color iconColorSecondary;

  /// Couleur des étoiles de notation
  final Color ratingStarColor;

  /// Couleur du texte de notation
  final Color ratingTextColor;

  /// Extension pour le thème clair
  static LifeLogThemeExtension get light => LifeLogThemeExtension(
    cardDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: AppSpacing.cardRadius,
      boxShadow: AppShadows.card,
    ),
    cardDecorationHover: BoxDecoration(
      color: Colors.white,
      borderRadius: AppSpacing.cardRadius,
      boxShadow: AppShadows.medium,
    ),
    photoDecoration: BoxDecoration(
      borderRadius: AppSpacing.photoRadius,
      boxShadow: AppShadows.photo,
    ),
    ratingBadgeDecoration: BoxDecoration(
      color: AppColors.mountainGold.withOpacity(0.1),
      borderRadius: AppSpacing.buttonRadius,
      border: Border.all(color: AppColors.mountainGold, width: 1),
    ),
    searchBarDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: AppSpacing.smallRadius,
      boxShadow: AppShadows.searchBar,
    ),
    noteContainerDecoration: BoxDecoration(
      color: AppColors.surfaceAccentVariant,
      borderRadius: AppSpacing.buttonRadius,
    ),
    iconColor: AppColors.brandPrimary,
    iconColorSecondary: AppColors.brandPrimaryVariant,
    ratingStarColor: AppColors.mountainGold,
    ratingTextColor: const Color(0xFF8B6914),
  );

  /// Extension pour le thème sombre
  static LifeLogThemeExtension get dark => LifeLogThemeExtension(
    cardDecoration: BoxDecoration(
      color: AppColors.dark.surface,
      borderRadius: AppSpacing.cardRadius,
      boxShadow: AppShadows.cardDark,
    ),
    cardDecorationHover: BoxDecoration(
      color: AppColors.dark.surfaceVariant,
      borderRadius: AppSpacing.cardRadius,
      boxShadow: AppShadows.strong,
    ),
    photoDecoration: BoxDecoration(
      borderRadius: AppSpacing.photoRadius,
      boxShadow: AppShadows.softDark,
    ),
    ratingBadgeDecoration: BoxDecoration(
      color: AppColors.mountainGold.withOpacity(0.2),
      borderRadius: AppSpacing.buttonRadius,
      border: Border.all(color: AppColors.mountainGold, width: 1),
    ),
    searchBarDecoration: BoxDecoration(
      color: AppColors.dark.surface,
      borderRadius: AppSpacing.smallRadius,
      boxShadow: AppShadows.softDark,
    ),
    noteContainerDecoration: BoxDecoration(
      color: AppColors.dark.surfaceVariant,
      borderRadius: AppSpacing.buttonRadius,
    ),
    iconColor: AppColors.brandPrimaryVariant,
    iconColorSecondary: AppColors.brandPrimary,
    ratingStarColor: AppColors.mountainGold,
    ratingTextColor: AppColors.mountainGold,
  );

  @override
  LifeLogThemeExtension copyWith({
    BoxDecoration? cardDecoration,
    BoxDecoration? cardDecorationHover,
    BoxDecoration? photoDecoration,
    BoxDecoration? ratingBadgeDecoration,
    BoxDecoration? searchBarDecoration,
    BoxDecoration? noteContainerDecoration,
    Color? iconColor,
    Color? iconColorSecondary,
    Color? ratingStarColor,
    Color? ratingTextColor,
  }) {
    return LifeLogThemeExtension(
      cardDecoration: cardDecoration ?? this.cardDecoration,
      cardDecorationHover: cardDecorationHover ?? this.cardDecorationHover,
      photoDecoration: photoDecoration ?? this.photoDecoration,
      ratingBadgeDecoration:
          ratingBadgeDecoration ?? this.ratingBadgeDecoration,
      searchBarDecoration: searchBarDecoration ?? this.searchBarDecoration,
      noteContainerDecoration:
          noteContainerDecoration ?? this.noteContainerDecoration,
      iconColor: iconColor ?? this.iconColor,
      iconColorSecondary: iconColorSecondary ?? this.iconColorSecondary,
      ratingStarColor: ratingStarColor ?? this.ratingStarColor,
      ratingTextColor: ratingTextColor ?? this.ratingTextColor,
    );
  }

  @override
  LifeLogThemeExtension lerp(
    ThemeExtension<LifeLogThemeExtension>? other,
    double t,
  ) {
    if (other is! LifeLogThemeExtension) {
      return this;
    }
    return LifeLogThemeExtension(
      cardDecoration: BoxDecoration.lerp(
        cardDecoration,
        other.cardDecoration,
        t,
      )!,
      cardDecorationHover: BoxDecoration.lerp(
        cardDecorationHover,
        other.cardDecorationHover,
        t,
      )!,
      photoDecoration: BoxDecoration.lerp(
        photoDecoration,
        other.photoDecoration,
        t,
      )!,
      ratingBadgeDecoration: BoxDecoration.lerp(
        ratingBadgeDecoration,
        other.ratingBadgeDecoration,
        t,
      )!,
      searchBarDecoration: BoxDecoration.lerp(
        searchBarDecoration,
        other.searchBarDecoration,
        t,
      )!,
      noteContainerDecoration: BoxDecoration.lerp(
        noteContainerDecoration,
        other.noteContainerDecoration,
        t,
      )!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      iconColorSecondary: Color.lerp(
        iconColorSecondary,
        other.iconColorSecondary,
        t,
      )!,
      ratingStarColor: Color.lerp(ratingStarColor, other.ratingStarColor, t)!,
      ratingTextColor: Color.lerp(ratingTextColor, other.ratingTextColor, t)!,
    );
  }
}
