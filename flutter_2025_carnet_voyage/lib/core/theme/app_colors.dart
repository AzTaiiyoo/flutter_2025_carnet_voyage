import 'package:flutter/material.dart';

/// Palette de couleurs centralisée avec approches sémantique
/// Permet de changer de palette sans renommer les variables dans tout le code
abstract class AppColors {
  // ============================================
  // PALETTE DE RÉFÉRENCE (LITTÉRALE)
  // On définit ici les couleurs "physiques"
  // ============================================

  // Bleus (L'eau)
  static const Color oceanBlue = Color(0xFF005F73);
  static const Color oceanBlueLight = Color(0xFF0A9396);
  static const Color oceanBlueDark = Color(0xFF001219);

  // Verts (La montagne)
  static const Color forestGreen = Color(0xFF1B4332);
  static const Color forestGreenLight = Color(0xFF2D6A4F);
  static const Color forestGreenDark = Color(0xFF081C15);

  // Gris/Mousse (Surfaces)
  static const Color mistGrey = Color(0xFFEDF2F4);
  static const Color mistGreyLight = Color(0xFFF8FAFC);
  static const Color mistGreyDark = Color(0xFF8D99AE);

  // Accents & Sémantique
  static const Color mountainGold = Color(0xFFEE9B00); // Pour les notes
  static const Color terraCotta = Color(0xFFBC6C5C); // Pour les erreurs

  // ============================================
  // JETONS SÉMANTIQUES (L'USAGE)
  // C'est ce que les thèmes utilisent
  // ============================================

  static const Color brandPrimary = oceanBlue;
  static const Color brandPrimaryVariant = oceanBlueLight;

  static const Color brandSecondary = forestGreen;
  static const Color brandSecondaryVariant = forestGreenLight;

  static const Color surfaceAccent = mistGrey;
  static const Color surfaceAccentVariant = mistGreyLight;

  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);

  // ============================================
  // COULEURS POUR LES PHOTOS VIBRANTES
  // ============================================

  static const Color photoOverlay = Color(0x0A000000);
  static const Color photoBorder = Color(0x1A000000);

  // ============================================
  // ACCÈS AUX THÈMES
  // ============================================

  static const LightColors light = LightColors();
  static const DarkColors dark = DarkColors();
}

/// Couleurs pour le thème clair
class LightColors {
  const LightColors();

  // Surfaces
  Color get background => AppColors.backgroundLight;
  Color get surface => Colors.white;
  Color get surfaceVariant => AppColors.surfaceAccentVariant;

  // Primary
  Color get primary => AppColors.brandPrimary;
  Color get primaryContainer => AppColors.surfaceAccent;
  Color get onPrimary => Colors.white;
  Color get onPrimaryContainer => AppColors.brandPrimary;

  // Secondary
  Color get secondary => AppColors.brandSecondary;
  Color get secondaryContainer =>
      AppColors.brandSecondaryVariant.withOpacity(0.1);
  Color get onSecondary => Colors.white;
  Color get onSecondaryContainer => AppColors.brandSecondary;

  // Tertiary
  Color get tertiary => AppColors.mountainGold;
  Color get tertiaryContainer => AppColors.mountainGold.withOpacity(0.1);

  // Text
  Color get textPrimary => const Color(0xFF1E293B);
  Color get textSecondary => AppColors.brandPrimary;
  Color get textTertiary => const Color(0xFF64748B);
  Color get textOnDark => Colors.white;

  // Borders & Dividers
  Color get border => const Color(0xFFE2E8F0);
  Color get divider => const Color(0xFFF1F5F9);

  // States
  Color get disabled => const Color(0xFFCBD5E1);
  Color get error => AppColors.terraCotta;
  Color get success => AppColors.forestGreen;
}

/// Couleurs pour le thème sombre
class DarkColors {
  const DarkColors();

  // Surfaces
  Color get background => AppColors.backgroundDark;
  Color get surface => const Color(0xFF1E293B);
  Color get surfaceVariant => const Color(0xFF334155);

  // Primary
  Color get primary => AppColors.brandPrimaryVariant;
  Color get primaryContainer => const Color(0xFF001219);
  Color get onPrimary => Colors.white;
  Color get onPrimaryContainer => AppColors.brandPrimaryVariant;

  // Secondary
  Color get secondary => AppColors.brandSecondaryVariant;
  Color get secondaryContainer => AppColors.forestGreenDark;
  Color get onSecondary => Colors.white;
  Color get onSecondaryContainer => AppColors.brandSecondaryVariant;

  // Tertiary
  Color get tertiary => AppColors.mountainGold;
  Color get tertiaryContainer => const Color(0xFF5C4A3A);

  // Text
  Color get textPrimary => const Color(0xFFF1F5F9);
  Color get textSecondary => AppColors.brandPrimaryVariant;
  Color get textTertiary => const Color(0xFF94A3B8);
  Color get textOnDark => const Color(0xFF0F172A);

  // Borders & Dividers
  Color get border => const Color(0xFF334155);
  Color get divider => const Color(0xFF1E293B);

  // States
  Color get disabled => const Color(0xFF475569);
  Color get error => AppColors.terraCotta;
  Color get success => AppColors.forestGreenLight;
}
