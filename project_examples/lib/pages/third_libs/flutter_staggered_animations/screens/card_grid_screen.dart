import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_animations/widgets/auto_refresh.dart';
import 'package:project_examples/pages/third_libs/flutter_staggered_animations/widgets/empty_card.dart';

class CardGridScreen extends StatefulWidget {
  const CardGridScreen({Key? key}) : super(key: key);

  @override
  CardGridScreenState createState() => CardGridScreenState();
}

class CardGridScreenState extends State<CardGridScreen> {
  @override
  Widget build(BuildContext context) {
    var columnCount = 3;

    return AutoRefresh(
      duration: const Duration(milliseconds: 2000),
      child: Scaffold(
        body: SafeArea(
          child: AnimationLimiter(
            child: GridView.count(
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: columnCount,
              children: List.generate(
                100,
                (int index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: columnCount,
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: const ScaleAnimation(scale: 0.5, child: FadeInAnimation(child: EmptyCard())),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
