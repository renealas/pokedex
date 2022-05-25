// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:pokedex/widgets/icons/pokeball_icon.dart';

class PokeBallLoading extends StatefulWidget {
  final double height;

  PokeBallLoading({this.height});

  @override
  State<PokeBallLoading> createState() => _PokeBallLoadingState();
}

class _PokeBallLoadingState extends State<PokeBallLoading>
    with SingleTickerProviderStateMixin {
  double fraction = 0.0;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(
          seconds: 2,
        ),
        vsync: this);
    controller.addListener(() {
      setState(() {
        fraction = controller.value;
      });
    });
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      child: Center(
        child: PokeBallIcon(
          height: widget.height != null ? widget.height : 100,
          width: widget.height != null ? widget.height : 100,
          color: Colors.black,
          fraction: fraction,
        ),
      ),
    );
  }
}
