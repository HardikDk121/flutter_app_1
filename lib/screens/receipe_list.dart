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
  // We need TWO lists now. One for the master data, one for the search results.
  List<Recipe> allRecipes = [];
  List<Recipe> filteredRecipes = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  // Load recipes from SQLite
  Future loadRecipes() async {
    final data = await DBHelper.instance.getAllRecipes();
    final loadedRecipes = data.map((e) => Recipe(
      id: e['id'],
      name: e['name'] ?? '',
      ingredients: e['ingredients'] ?? '',
      steps: e['steps'] ?? '',
      category: e['category'] ?? '',
      time: e['time'] ?? '',
      image: e['image'],
    )).toList();

    setState(() {
      allRecipes = loadedRecipes;
      filteredRecipes = loadedRecipes; // Initially, show everything
    });
  }

  // Delete recipe
  Future delete(int id) async {
    await DBHelper.instance.deleteRecipe(id);
    loadRecipes(); // Refresh list after deletion
    searchController.clear(); // Clear search to prevent weird UI states
  }

  // The Search Logic
  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredRecipes = allRecipes;
      });
      return;
    }

    final results = allRecipes.where((recipe) {
      final name = recipe.name.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();

    setState(() {
      filteredRecipes = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Restored your theme
      appBar: AppBar(
        title: const Text(
          "Saved Recipes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          // THE SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Search Recipes",
                labelStyle: const TextStyle(color: Colors.blue),
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: filterSearch,
            ),
          ),
          
          // THE LIST
          Expanded(
            child: filteredRecipes.isEmpty
                ? const Center(
                    child: Text(
                      "No Recipes Found",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredRecipes.length,
                    itemBuilder: (context, index) {
                      final r = filteredRecipes[index];
                      return Card(
                        color: Colors.grey[900], // Theme match
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            r.name,
                            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${r.category} • ${r.time}",
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EditRecipeScreen(recipe: r),
                                    ),
                                  );
                                  loadRecipes(); 
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () {
                                  if (r.id != null) {
                                    delete(r.id!);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}