import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/recipe.dart';
class EditRecipeScreen extends StatefulWidget {
final Recipe recipe;
const EditRecipeScreen({super.key, required this.recipe});
@override
_EditRecipeScreenState createState() => _EditRecipeScreenState();
}
class _EditRecipeScreenState extends State<EditRecipeScreen> {
final _formKey = GlobalKey<FormState>();
late TextEditingController nameCtrl;
late TextEditingController ingredientsCtrl;
late TextEditingController stepsCtrl;
late TextEditingController categoryCtrl;
late TextEditingController timeCtrl;
@override
void initState() {
super.initState();
nameCtrl = TextEditingController(text: widget.recipe.name);
ingredientsCtrl = TextEditingController(text: widget.recipe.ingredients);
stepsCtrl = TextEditingController(text: widget.recipe.steps);
categoryCtrl = TextEditingController(text: widget.recipe.category);
timeCtrl = TextEditingController(text: widget.recipe.time);
}
@override
void dispose() {
nameCtrl.dispose();
ingredientsCtrl.dispose();
stepsCtrl.dispose();
categoryCtrl.dispose();
timeCtrl.dispose();
super.dispose();
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text("Edit Recipe")),
body: Padding(
padding: const EdgeInsets.all(16),
child: Form(
key: _formKey,
child: SingleChildScrollView(
child: Column(
children: [
TextFormField(
controller: nameCtrl,
decoration: InputDecoration(labelText: "Recipe Name"),
validator: (value) =>
value!.isEmpty ? "Enter recipe name" : null,
),
TextFormField(
controller: ingredientsCtrl,
decoration: InputDecoration(labelText: "Ingredients"),
maxLines: 3,
),
TextFormField(
controller: stepsCtrl,
decoration: InputDecoration(labelText: "Steps"),
maxLines: 4,
),
TextFormField(
controller: categoryCtrl,
decoration: InputDecoration(labelText: "Category"),
),
TextFormField(
controller: timeCtrl,
decoration: InputDecoration(labelText: "Time Required"),
),
SizedBox(height: 20),
ElevatedButton(
child: Text("Update"),
onPressed: () async {
if (_formKey.currentState!.validate()) {
Recipe updatedRecipe = Recipe(
id: widget.recipe.id,
name: nameCtrl.text,
ingredients: ingredientsCtrl.text,
steps: stepsCtrl.text,
category: categoryCtrl.text,
time: timeCtrl.text,
image: widget.recipe.image,
);
await DBHelper.instance.updateRecipe(updatedRecipe);
Navigator.pop(context);
}
},
),
],
),
),
),
),
);
}
}