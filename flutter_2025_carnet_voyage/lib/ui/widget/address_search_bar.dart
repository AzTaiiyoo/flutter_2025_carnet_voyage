import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_2025_carnet_voyage/blocs/map_cubit.dart';
import 'package:flutter_2025_carnet_voyage/models/address.dart';

/// Widget de barre de recherche d'adresses
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
    context.read<MapCubit>().selectAddress(address);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Barre de recherche
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Rechercher une adresse...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        _controller.clear();
                        context.read<MapCubit>().clearSelection();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
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
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              }

              if (state.searchResults.isEmpty) {
                return const SizedBox.shrink();
              }

              return Container(
                margin: const EdgeInsets.only(top: 4),
                constraints: const BoxConstraints(maxHeight: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    final Address address = state.searchResults[index];
                    return ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                      title: Text(
                        address.street ?? address.city,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${address.city}, ${address.postcode}',
                        style: TextStyle(color: Colors.grey[600]),
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
