import 'package:flutter/material.dart';
import 'package:flutter_2025_carnet_voyage/ui/screen/add_activity.dart';
import 'package:flutter_2025_carnet_voyage/ui/view/map_view.dart';
import '../../models/sortie.dart';
import '../view/list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
  Sortie? _sortieToEdit;

  void _navigateToAddActivity() {
    setState(() {
      _sortieToEdit = null;
      currentPageIndex = 2; // Index de AddActivity
    });
  }

  void _navigateToEditActivity(Sortie sortie) {
    setState(() {
      _sortieToEdit = sortie;
      currentPageIndex = 2; // Index de AddActivity
    });
  }

  void _navigateToMap() {
    setState(() {
      // Ne pas effacer _sortieToEdit pour conserver les données en mode édition
      currentPageIndex = 1; // Index de MapView
    });
  }

  void _navigateBackToForm() {
    // Retour au formulaire en préservant _sortieToEdit (utilisé depuis la carte)
    setState(() {
      currentPageIndex = 2; // Index de AddActivity
    });
  }

  void _navigateToList() {
    setState(() {
      _sortieToEdit = null;
      currentPageIndex = 0; // Index de SortieListPage
    });
  }

  @override
  Widget build(BuildContext context) {
    // Liste des vues (écrans) - recréée à chaque build pour avoir la bonne sortie
    final List<Widget> views = [
      SortieListPage(onEditSortie: _navigateToEditActivity),
      MapView(onNavigateToAddActivity: _navigateBackToForm),
      AddActivity(
        onNavigateToMap: _navigateToMap,
        onNavigateToList: _navigateToList,
        sortieToEdit: _sortieToEdit,
      ),
    ];


    // Titres correspondants
    final String title = currentPageIndex == 2
        ? (_sortieToEdit != null ? 'Modifier la sortie' : 'Ajouter une sortie')
        : (currentPageIndex == 1 ? 'Carte' : 'Mes Sorties');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        leading: currentPageIndex == 2
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _sortieToEdit = null;
                    currentPageIndex = 0; // Retour à la liste
                  });
                },
              )
            : null,
        actions: [
          if (currentPageIndex == 0)
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Ajouter une sortie',
              onPressed: _navigateToAddActivity,
            ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _sortieToEdit = null;
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        selectedIndex: currentPageIndex > 1 ? 0 : currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.list),
            icon: Icon(Icons.list_outlined),
            label: 'Liste',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map),
            icon: Icon(Icons.map_outlined),
            label: 'Carte',
          ),
        ],
      ),
      body: IndexedStack(index: currentPageIndex, children: views),
    );
  }
}

