import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme_extensions.dart';
import 'form_card.dart';
import 'section_header.dart';

/// Widget de notation par étoiles (1-5)
class RatingInput extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRatingChanged;

  const RatingInput({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final lifeLogTheme = Theme.of(context).extension<LifeLogThemeExtension>()!;

    return FormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.star,
            title: 'Note',
          ),
          SizedBox(height: AppSpacing.sm),
          _buildStarsRow(lifeLogTheme),
          if (rating > 0) _buildClearButton(),
        ],
      ),
    );
  }

  Widget _buildStarsRow(LifeLogThemeExtension lifeLogTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: lifeLogTheme.ratingStarColor,
            size: 36,
          ),
          onPressed: () {
            onRatingChanged(index + 1.0);
          },
        );
      }),
    );
  }

  Widget _buildClearButton() {
    return Center(
      child: TextButton(
        onPressed: () => onRatingChanged(0),
        child: const Text('Effacer la note'),
      ),
    );
  }
}
