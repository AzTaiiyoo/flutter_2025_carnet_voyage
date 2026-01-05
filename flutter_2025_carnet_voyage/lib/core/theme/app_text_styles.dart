import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typographie centralisée utilisant Inter (police géométrique)
/// Tous les styles de texte doivent provenir de cette classe
abstract class AppTextStyles {
  // ============================================
  // POLICE DE BASE
  // ============================================

  /// Police Inter pour toute l'application
  static String get fontFamily => GoogleFonts.inter().fontFamily!;

  // ============================================
  // DISPLAY - Titres majeurs
  // ============================================

  static TextStyle displayLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    color: color ?? AppColors.light.textPrimary,
  );

  static TextStyle displayMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.25,
    color: color ?? AppColors.light.textPrimary,
  );

  static TextStyle displaySmall({Color? color}) => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
    color: color ?? AppColors.light.textPrimary,
  );

  // ============================================
  // HEADLINE - Titres de sections
  // ============================================

  static TextStyle headlineLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
    color: color ?? AppColors.light.textPrimary,
  );

  static TextStyle headlineMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.36,
    color: color ?? AppColors.light.textPrimary,
  );

  static TextStyle headlineSmall({Color? color}) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: color ?? AppColors.light.textPrimary,
  );

  // ============================================
  // TITLE - Noms de sorties, éléments importants
  // ============================================

  static TextStyle titleLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.44,
    color: color ?? AppColors.light.textPrimary,
  );

  static TextStyle titleMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
    color: color ?? AppColors.light.textPrimary,
  );

  static TextStyle titleSmall({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    color: color ?? AppColors.light.textPrimary,
  );

  // ============================================
  // BODY - Texte courant
  // ============================================

  static TextStyle bodyLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
    color: color ?? AppColors.light.textPrimary,
  );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
    color: color ?? AppColors.light.textSecondary,
  );

  static TextStyle bodySmall({Color? color}) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
    color: color ?? AppColors.light.textTertiary,
  );

  // ============================================
  // LABEL - Labels et actions
  // ============================================

  static TextStyle labelLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    color: color ?? AppColors.light.textPrimary,
  );

  static TextStyle labelMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
    color: color ?? AppColors.light.textSecondary,
  );

  static TextStyle labelSmall({Color? color}) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
    color: color ?? AppColors.light.textTertiary,
  );

  // ============================================
  // TEXT THEME POUR MATERIAL
  // ============================================

  static TextTheme get lightTextTheme => TextTheme(
    displayLarge: displayLarge(),
    displayMedium: displayMedium(),
    displaySmall: displaySmall(),
    headlineLarge: headlineLarge(),
    headlineMedium: headlineMedium(),
    headlineSmall: headlineSmall(),
    titleLarge: titleLarge(),
    titleMedium: titleMedium(),
    titleSmall: titleSmall(),
    bodyLarge: bodyLarge(),
    bodyMedium: bodyMedium(),
    bodySmall: bodySmall(),
    labelLarge: labelLarge(),
    labelMedium: labelMedium(),
    labelSmall: labelSmall(),
  );

  static TextTheme get darkTextTheme => TextTheme(
    displayLarge: displayLarge(color: AppColors.dark.textPrimary),
    displayMedium: displayMedium(color: AppColors.dark.textPrimary),
    displaySmall: displaySmall(color: AppColors.dark.textPrimary),
    headlineLarge: headlineLarge(color: AppColors.dark.textPrimary),
    headlineMedium: headlineMedium(color: AppColors.dark.textPrimary),
    headlineSmall: headlineSmall(color: AppColors.dark.textPrimary),
    titleLarge: titleLarge(color: AppColors.dark.textPrimary),
    titleMedium: titleMedium(color: AppColors.dark.textPrimary),
    titleSmall: titleSmall(color: AppColors.dark.textPrimary),
    bodyLarge: bodyLarge(color: AppColors.dark.textPrimary),
    bodyMedium: bodyMedium(color: AppColors.dark.textSecondary),
    bodySmall: bodySmall(color: AppColors.dark.textTertiary),
    labelLarge: labelLarge(color: AppColors.dark.textPrimary),
    labelMedium: labelMedium(color: AppColors.dark.textSecondary),
    labelSmall: labelSmall(color: AppColors.dark.textTertiary),
  );
}
