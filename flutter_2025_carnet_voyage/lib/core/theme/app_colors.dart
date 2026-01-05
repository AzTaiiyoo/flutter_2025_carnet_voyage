import 'package:flutter/material.dart';

/// Palette de couleurs centralisée inspirée de la nature
/// Utilisation: AppColors.slateBlue, AppColors.light.surface, etc.
abstract class AppColors {
  // ============================================
  // PALETTE NATURE PRINCIPALE
  // ============================================

  /// Bleu ardoise - Couleur primaire sophistiquée
  static const Color slateBlue = Color(0xFF64748B);
  static const Color slateBlueLight = Color(0xFF94A3B8);
  static const Color slateBlueDark = Color(0xFF475569);

  /// Vert sauge - Accent nature, succès
  static const Color sageGreen = Color(0xFF84A98C);
  static const Color sageGreenLight = Color(0xFFA7C4AD);
  static const Color sageGreenDark = Color(0xFF52796F);

  /// Beige sable - Surfaces chaudes
  static const Color sandBeige = Color(0xFFE8DCC4);
  static const Color sandBeigeLight = Color(0xFFF5F0E6);
  static const Color sandBeigeDark = Color(0xFFD4C4A8);

  /// Blanc chaud - Arrière-plan principal
  static const Color warmWhite = Color(0xFFFAF8F5);
  static const Color warmWhiteDark = Color(0xFF1A1A18);

  /// Ardoise profond - Texte principal
  static const Color deepSlate = Color(0xFF334155);
  static const Color deepSlateLight = Color(0xFFE2E8F0);

  // ============================================
  // COULEURS SÉMANTIQUES
  // ============================================

  /// Succès
  static const Color success = Color(0xFF84A98C);
  static const Color successLight = Color(0xFFD1E7D4);

  /// Avertissement (ambre doré naturel)
  static const Color warning = Color(0xFFD4A574);
  static const Color warningLight = Color(0xFFFAE8D4);

  /// Erreur (terre cuite)
  static const Color error = Color(0xFFBC6C5C);
  static const Color errorLight = Color(0xFFF8E4E0);

  /// Information
  static const Color info = Color(0xFF64748B);
  static const Color infoLight = Color(0xFFE0E5EB);

  // ============================================
  // COULEURS POUR LES PHOTOS VIBRANTES
  // ============================================

  /// Overlay pour faire ressortir les photos
  static const Color photoOverlay = Color(0x0A000000);

  /// Bordure subtile pour les photos
  static const Color photoBorder = Color(0x1A000000);

  // ============================================
  // LIGHT THEME COLORS
  // ============================================

  static const LightColors light = LightColors();

  // ============================================
  // DARK THEME COLORS
  // ============================================

  static const DarkColors dark = DarkColors();
}

/// Couleurs pour le thème clair
class LightColors {
  const LightColors();

  // Surfaces
  Color get background => AppColors.warmWhite;
  Color get surface => Colors.white;
  Color get surfaceVariant => AppColors.sandBeigeLight;

  // Primary
  Color get primary => AppColors.slateBlue;
  Color get primaryContainer => AppColors.sandBeige;
  Color get onPrimary => Colors.white;
  Color get onPrimaryContainer => AppColors.deepSlate;

  // Secondary
  Color get secondary => AppColors.sageGreen;
  Color get secondaryContainer => AppColors.sageGreenLight;
  Color get onSecondary => Colors.white;
  Color get onSecondaryContainer => AppColors.sageGreenDark;

  // Tertiary
  Color get tertiary => AppColors.warning;
  Color get tertiaryContainer => AppColors.warningLight;

  // Text
  Color get textPrimary => AppColors.deepSlate;
  Color get textSecondary => AppColors.slateBlue;
  Color get textTertiary => AppColors.slateBlueLight;
  Color get textOnDark => Colors.white;

  // Borders & Dividers
  Color get border => const Color(0xFFE2E8F0);
  Color get divider => const Color(0xFFF1F5F9);

  // States
  Color get disabled => const Color(0xFFCBD5E1);
  Color get error => AppColors.error;
  Color get success => AppColors.success;
}

/// Couleurs pour le thème sombre
class DarkColors {
  const DarkColors();

  // Surfaces
  Color get background => AppColors.warmWhiteDark;
  Color get surface => const Color(0xFF262624);
  Color get surfaceVariant => const Color(0xFF3A3A36);

  // Primary
  Color get primary => AppColors.slateBlueLight;
  Color get primaryContainer => AppColors.slateBlueDark;
  Color get onPrimary => AppColors.deepSlate;
  Color get onPrimaryContainer => AppColors.deepSlateLight;

  // Secondary
  Color get secondary => AppColors.sageGreenLight;
  Color get secondaryContainer => AppColors.sageGreenDark;
  Color get onSecondary => AppColors.deepSlate;
  Color get onSecondaryContainer => AppColors.sageGreenLight;

  // Tertiary
  Color get tertiary => AppColors.warning;
  Color get tertiaryContainer => const Color(0xFF5C4A3A);

  // Text
  Color get textPrimary => AppColors.deepSlateLight;
  Color get textSecondary => AppColors.slateBlueLight;
  Color get textTertiary => AppColors.slateBlue;
  Color get textOnDark => AppColors.deepSlate;

  // Borders & Dividers
  Color get border => const Color(0xFF4A4A46);
  Color get divider => const Color(0xFF3A3A36);

  // States
  Color get disabled => const Color(0xFF64645E);
  Color get error => AppColors.error;
  Color get success => AppColors.sageGreenLight;
}
