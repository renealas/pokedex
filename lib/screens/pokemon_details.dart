// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:pokeball_widget/pokeball_widget.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:string_to_color/string_to_color.dart';

class PokemonDetails extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetails({
    this.pokemon,
  });

  String capitalize(String name) {
    return "${name[0].toUpperCase()}${name.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    Color newColor = ColorUtils.stringToColor(pokemon.color);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 75,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Center(
                            child: Text(
                              capitalize(pokemon.name),
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ),

                  //Image
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      height: screenHeight / 4,
                      width: screenWidth / 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(pokemon.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  //Number in Pokedex
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Type: ${capitalize(pokemon.type)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: newColor,
                      ),
                    ),
                  ),

                  //Number in Pokedex
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Pokedex Entry: ${pokemon.number}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      pokemon.description,
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -10,
              right: -15,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.height / 6,
                child: PokeBallWidget(
                  color: newColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
