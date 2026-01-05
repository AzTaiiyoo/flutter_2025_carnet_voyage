import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_2025_carnet_voyage/core/theme/app_shadows.dart';
import 'package:flutter_2025_carnet_voyage/core/theme/app_spacing.dart';
import '../../models/sortie.dart';

/// Widget de marqueur personnalisé pour afficher une activité sur la carte
class ActivityMarkerWidget extends StatelessWidget {
  final Sortie sortie;
  final VoidCallback? onTap;

  const ActivityMarkerWidget({super.key, required this.sortie, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bloc d'information (Bulle)
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              boxShadow: AppShadows.soft,
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Mini photo
                _buildAvatar(colorScheme),
                const SizedBox(width: 8),
                // Nom tronqué
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 80),
                    child: Text(
                      sortie.name,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Petit pointeur triangle vers le bas
          CustomPaint(
            size: const Size(12, 6),
            painter: _MarkerTrianglePainter(color: colorScheme.surface),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(ColorScheme colorScheme) {
    if (sortie.imageUrl != null && sortie.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        child: Image.file(
          File(sortie.imageUrl!),
          width: 30,
          height: 30,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildDefaultIcon(colorScheme),
        ),
      );
    }
    return _buildDefaultIcon(colorScheme);
  }

  Widget _buildDefaultIcon(ColorScheme colorScheme) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Icon(Icons.place, size: 16, color: colorScheme.primary),
    );
  }
}

/// Dessine le petit triangle sous la bulle du marqueur
class _MarkerTrianglePainter extends CustomPainter {
  final Color color;
  _MarkerTrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
