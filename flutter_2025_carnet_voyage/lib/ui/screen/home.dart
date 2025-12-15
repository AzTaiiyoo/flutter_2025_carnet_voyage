import 'package:flutter/material.dart';
import 'package:flutter_2025_carnet_voyage/ui/screen/add_activity.dart';
import 'package:flutter_2025_carnet_voyage/ui/view/map_view.dart';
import '../view/list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  void _navigateToAddActivity() {
    setState(() {
      currentPageIndex = 2; // Index de AddActivity
    });
  }

  void _navigateToMap() {
    setState(() {
      currentPageIndex = 1; // Index de MapView
    });
  }

  void _navigateToList() {
    setState(() {
      currentPageIndex = 0; // Index de SortieListPage
    });
  }

  // Liste des vues (écrans)
  late final List<Widget> _views = [
    const SortieListPage(),
    MapView(onNavigateToAddActivity: _navigateToAddActivity),
    AddActivity(
      onNavigateToMap: _navigateToMap,
      onNavigateToList: _navigateToList,
    ),
  ];

  // Titres correspondants
  final List<String> _titles = ['Mes Sorties', 'Carte', 'Ajouter une sortie'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[currentPageIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        leading: currentPageIndex == 2
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
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
      body: IndexedStack(index: currentPageIndex, children: _views),
    );
  }
}
