import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';
import 'app_theme_extensions.dart';

/// Thème global de l'application Life-log
/// Utilisation: MaterialApp(theme: AppTheme.light(), darkTheme: AppTheme.dark())
class AppTheme {
  AppTheme._();

  /// Thème clair
  static ThemeData light() {
    final colors = AppColors.light;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // ============================================
      // COLOR SCHEME
      // ============================================
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        primaryContainer: colors.primaryContainer,
        onPrimary: colors.onPrimary,
        onPrimaryContainer: colors.onPrimaryContainer,
        secondary: colors.secondary,
        secondaryContainer: colors.secondaryContainer,
        onSecondary: colors.onSecondary,
        onSecondaryContainer: colors.onSecondaryContainer,
        tertiary: colors.tertiary,
        tertiaryContainer: colors.tertiaryContainer,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        error: colors.error,
        outline: colors.border,
      ),

      // ============================================
      // SCAFFOLD & BACKGROUND
      // ============================================
      scaffoldBackgroundColor: colors.background,

      // ============================================
      // TEXT THEME
      // ============================================
      textTheme: AppTextStyles.lightTextTheme,

      // ============================================
      // APP BAR
      // ============================================
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colors.primaryContainer,
        foregroundColor: colors.textPrimary,
        centerTitle: false,
        titleTextStyle: AppTextStyles.titleLarge(color: colors.textPrimary),
      ),

      // ============================================
      // NAVIGATION BAR
      // ============================================
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: colors.surface,
        indicatorColor: colors.primaryContainer,
        labelTextStyle: WidgetStateProperty.all(AppTextStyles.labelMedium()),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: colors.primary,
              size: AppSpacing.iconMd,
            );
          }
          return IconThemeData(
            color: colors.textSecondary,
            size: AppSpacing.iconMd,
          );
        }),
      ),

      // ============================================
      // CARD THEME
      // ============================================
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.cardRadius),
        color: colors.surface,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xs,
        ),
      ),

      // ============================================
      // ELEVATED BUTTON
      // ============================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.smallRadius),
          textStyle: AppTextStyles.labelLarge(color: colors.onPrimary),
        ),
      ),

      // ============================================
      // OUTLINED BUTTON
      // ============================================
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.ms,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.smallRadius),
          side: BorderSide(color: colors.primary),
          textStyle: AppTextStyles.labelLarge(color: colors.primary),
        ),
      ),

      // ============================================
      // TEXT BUTTON
      // ============================================
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          textStyle: AppTextStyles.labelLarge(color: colors.primary),
        ),
      ),

      // ============================================
      // INPUT DECORATION
      // ============================================
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.buttonRadius,
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.buttonRadius,
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.buttonRadius,
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.buttonRadius,
          borderSide: BorderSide(color: colors.error),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.ms,
        ),
        labelStyle: AppTextStyles.bodyMedium(color: colors.textSecondary),
        hintStyle: AppTextStyles.bodyMedium(color: colors.textTertiary),
      ),

      // ============================================
      // ICON THEME
      // ============================================
      iconTheme: IconThemeData(
        color: colors.textSecondary,
        size: AppSpacing.iconMd,
      ),

      // ============================================
      // DIVIDER
      // ============================================
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: 1,
      ),

      // ============================================
      // SNACKBAR
      // ============================================
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.textPrimary,
        contentTextStyle: AppTextStyles.bodyMedium(color: colors.textOnDark),
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.buttonRadius),
        behavior: SnackBarBehavior.floating,
      ),

      // ============================================
      // DATE PICKER
      // ============================================
      datePickerTheme: DatePickerThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.cardRadius),
      ),

      // ============================================
      // DIALOG
      // ============================================
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.cardRadius),
      ),

      // ============================================
      // LIST TILE
      // ============================================
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        titleTextStyle: AppTextStyles.titleSmall(),
        subtitleTextStyle: AppTextStyles.bodySmall(),
      ),

      // ============================================
      // EXTENSIONS
      // ============================================
      extensions: [LifeLogThemeExtension.light],
    );
  }

  /// Thème sombre
  static ThemeData dark() {
    final colors = AppColors.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // ============================================
      // COLOR SCHEME
      // ============================================
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        primaryContainer: colors.primaryContainer,
        onPrimary: colors.onPrimary,
        onPrimaryContainer: colors.onPrimaryContainer,
        secondary: colors.secondary,
        secondaryContainer: colors.secondaryContainer,
        onSecondary: colors.onSecondary,
        onSecondaryContainer: colors.onSecondaryContainer,
        tertiary: colors.tertiary,
        tertiaryContainer: colors.tertiaryContainer,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        error: colors.error,
        outline: colors.border,
      ),

      // ============================================
      // SCAFFOLD & BACKGROUND
      // ============================================
      scaffoldBackgroundColor: colors.background,

      // ============================================
      // TEXT THEME
      // ============================================
      textTheme: AppTextStyles.darkTextTheme,

      // ============================================
      // APP BAR
      // ============================================
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colors.primaryContainer,
        foregroundColor: colors.textPrimary,
        centerTitle: false,
        titleTextStyle: AppTextStyles.titleLarge(color: colors.textPrimary),
      ),

      // ============================================
      // NAVIGATION BAR
      // ============================================
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: colors.surface,
        indicatorColor: colors.primaryContainer,
        labelTextStyle: WidgetStateProperty.all(
          AppTextStyles.labelMedium(color: colors.textSecondary),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: colors.primary,
              size: AppSpacing.iconMd,
            );
          }
          return IconThemeData(
            color: colors.textSecondary,
            size: AppSpacing.iconMd,
          );
        }),
      ),

      // ============================================
      // CARD THEME
      // ============================================
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.cardRadius),
        color: colors.surface,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xs,
        ),
      ),

      // ============================================
      // ELEVATED BUTTON
      // ============================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.smallRadius),
          textStyle: AppTextStyles.labelLarge(color: colors.onPrimary),
        ),
      ),

      // ============================================
      // OUTLINED BUTTON
      // ============================================
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.ms,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.smallRadius),
          side: BorderSide(color: colors.primary),
          textStyle: AppTextStyles.labelLarge(color: colors.primary),
        ),
      ),

      // ============================================
      // TEXT BUTTON
      // ============================================
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          textStyle: AppTextStyles.labelLarge(color: colors.primary),
        ),
      ),

      // ============================================
      // INPUT DECORATION
      // ============================================
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.buttonRadius,
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.buttonRadius,
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.buttonRadius,
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.buttonRadius,
          borderSide: BorderSide(color: colors.error),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.ms,
        ),
        labelStyle: AppTextStyles.bodyMedium(color: colors.textSecondary),
        hintStyle: AppTextStyles.bodyMedium(color: colors.textTertiary),
      ),

      // ============================================
      // ICON THEME
      // ============================================
      iconTheme: IconThemeData(
        color: colors.textSecondary,
        size: AppSpacing.iconMd,
      ),

      // ============================================
      // DIVIDER
      // ============================================
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: 1,
      ),

      // ============================================
      // SNACKBAR
      // ============================================
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.surface,
        contentTextStyle: AppTextStyles.bodyMedium(color: colors.textPrimary),
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.buttonRadius),
        behavior: SnackBarBehavior.floating,
      ),

      // ============================================
      // DATE PICKER
      // ============================================
      datePickerTheme: DatePickerThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.cardRadius),
      ),

      // ============================================
      // DIALOG
      // ============================================
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.cardRadius),
      ),

      // ============================================
      // LIST TILE
      // ============================================
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        titleTextStyle: AppTextStyles.titleSmall(color: colors.textPrimary),
        subtitleTextStyle: AppTextStyles.bodySmall(color: colors.textSecondary),
      ),

      // ============================================
      // EXTENSIONS
      // ============================================
      extensions: [LifeLogThemeExtension.dark],
    );
  }
}
