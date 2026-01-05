import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/sortie.dart';
import '../../blocs/sortie_cubit.dart';
import '../widget/sortie_card.dart';

class SortieListPage extends StatefulWidget {
  final void Function(Sortie)? onEditSortie;

  const SortieListPage({super.key, this.onEditSortie});

  @override
  State<SortieListPage> createState() => _SortieListPageState();
}

class _SortieListPageState extends State<SortieListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortieCubit, List<Sortie>>(
      builder: (context, sorties) {
        if (sorties.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.travel_explore, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  'Aucune sortie enregistrée',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Appuyez sur + pour ajouter une sortie',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          itemCount: sorties.length,
          itemBuilder: (BuildContext context, int index) {
            final Sortie sortie = sorties[index];
            return SortieCard(
              sortie: sortie,
              onTap: () {
                if (widget.onEditSortie != null) {
                  widget.onEditSortie!(sortie);
                }
              },
              onDelete: () {
                context.read<SortieCubit>().deleteSortie(sortie.id);
              },
            );
          },
        );
      },
    );
  }
}

