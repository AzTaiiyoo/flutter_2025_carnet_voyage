import 'package:flutter/material.dart';

/// Espacements et dimensions centralisés
/// Utilisation: AppSpacing.md, AppSpacing.radiusLg, etc.
abstract class AppSpacing {
  // ============================================
  // ESPACEMENTS (padding, margin, gaps)
  // ============================================

  /// 4px - Extra small
  static const double xs = 4.0;

  /// 8px - Small
  static const double sm = 8.0;

  /// 12px - Medium-small
  static const double ms = 12.0;

  /// 16px - Medium (défaut)
  static const double md = 16.0;

  /// 20px - Medium-large
  static const double ml = 20.0;

  /// 24px - Large
  static const double lg = 24.0;

  /// 32px - Extra large
  static const double xl = 32.0;

  /// 48px - 2x Extra large
  static const double xxl = 48.0;

  /// 64px - 3x Extra large
  static const double xxxl = 64.0;

  // ============================================
  // BORDER RADIUS - Coins arrondis
  // ============================================

  /// 4px - Très petit
  static const double radiusXs = 4.0;

  /// 8px - Petit
  static const double radiusSm = 8.0;

  /// 12px - Moyen-petit
  static const double radiusMs = 12.0;

  /// 16px - Moyen
  static const double radiusMd = 16.0;

  /// 24px - Large (cartes principales)
  static const double radiusLg = 24.0;

  /// 32px - Extra large
  static const double radiusXl = 32.0;

  /// Cercle complet
  static const double radiusFull = 999.0;

  // ============================================
  // BORDER RADIUS PRÉFABRIQUÉS
  // ============================================

  /// Coins arrondis pour les cartes principales (24px)
  static BorderRadius get cardRadius => BorderRadius.circular(radiusLg);

  /// Coins arrondis pour les éléments secondaires (16px)
  static BorderRadius get elementRadius => BorderRadius.circular(radiusMd);

  /// Coins arrondis pour les petits éléments (12px)
  static BorderRadius get smallRadius => BorderRadius.circular(radiusMs);

  /// Coins arrondis pour les boutons (8px)
  static BorderRadius get buttonRadius => BorderRadius.circular(radiusSm);

  /// Coins arrondis pour les photos (12px)
  static BorderRadius get photoRadius => BorderRadius.circular(radiusMs);

  /// Coins arrondis pour les badges (999px - pilule)
  static BorderRadius get badgeRadius => BorderRadius.circular(radiusFull);

  // ============================================
  // EDGE INSETS PRÉFABRIQUÉS
  // ============================================

  /// Padding standard pour les cartes
  static EdgeInsets get cardPadding => const EdgeInsets.all(md);

  /// Padding pour les listes
  static EdgeInsets get listPadding =>
      const EdgeInsets.symmetric(horizontal: ms, vertical: md);

  /// Padding pour les écrans
  static EdgeInsets get screenPadding => const EdgeInsets.all(md);

  /// Padding horizontal
  static EdgeInsets get horizontalPadding =>
      const EdgeInsets.symmetric(horizontal: md);

  /// Padding vertical
  static EdgeInsets get verticalPadding =>
      const EdgeInsets.symmetric(vertical: md);

  // ============================================
  // TAILLES D'ICÔNES
  // ============================================

  /// 16px - Petite icône
  static const double iconSm = 16.0;

  /// 20px - Icône moyenne-petite
  static const double iconMs = 20.0;

  /// 24px - Icône standard
  static const double iconMd = 24.0;

  /// 28px - Icône moyenne-grande
  static const double iconMl = 28.0;

  /// 32px - Grande icône
  static const double iconLg = 32.0;

  /// 48px - Très grande icône
  static const double iconXl = 48.0;

  // ============================================
  // TAILLES D'AVATARS / PHOTOS
  // ============================================

  /// 32px - Petit avatar
  static const double avatarSm = 32.0;

  /// 48px - Avatar moyen
  static const double avatarMd = 48.0;

  /// 56px - Avatar standard
  static const double avatarStd = 56.0;

  /// 64px - Grand avatar
  static const double avatarLg = 64.0;

  /// 80px - Très grand avatar
  static const double avatarXl = 80.0;
}
