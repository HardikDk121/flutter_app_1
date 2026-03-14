import 'package:flutter/material.dart';

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
            const Text("Vesuvio",  style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue
            )),
           const Text("Three generations of Buccos sweated over that stove",  style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue
            ), textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}

// --- PRACTICAL 2: Home Screen (Vesuvio Theme) ---
class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Changed to black
      appBar: AppBar(
        title: const Text(
          "THE BEAR Secret Recipe Book",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black, // Changed to black
        foregroundColor: Colors.blue, // Changed to blue
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
                icon: const Icon(
                  Icons.menu_book,
                  color: Colors.blue, // Changed to blue
                ),
                label: const Text(
                  "All Recipes",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold), // Changed to blue
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.grey[900], // Dark grey for contrast
                  side: const BorderSide(
                    color: Colors.blue, // Changed to blue
                    width: 2,
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllRecipeScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(
                  Icons.add,
                  color: Colors.blue, // Changed to blue
                ),
                label: const Text(
                  "Add Recipe",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold), // Changed to blue
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.grey[900], // Dark grey for contrast
                  side: const BorderSide(
                    color: Colors.blue, // Changed to blue
                    width: 2,
                  ),
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
                icon: const Icon(
                  Icons.category,
                  color: Colors.blue, // Changed to blue
                ),
                label: const Text(
                  "Categories",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold), // Changed to blue
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.grey[900], // Dark grey for contrast
                  side: const BorderSide(
                    color: Colors.blue, // Changed to blue
                    width: 2,
                  ),
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

// --- PLACEHOLDERS ---

class AllRecipeScreen extends StatelessWidget {
  const AllRecipeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('All Recipes'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
      ),
      body: const Center(child: Text('All Recipes Screen', style: TextStyle(color: Colors.blue))),
    );
  }
}

class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Add Recipe'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
      ),
      body: const Center(child: Text('Add Recipe Screen', style: TextStyle(color: Colors.blue))),
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
      ),
      body: const Center(child: Text('Categories Screen', style: TextStyle(color: Colors.blue))),
    );
  }
}