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

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  // Load recipes from SQLite
  Future loadRecipes() async {
    final data = await DBHelper.instance.getAllRecipes();
    setState(() {
      recipes = data.map((e) => Recipe(
        id: e['id'], // CRITICAL: Ensure ID is mapped for Edit/Delete
        name: e['name'] ?? '',
        ingredients: e['ingredients'] ?? '',
        steps: e['steps'] ?? '',
        category: e['category'] ?? '',
        time: e['time'] ?? '',
        image: e['image'],
      )).toList();
    });
  }

  // Delete recipe
  Future delete(int id) async {
    await DBHelper.instance.deleteRecipe(id);
    loadRecipes(); // Refresh list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Recipes"),
        backgroundColor: Colors.deepOrange,
      ),
      body: recipes.isEmpty
          ? Center(child: Text("No Recipes Found"))
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final r = recipes[index];
                return Card(
                  margin: EdgeInsets.all(12),
                  child: ListTile(
                    title: Text(r.name),
                    subtitle: Text("${r.category} • ${r.time}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edit Button
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            // Wait for the Edit Screen to pop, then refresh
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditRecipeScreen(recipe: r),
                              ),
                            );
                            loadRecipes(); // Refresh list after editing
                          },
                        ),
                        // Delete Button
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
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
    );
  }
}