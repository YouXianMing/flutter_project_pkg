import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class CarouselSliderPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const CarouselSliderPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => CarouselSliderPageState();
}

class CarouselSliderPageState extends NormalStatefulWidgetState<CarouselSliderPage> {
  late FlipCardController controller;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  void initState() {
    super.initState();
    controller = FlipCardController();
  }

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverListSection.staticTypeWidget(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 100.0,
                viewportFraction: 0.6,
                onPageChanged: (index, reason) => appPrint(index),
              ),
              items: [0, 1, 2, 3, 4, 5, 6].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(color: Colors.amber),
                        child: Text('$i', style: const TextStyle(fontSize: 16.0)));
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 4 / 1,
                viewportFraction: 0.95,
                onPageChanged: (index, reason) => appPrint(index),
              ),
              items: [0, 1, 2, 3, 4, 5, 6].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Util.randomColor.withOpacity(0.5)),
                        child: Text('$i', style: const TextStyle(fontSize: 16.0)));
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 3,
                viewportFraction: 1,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) => appPrint(index),
              ),
              items: [0, 1, 2, 3, 4, 5, 6].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Util.randomColor.withOpacity(0.5)),
                        child: Text('$i', style: const TextStyle(fontSize: 16.0)));
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 3,
                viewportFraction: 0.75,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) => appPrint(index),
              ),
              items: [0, 1, 2, 3, 4, 5, 6].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Util.randomColor.withOpacity(0.5)),
                        child: Text('$i', style: const TextStyle(fontSize: 16.0)));
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                scrollDirection: Axis.vertical,
                aspectRatio: 1.75,
                viewportFraction: 0.55,
                onPageChanged: (index, reason) => appPrint(index),
              ),
              items: [0, 1, 2, 3, 4, 5, 6].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Util.randomColor.withOpacity(0.5)),
                        child: Text('$i', style: const TextStyle(fontSize: 16.0)));
                  },
                );
              }).toList(),
            ),
            SafeAreaPaddingWidget.bottom(),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}
