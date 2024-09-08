import 'package:flutter/material.dart';
enum Filter{
  vegan,
  vegeterian,
  lactosefree,
  glutenfree,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentfilters});
  final Map<Filter, bool> currentfilters;
  @override
  State<FiltersScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FiltersScreen> {
  var gluttenfreefilterset = false;
  var lactosefreefilterset = false;
  var vegetarianfilterset = false;
  var veganfilterset = false;

  @override
  void initState() {
    super.initState();
    gluttenfreefilterset = widget.currentfilters[Filter.glutenfree]!;
    lactosefreefilterset = widget.currentfilters[Filter.lactosefree]!;
    vegetarianfilterset = widget.currentfilters[Filter.vegeterian]!;
    veganfilterset = widget.currentfilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter here!"),
      ),
      body: WillPopScope(
        onWillPop: ()  async {
          Navigator.of(context).pop(
            {
              Filter.glutenfree: gluttenfreefilterset,
              Filter.lactosefree: lactosefreefilterset,
              Filter.vegan: veganfilterset,
              Filter.vegeterian: vegetarianfilterset,
            }
          );
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: gluttenfreefilterset,
              onChanged: (ischecked) {
                setState(() {
                  gluttenfreefilterset = ischecked;
                });
              },
              title: Text(
                "Glutten Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Contains no glutten!",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            SwitchListTile(
              value: lactosefreefilterset,
              onChanged: (ischecked) {
                setState(() {
                  lactosefreefilterset = ischecked;
                });
              },
              title: Text(
                "Lactose Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Contains no lactose!",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            SwitchListTile(
              value: vegetarianfilterset,
              onChanged: (ischecked) {
                setState(() {
                  vegetarianfilterset = ischecked;
                });
              },
              title: Text(
                "Vegeterian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Pure veg!",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            SwitchListTile(
              value: veganfilterset,
              onChanged: (ischecked) {
                setState(() {
                  veganfilterset = ischecked;
                });
              },
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Completely vegan",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
