import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 1. RENAMED MODEL: Changed from 'Recipe' to 'ApiMeal' to avoid crashing your SQLite model.
class ApiMeal {
  final String name;
  final String image;

  ApiMeal({required this.name, required this.image});

  factory ApiMeal.fromJson(Map<String, dynamic> json) {
    return ApiMeal(
      name: json['strMeal'],
      image: json['strMealThumb'],
    );
  }
}

class ChickenRecipesScreen extends StatefulWidget {
  const ChickenRecipesScreen({super.key});

  @override
  State<ChickenRecipesScreen> createState() => _ChickenRecipesScreenState();
}

class _ChickenRecipesScreenState extends State<ChickenRecipesScreen> {
  List<ApiMeal> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final url = Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=Chicken");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List meals = data['meals'];
        setState(() {
          recipes = meals.map((item) => ApiMeal.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load recipes");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // In reality, you should show an error Snackbar here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2. THEME FIX: Matched your black/blue Vesuvio theme
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Trending Chicken"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.blue))
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  color: Colors.grey[900], // Matched your app's card color
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        recipe.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      recipe.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                );
              },
            ),
    );
  }
}