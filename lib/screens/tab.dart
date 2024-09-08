import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/maindrawer.dart';
const kInitialFilters = {
    Filter.glutenfree: false,
    Filter.lactosefree: false,
    Filter.vegan: false,
    Filter.vegeterian: false,
  };

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {

  Map<Filter, bool> _selectedfilters = kInitialFilters;

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result= await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentfilters: _selectedfilters),
        ),
      );
      setState(() {
        _selectedfilters = result ?? kInitialFilters;
      });
    }
    else{
      Navigator.of(context).pop();
    }
  }

  int _selectedpageindex = 0;

  void _showsnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  final List<Meal> _favouritemeals = [];
  void _togglemealfavouritestatus(Meal meal) {
    final isexisting = _favouritemeals.contains(meal);
    if (isexisting) {
      setState(() {
        _favouritemeals.remove(meal);
        _showsnackbar("Removed from favourites!");
      });
    } else {
      setState(() {
        _favouritemeals.add(meal);
        _showsnackbar("Added to favourites!");
      });
    }
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedpageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availablemeals = dummyMeals.where((meal) {
      if(_selectedfilters[Filter.glutenfree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedfilters[Filter.lactosefree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedfilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      if(_selectedfilters[Filter.vegeterian]! && !meal.isVegetarian){
        return false;
      }
      return true;
    }).toList();
    Widget activescreen = CategoriesScreen(
      ontogglescreen: _togglemealfavouritestatus,
      availablemeals: availablemeals,
    );

    var activepagetitle = "Categories";
    if (_selectedpageindex == 1) {
      activescreen = Meals(
        meals: _favouritemeals,
        ontogglescreen: _togglemealfavouritestatus,
      );
      activepagetitle = "Your favourites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activepagetitle),
      ),
      drawer: MainDrawer(onselectScreen: setScreen),
      body: activescreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedpageindex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites"),
        ],
      ),
    );
  }
}
