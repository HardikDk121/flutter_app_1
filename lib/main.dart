import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Make sure this is in your pubspec.yaml
import 'package:flutter/foundation.dart';
import './models/recipe.dart';
import './database/db_helper.dart';
import './screens/receipe_list.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vesuvio',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}

// --- PRACTICAL 1: Splash Screen ---
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/cooking.png', height: 120),
            const SizedBox(height: 28),
            const Text(
              "Vesuvio",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const Text(
              "Three generations of Buccos sweated over that stove",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// --- PRACTICAL 2: Home Screen ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Recipe Book",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.menu_book, color: Colors.blue),
                label: const Text(
                  "All Recipes",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.grey[900],
                  side: const BorderSide(color: Colors.blue, width: 2),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RecipeListScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.add, color: Colors.blue),
                label: const Text(
                  "Add Recipe",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.grey[900],
                  side: const BorderSide(color: Colors.blue, width: 2),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddRecipeScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.category, color: Colors.blue),
                label: const Text(
                  "Categories",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.grey[900],
                  side: const BorderSide(color: Colors.blue, width: 2),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- PRACTICAL 3: Categories Screen ---
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {"name": "Indian", "icon": Icons.rice_bowl},
      {"name": "Italian", "icon": Icons.local_pizza},
      {"name": "Chinese", "icon": Icons.ramen_dining},
      {"name": "Mexican", "icon": Icons.local_dining},
      {"name": "Desserts", "icon": Icons.cake},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(categories[index]["icon"], size: 50, color: Colors.blue),
                  const SizedBox(height: 10),
                  Text(
                    categories[index]["name"],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- PRACTICAL 4: Add Recipe Screen ---
class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});
  @override
  State<AddRecipeScreen> createState() => AddRecipeScreenState();
}

class AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nametxt = TextEditingController();
  final TextEditingController ingredents = TextEditingController();
  final TextEditingController steps = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();

  String? selectedCategory;
  File? _selectedImage;
  late final List<String> categories = [
    "Indian",
    "Italian",
    "Chinese",
    "Mexican",
    "Desserts",
  ];

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Make sure to import your model and db helper at the top of main.dart
// import 'models/recipe.dart';
// import 'db_helper.dart';

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select category"))
        );
        return;
      }

      // 1. Create the Recipe Object from form controllers
      final newRecipe = Recipe(
        name: nametxt.text,
        ingredients: ingredents.text,
        steps: steps.text,
        category: selectedCategory!,
        time: timecontroller.text,
        image: _selectedImage?.path, // Save file path if an image was selected
      );

      // 2. Insert into the SQLite database
      await DBHelper.instance.insertRecipe(newRecipe);

      // 3. Show Success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Recipe Added Successfully!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
      );

      // 4. Clear the form or Navigate back
      Navigator.pop(context);
    }
  }
  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.blue),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Add Recipes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nametxt,
                style: const TextStyle(color: Colors.white),
                decoration: _buildInputDecoration("Recipe Name"),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter recipe name"
                    : null,
              ),
              const SizedBox(height: 19),
              TextFormField(
                controller: ingredents,
                style: const TextStyle(color: Colors.white),
                decoration: _buildInputDecoration("Recipe Ingredients"),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter ingredients"
                    : null,
              ),
              const SizedBox(height: 19),
              TextFormField(
                controller: steps,
                style: const TextStyle(color: Colors.white),
                decoration: _buildInputDecoration("Steps"),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter steps"
                    : null,
              ),
              const SizedBox(height: 19),
              DropdownButtonFormField<String>(
                initialValue: selectedCategory,
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                decoration: _buildInputDecoration("Select Category"),
                items: categories
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Please select category" : null,
              ),
              const SizedBox(height: 19),
              TextFormField(
                controller: timecontroller,
                style: const TextStyle(color: Colors.white),
                decoration: _buildInputDecoration(
                  "Required Time (e.g., 30 mins)",
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter required time"
                    : null,
              ),
              const SizedBox(height: 19),
              ElevatedButton.icon(
                icon: const Icon(Icons.image, color: Colors.blue),
                label: const Text(
                  "Upload Image (Optional)",
                  style: TextStyle(color: Colors.blue),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[900],
                  side: const BorderSide(color: Colors.blue),
                ),
                onPressed: pickImage,
              ),
              const SizedBox(height: 15),
              if (_selectedImage != null)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Image.file(
                    _selectedImage!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Save Recipe",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- PRACTICAL 5, 6 & 8: All Recipes Screen with Reusable Widget ---
class AllRecipeScreen extends StatelessWidget {
  AllRecipeScreen({super.key});

  final List<Map<String, String>> recipes = [
    {
      "title": "Veg Biryani",
      "category": "Indian",
      "time": "45 mins",
      "image": "assets/images/veg_biranyi.jpg", // using placeholder image
    },
    {
      "title": "Pasta Alfredo",
      "category": "Italian",
      "time": "30 mins",
      "image": "assets/images/pasta.webp",
    },
    {
      "title": "Paneer Butter Masala",
      "category": "Indian",
      "time": "40 mins",
      "image": "assets/images/panner.jpg",
    },
    {
      "title": "Veg Noodles",
      "category": "Chinese",
      "time": "25 mins",
      "image": "assets/images/veg_noodles.jpg",
    },
    {
      "title": "Chocolate Cake",
      "category": "Dessert",
      "time": "60 mins",
      "image": "assets/images/cake.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Recipe List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            // Using Practical 8 RecipeCard here!
            child: RecipeCard(
              title: recipes[index]["title"]!,
              category:
                  "Category: ${recipes[index]["category"]} • Time: ${recipes[index]["time"]}",
              image: recipes[index]["image"]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecipeDetailPage(recipeName: recipes[index]["title"]!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// --- PRACTICAL 7: Recipe Detail Page ---
class RecipeDetailPage extends StatelessWidget {
  final String recipeName;

  RecipeDetailPage({super.key, required this.recipeName});

  final List<String> ingredients = [
    "2 cups Basmati Rice",
    "1 cup Mixed Vegetables",
    "2 Onions",
    "2 Tomatoes",
    "Biryani Masala",
    "Salt",
    "Oil",
  ];

  final List<String> steps = [
    "Wash and soak the rice for 20 minutes.",
    "Heat oil in a pan and fry sliced onions.",
    "Add tomatoes and cook until soft.",
    "Add vegetables and spices.",
    "Add soaked rice and water.",
    "Cook for 20 minutes until rice is done.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          recipeName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              ...ingredients.map((item) {
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.blue),
                  title: Text(
                    item,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Text(
                "Preparation Steps",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              ...steps.asMap().entries.map((entry) {
                int index = entry.key + 1;
                String step = entry.value;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      "$index",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    step,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Edit button clicked")),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text(
                      "Edit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Recipe Deleted")),
                      );
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text(
                      "Delete",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- PRACTICAL 8: Reusable Recipe Card Widget ---
class RecipeCard extends StatelessWidget {
  final String title;
  final String category;
  final String image;
  final VoidCallback? onTap; // Optional: tap action

  const RecipeCard({
    required this.title,
    required this.category,
    required this.image,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[900], // Matched with the app's dark theme
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Colors.blue,
            width: 1,
          ), // Added blue border for theme consistency
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Container(
                color: Colors.black, // Background in case of transparent images
                child: Image.asset(
                  image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit
                      .contain, // Changed to contain so the placeholder displays nicely
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Matched with theme
                    ),
                  ),
                  const SizedBox(height: 5),
                  // CATEGORY
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400], // Visible on dark background
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
