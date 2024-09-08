import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
//import 'package:meals';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.ontogglescreen, required this.availablemeals});
  final void Function(Meal meal) ontogglescreen;
  final List<Meal> availablemeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
    lowerBound: 0,
    upperBound: 1,
    );
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  void _selectCategory(BuildContext context, Category category) {
    final filteredcategory = widget.availablemeals.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>  Meals(
          title: category.title,
          meals: filteredcategory, ontogglescreen: widget.ontogglescreen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
                category: category,
                onselectCategory: () {
                  _selectCategory(context, category);
                }),
        ],
      ),
    );
  }
}
