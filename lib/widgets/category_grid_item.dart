
import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget{
  const CategoryGridItem({super.key, required this.category, required this.onselectCategory});
  final Category category;
  final void Function() onselectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onselectCategory,
      splashColor: Theme.of(context).primaryColor,
      //borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            category.color,
            category.color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          )
        ),
        child: Text(category.title, style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),),
      
      ),
    );
  }
}