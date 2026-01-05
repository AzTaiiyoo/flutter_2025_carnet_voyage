import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_2025_carnet_voyage/blocs/map_cubit.dart';
import 'package:flutter_2025_carnet_voyage/models/address.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_theme_extensions.dart';

/// Widget de barre de recherche d'adresses
/// Design Life-log premium avec coins arrondis et ombres
class AddressSearchBar extends StatefulWidget {
  const AddressSearchBar({super.key});

  @override
  State<AddressSearchBar> createState() => _AddressSearchBarState();
}

class _AddressSearchBarState extends State<AddressSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showSuggestions = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _showSuggestions = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Annuler le timer précédent
    _debounceTimer?.cancel();

    // Attendre 500ms avant de lancer la recherche
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (query.length >= 3) {
        context.read<MapCubit>().searchAddresses(query);
      }
    });
  }

  void _onAddressSelected(Address address) {
    _controller.text = address.toString();
    _focusNode.unfocus();
    setState(() {
      _showSuggestions = false;
    });

    // Debug logging pour le Bug 1
    print('Address selected: $address');
    print('Has coordinates: ${address.hasCoordinates}');
    print('Lat: ${address.latitude}, Lng: ${address.longitude}');

    if (!address.hasCoordinates) {
      // Afficher un message si pas de coordonnées
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Adresse sans coordonnées. Essayez d'entrer l'adresse complète.",
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }

    context.read<MapCubit>().selectAddress(address);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final lifeLogTheme = theme.extension<LifeLogThemeExtension>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Barre de recherche
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: AppSpacing.smallRadius,
            boxShadow: AppShadows.searchBar,
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            style: textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Rechercher une adresse...',
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: lifeLogTheme.iconColorSecondary,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: lifeLogTheme.iconColorSecondary,
              ),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: lifeLogTheme.iconColorSecondary,
                      ),
                      onPressed: () {
                        _controller.clear();
                        context.read<MapCubit>().clearSelection();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.ms + 2,
              ),
            ),
            onChanged: _onSearchChanged,
          ),
        ),

        // Liste de suggestions
        if (_showSuggestions)
          BlocBuilder<MapCubit, MapState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Container(
                  margin: EdgeInsets.only(top: AppSpacing.xs),
                  padding: AppSpacing.cardPadding,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: AppSpacing.smallRadius,
                    boxShadow: AppShadows.soft,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: AppSpacing.iconMd,
                      height: AppSpacing.iconMd,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                );
              }

              if (state.searchResults.isEmpty) {
                return const SizedBox.shrink();
              }

              return Container(
                margin: EdgeInsets.only(top: AppSpacing.xs),
                constraints: const BoxConstraints(maxHeight: 200),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: AppSpacing.smallRadius,
                  boxShadow: AppShadows.medium,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    final Address address = state.searchResults[index];
                    return ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: colorScheme.secondary,
                      ),
                      title: Text(
                        address.street ?? address.city,
                        style: textTheme.titleSmall,
                      ),
                      subtitle: Text(
                        '${address.city}, ${address.postcode}',
                        style: textTheme.bodySmall,
                      ),
                      onTap: () => _onAddressSelected(address),
                    );
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}
