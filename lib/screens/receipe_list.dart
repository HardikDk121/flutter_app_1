import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/recipe.dart';
import 'edit_recipe_screen.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Recipe> recipes = [];
  // THE HACK: Store favorited IDs temporarily in memory.
  Set<int> temporaryFavorites = {}; 

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future loadRecipes() async {
    final data = await DBHelper.instance.getAllRecipes();
    setState(() {
      recipes = data.map((e) => Recipe(
        id: e['id'], 
        name: e['name'] ?? '',
        ingredients: e['ingredients'] ?? '',
        steps: e['steps'] ?? '',
        category: e['category'] ?? '',
        time: e['time'] ?? '',
        image: e['image'],
      )).toList();
    });
  }

  Future delete(int id) async {
    await DBHelper.instance.deleteRecipe(id);
    temporaryFavorites.remove(id); // clean up hacky state
    loadRecipes(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Saved Recipes", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
        actions: [
          // THE BUTTON: Go to fake favorites page
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.redAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FakeFavoritesPage(
                    allRecipes: recipes,
                    favoriteIds: temporaryFavorites,
                  ),
                ),
              ).then((_) => setState(() {})); // Refresh hearts on back
            },
          )
        ],
      ),
      body: recipes.isEmpty
          ? const Center(child: Text("No Recipes Found", style: TextStyle(color: Colors.white)))
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final r = recipes[index];
                bool isFav = temporaryFavorites.contains(r.id);

                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.all(12),
                  child: ListTile(
                    title: Text(r.name, style: const TextStyle(color: Colors.blue)),
                    subtitle: Text("${r.category} • ${r.time}", style: const TextStyle(color: Colors.white70)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // THE TOGGLE: Visual only
                        IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.redAccent : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isFav) {
                                temporaryFavorites.remove(r.id);
                              } else {
                                temporaryFavorites.add(r.id!);
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => EditRecipeScreen(recipe: r)),
                            );
                            loadRecipes(); 
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            if (r.id != null) delete(r.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ==========================================
// QUICK & DIRTY FAVORITES PAGE (Same File)
// ==========================================
class FakeFavoritesPage extends StatelessWidget {
  final List<Recipe> allRecipes;
  final Set<int> favoriteIds;

  const FakeFavoritesPage({super.key, required this.allRecipes, required this.favoriteIds});

  @override
  Widget build(BuildContext context) {
    // Filter the master list using the temporary Set
    final favs = allRecipes.where((r) => favoriteIds.contains(r.id)).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Favorites", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.redAccent,
      ),
      body: favs.isEmpty
          ? const Center(child: Text("No favorites yet.", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              itemCount: favs.length,
              itemBuilder: (context, index) {
                final r = favs[index];
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.all(12),
                  child: ListTile(
                    title: Text(r.name, style: const TextStyle(color: Colors.white)),
                    subtitle: Text("${r.category} • ${r.time}", style: const TextStyle(color: Colors.white70)),
                    trailing: const Icon(Icons.favorite, color: Colors.redAccent),
                  ),
                );
              },
            ),
    );
  }
}