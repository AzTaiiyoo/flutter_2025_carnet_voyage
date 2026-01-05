import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/sortie.dart';
import '../../blocs/sortie_cubit.dart';
import '../../core/theme/app_spacing.dart';
import '../widget/sortie_card.dart';

/// Page de liste des sorties avec design Life-log premium
class SortieListPage extends StatefulWidget {
  const SortieListPage({super.key});

  @override
  State<SortieListPage> createState() => _SortieListPageState();
}

class _SortieListPageState extends State<SortieListPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<SortieCubit, List<Sortie>>(
      builder: (context, sorties) {
        if (sorties.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.travel_explore,
                  size: AppSpacing.avatarXl,
                  color: colorScheme.outline.withOpacity(0.5),
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  'Aucune sortie enregistrée',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Appuyez sur + pour ajouter une sortie',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: AppSpacing.listPadding,
          itemCount: sorties.length,
          itemBuilder: (BuildContext context, int index) {
            final Sortie sortie = sorties[index];
            return SortieCard(
              sortie: sortie,
              onTap: () {
                // TODO: Navigation vers la page de détail
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Détails de: ${sortie.name}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
