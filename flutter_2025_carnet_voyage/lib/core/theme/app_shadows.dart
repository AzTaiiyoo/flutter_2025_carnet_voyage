import 'package:flutter/material.dart';

/// Ombres portées douces pour les effets de profondeur
/// Utilisation: AppShadows.soft, AppShadows.cardShadow, etc.
abstract class AppShadows {
  // ============================================
  // OMBRES DE BASE (Light Mode)
  // ============================================

  /// Ombre très légère - Éléments subtils
  static List<BoxShadow> get subtle => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.03),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  /// Ombre douce - Éléments au repos
  static List<BoxShadow> get soft => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// Ombre moyenne - Éléments au hover / focus
  static List<BoxShadow> get medium => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  /// Ombre forte - Éléments surélevés (modals, dropdowns)
  static List<BoxShadow> get strong => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  /// Ombre très forte - Navigation, FAB
  static List<BoxShadow> get intense => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.16),
      blurRadius: 32,
      offset: const Offset(0, 12),
    ),
  ];

  // ============================================
  // OMBRES SPÉCIALISÉES
  // ============================================

  /// Ombre pour les cartes principales
  static List<BoxShadow> get card => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.02),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  /// Ombre pour les photos (mise en valeur)
  static List<BoxShadow> get photo => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// Ombre pour la barre de recherche
  static List<BoxShadow> get searchBar => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  /// Ombre pour les boutons surélevés
  static List<BoxShadow> get button => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// Ombre pour les floating action buttons
  static List<BoxShadow> get fab => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  /// Ombre pour les bottom sheets
  static List<BoxShadow> get bottomSheet => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      blurRadius: 20,
      offset: const Offset(0, -4),
    ),
  ];

  // ============================================
  // OMBRES INNER (pour les inputs)
  // ============================================

  /// Ombre interne pour les champs de saisie au focus
  static List<BoxShadow> get inputFocus => [
    BoxShadow(
      color: const Color(0xFF64748B).withValues(alpha: 0.15),
      blurRadius: 0,
      spreadRadius: 2,
    ),
  ];

  // ============================================
  // OMBRES DARK MODE
  // ============================================

  /// Ombre douce pour le dark mode
  static List<BoxShadow> get softDark => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.20),
      blurRadius: 12,
      offset: const Offset(0, 2),
    ),
  ];

  /// Ombre pour les cartes en dark mode
  static List<BoxShadow> get cardDark => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.25),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
}
