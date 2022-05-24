// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:pokeball_widget/pokeball_widget.dart';
import 'package:string_to_color/string_to_color.dart';

class PokeCard extends StatelessWidget {
  final String name;
  final int number;
  final String image;
  final String type;
  final String color;

  PokeCard({
    this.name,
    this.number,
    this.image,
    this.type,
    this.color,
  });

  String capitalize(String name) {
    return "${name[0].toUpperCase()}${name.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    Color newColor = ColorUtils.stringToColor(color);

    return ConstrainedBox(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height / 7),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Positioned(
                right: constraints.maxWidth * -0.04,
                top: constraints.minHeight * 0.1,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.height / 6,
                  child: PokeBallWidget(
                    color: newColor,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.height / 7,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            capitalize(name),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Pokedex Entry: $number',
                            style: TextStyle(
                              fontSize: 14,
                              //fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
