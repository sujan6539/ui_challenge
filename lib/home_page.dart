import 'package:flutter/material.dart';

import 'custom_ui/hamburger_menu/hamburger_widget.dart';
import 'custom_ui/hero_card.dart';
import 'data/drinks.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HamBurgerWidget(),
        Padding(padding: EdgeInsets.all(8.0)),
        Flexible(
          child: ListView(
            children: [
              Padding(padding: EdgeInsets.all(30)),
              Text(
                "Smoothie King",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(4)),
              Text("Choose Your Drinks",
                  style: Theme.of(context).textTheme.bodyMedium),
              Padding(padding: EdgeInsets.all(10)),
              HeroCard(drink: shakes[0]),
              HeroCard(drink: shakes[1]),
              HeroCard(drink: shakes[2]),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(8.0)),
      ],
    ));
  }
}
