import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:project_base_libs_pkg/base/others/linear_equation.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class SliverSectionsPage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const SliverSectionsPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => SliverSectionsPageState();
}

class SliverSectionsPageState extends NormalStatefulWidgetState<SliverSectionsPage> {
  final LinearEquation linearEquation = LinearEquation();
  final ScrollController scrollController = ScrollController();
  final StickyHeaderController stickyHeaderController = StickyHeaderController();
  bool useSliverAppBar = false;

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    stickyHeaderController.dispose();
  }

  List<double> waterfallHeights = [
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
    60 + Util.randomDouble(max: 50),
  ];

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return useSliverAppBar ? null : NormalAppBar(context: context, title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''));
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              /// SliverAppBarSection
              useSliverAppBar
                  ? SliverAppBarSection.widget(
                      backgroundColor: Colors.grey,
                      // title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
                      pinned: true,
                      expandedHeight: 150,
                      flexibleSpace: FlexibleSpaceBar(
                        title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''),
                        background: Image.network('https://images0.cnblogs.com/i/607542/201407/051742386849988.png', fit: BoxFit.cover),
                      ),
                    )
                  : SliverBoxAdapterSection(builder: (d) => const SizedBox()).buildWidget(),

              /// SliverListSection.builder
              SliverListSection.builderTypeWidget(
                headerBuilder: (_) => header('SliverListSection.builder'),
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9],
                builder: (c, i, d) => SizedBox(height: 60, child: Card(child: Center(child: Text(d.toString())))),
              ),

              /// SliverListSection.static
              SliverListSection.staticTypeWidget(
                headerBuilder: (_) => header('SliverListSection.static'),
                children: [
                  SizedBox(height: 60, child: Card(child: Center(child: Text(1.toString())))),
                  SizedBox(height: 60, child: Card(child: Center(child: Text(2.toString())))),
                  SizedBox(height: 60, child: Card(child: Center(child: Text(3.toString())))),
                ],
              ),

              /// SliverFixedExtentListSection.builder
              SliverFixedExtentListSection.builderTypeWidget(
                itemExtent: 40,
                headerBuilder: (_) => header('SliverFixedExtentListSection.builder'),
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9],
                builder: (c, i, d) => SizedBox(height: 60, child: Card(child: Center(child: Text(d.toString())))),
              ),

              /// SliverFixedExtentListSection.static
              SliverFixedExtentListSection.staticTypeWidget(
                itemExtent: 40,
                headerBuilder: (_) => header('SliverFixedExtentListSection.static'),
                children: [
                  SizedBox(child: Card(child: Center(child: Text(1.toString())))),
                  SizedBox(child: Card(child: Center(child: Text(2.toString())))),
                  SizedBox(child: Card(child: Center(child: Text(3.toString())))),
                ],
              ),

              /// SliverPrototypeExtentListSection.builder
              SliverPrototypeExtentListSection.builderTypeWidget(
                prototypeItemBuilder: () => const SizedBox(height: 50),
                headerBuilder: (_) => header('SliverPrototypeExtentListSection.builder'),
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9],
                builder: (c, i, d) => Center(child: Text(d.toString())),
              ),

              /// SliverPrototypeExtentListSection.static
              SliverPrototypeExtentListSection.staticTypeWidget(
                prototypeItemBuilder: () => const SizedBox(height: 40),
                headerBuilder: (_) => header('SliverPrototypeExtentListSection.static'),
                children: [
                  Center(child: Text(1.toString())),
                  Center(child: Text(2.toString())),
                  Center(child: Text(3.toString())),
                ],
              ),

              /// SliverGridSection.builder
              SliverGridSection.builderTypeWidget(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                headerBuilder: (_) => header('SliverGridSection.builder'),
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9],
                builder: (c, i, d) => SizedBox(child: Card(child: Center(child: Text(d.toString())))),
              ),

              /// SliverGridSection.static
              SliverGridSection.staticTypeWidget(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                headerBuilder: (_) => header('SliverGridSection.static'),
                children: [
                  SizedBox(child: Card(child: Center(child: Text(1.toString())))),
                  SizedBox(child: Card(child: Center(child: Text(2.toString())))),
                  SizedBox(child: Card(child: Center(child: Text(3.toString())))),
                ],
              ),

              /// SliverGridCrossAxisExtentSection.builder
              SliverGridCrossAxisExtentSection.builderTypeWidget(
                maxCrossAxisExtent: 100, // 最大宽度100
                mainAxisExtent: 100, // 高度100,设置了mainAxisExtent后,childAspectRatio会失效
                // childAspectRatio: 0.75,
                headerBuilder: (_) => header('SliverGridWithMaxCrossAxisExtentSection.builder'),
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9],
                builder: (c, i, d) => SizedBox(child: Card(child: Center(child: Text(d.toString())))),
              ),

              /// SliverGridCrossAxisExtentSection.static
              SliverGridCrossAxisExtentSection.staticTypeWidget(
                maxCrossAxisExtent: 100, // 最大宽度100
                mainAxisExtent: 50, // 高度50,设置了mainAxisExtent后,childAspectRatio会失效
                headerBuilder: (_) => header('SliverGridWithMaxCrossAxisExtentSection.static'),
                children: [
                  SizedBox(child: Card(child: Center(child: Text(1.toString())))),
                  SizedBox(child: Card(child: Center(child: Text(2.toString())))),
                  SizedBox(child: Card(child: Center(child: Text(3.toString())))),
                  SizedBox(child: Card(child: Center(child: Text(4.toString())))),
                  SizedBox(child: Card(child: Center(child: Text(5.toString())))),
                  SizedBox(child: Card(child: Center(child: Text(6.toString())))),
                ],
              ),

              /// SliverWaterfallFlowSection.builder
              SliverWaterfallFlowSection.builderTypeWidget(
                stickyHeaderController: stickyHeaderController,
                headerBuilder: (_) => header('SliverWaterfallFlowSection.builder (点击我)').addTapEvent(
                  () {
                    if (useSliverAppBar) {
                      // 使用SliverAppBar高度计算
                      if (scrollController.offset >
                          stickyHeaderController.stickyHeaderScrollOffset - (MediaQuery.of(context).padding.top + kToolbarHeight)) {
                        scrollController.animateTo(
                          stickyHeaderController.stickyHeaderScrollOffset - (MediaQuery.of(context).padding.top + kToolbarHeight),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else {
                      // 不用SliverAppBar高度计算
                      if (scrollController.offset > stickyHeaderController.stickyHeaderScrollOffset) {
                        scrollController.animateTo(
                          stickyHeaderController.stickyHeaderScrollOffset,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                  },
                ),
                crossAxisCount: 3,
                items: waterfallHeights,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                padding: const EdgeInsets.all(10),
                builder: (c, i, d) {
                  return Container(
                    width: double.infinity,
                    height: d * 2,
                    color: Util.randomOpaqueColor.withOpacity(0.3),
                    child: Center(child: Text((i + 1).toString())),
                  );
                },
              ),

              /// SliverWaterfallFlowSection.static
              SliverWaterfallFlowSection.staticTypeWidget(
                headerBuilder: (_) => header('SliverWaterfallFlowSection.static'),
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                padding: const EdgeInsets.all(10),
                children: [
                  AspectRatio(aspectRatio: 1.1, child: Container(color: Util.randomOpaqueColor.withOpacity(0.3))),
                  AspectRatio(aspectRatio: 0.5, child: Container(color: Util.randomOpaqueColor.withOpacity(0.3))),
                  AspectRatio(aspectRatio: 1.3, child: Container(color: Util.randomOpaqueColor.withOpacity(0.3))),
                  AspectRatio(aspectRatio: 0.8, child: Container(color: Util.randomOpaqueColor.withOpacity(0.3))),
                  AspectRatio(aspectRatio: 1.2, child: Container(color: Util.randomOpaqueColor.withOpacity(0.3))),
                  AspectRatio(aspectRatio: 1.6, child: Container(color: Util.randomOpaqueColor.withOpacity(0.3))),
                  AspectRatio(aspectRatio: 0.9, child: Container(color: Util.randomOpaqueColor.withOpacity(0.3))),
                ],
              ),

              /// SliverLayoutBuilderSection
              SliverLayoutBuilderSection.widget(
                data: 'SliverLayoutBuilderSection\nSliverPersistentHeaderSection',
                builder: (context, constraints, data) {
                  // appPrint(
                  //     '${scrollController.offset} ${constraints.remainingPaintExtent} ${constraints.viewportMainAxisExtent} ${constraints.precedingScrollExtent}');
                  double max = constraints.viewportMainAxisExtent;
                  double height1 = 50;
                  double height2 = height1 + 30;
                  linearEquation.startCalculateOnlyOnceWith(pointA: MATHPoint(x: max - height2, y: height1), pointB: MATHPoint(x: max, y: height2));
                  double height = linearEquation.k * constraints.remainingPaintExtent + linearEquation.b;
                  if (height < height1) {
                    height = height1;
                  } else if (height > height2) {
                    height = height2;
                  }
                  return SliverPersistentHeaderSection.widget(
                      data: data,
                      maxExtent: height,
                      minExtent: height,
                      // pinned: true,
                      shouldRebuild: false,
                      builder: (BuildContext context, double shrinkOffset, bool overlapsContent, dynamic data) {
                        return Container(
                          color: Colors.white,
                          child: Center(
                            child: WidgetsFactory.textContainer(data,
                                textAlign: TextAlign.center,
                                backgroundColor: Colors.lightBlueAccent,
                                textColor: Colors.white,
                                padding: const EdgeInsets.all(5)),
                          ),
                        );
                      });
                },
              ),

              /// SliverHorizontalGridSection
              SliverHorizontalGridSection.widget(
                height: 200,
                backgroundColor: Colors.white,
                childAspectRatio: 0.45,
                crossAxisCount: 2,
                headerBuilder: (_) => header('SliverHorizontalGridSection'),
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9],
                builder: (c, i, d) => SizedBox(height: 60, child: Card(child: Center(child: Text(d.toString())))),
              ),

              /// SliverPersistentHeaderSection
              SliverPersistentHeaderSection.widget(
                  data: 'SliverPersistentHeaderSection',
                  maxExtent: 100,
                  minExtent: 40,
                  builder: (BuildContext context, double shrinkOffset, bool overlapsContent, dynamic data) {
                    return Center(
                        child: WidgetsFactory.textContainer(data,
                            backgroundColor: Colors.blueGrey, textColor: Colors.white, padding: const EdgeInsets.all(5)));
                  }),

              /// SliverVerticalGridSection
              SliverVerticalGridSection.widget(
                crossAxisCount: 3,
                backgroundColor: Colors.white,
                childAspectRatio: 0.75,
                headerBuilder: (_) => header('SliverVerticalGridSection'),
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9],
                builder: (c, i, d) => SizedBox(child: Card(child: Center(child: Text(d.toString())))),
              ),

              /// SliverBoxAdapterSection
              SliverBoxAdapterSection.widget(
                headerBuilder: (_) => header('SliverBoxAdapterSection'),
                data: '数据',
                builder: (d) => SizedBox(height: 150, child: Card(child: Center(child: Text(d.toString())))),
              ),

              /// SliverWrapSection
              SliverWrapSection.widget(
                padding: const EdgeInsets.all(10),
                headerBuilder: (_) => header('SliverWrapSection'),
                spacing: 10,
                runSpacing: 10,
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
                builder: (i, d) => wrapItem(d),
              ),

              /// SliverStaggeredGridCountBuilderSection
              SliverStaggeredGridCountBuilderSection.widget(
                headerBuilder: (_) => header('SliverStaggeredGridCountBuilderSection\n瀑布流不建议使用此控件的sliver版本,有bug'),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                items: [
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '1'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '2'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '3'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '4'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '5'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '6'),
                  StaggeredGridCountData(2, 0.5, data: 'ad'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '7'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '8'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '9'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '10'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '11'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '12'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '13'),
                  StaggeredGridFixedCountData(1 / (Util.randomPercent + 1), data: '14'),
                ],
                builder: (context, index, data) => Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    data.data.toString(),
                  ),
                ),
              ),

              /// SliverBoxAdapterSection
              SliverBoxAdapterSection.widget(
                headerBuilder: (_) => header('SliverBoxAdapterSection\nStaggeredGridViewCountWidget.inScrollView'),
                builder: (_) => StaggeredGridViewCountWidget.inScrollView(
                  items: [
                    StaggeredGridCountData(1, 1, data: '1'),
                    StaggeredGridCountData(2, 1, data: '2'),
                    StaggeredGridCountData(1, 2, data: '3'),
                    StaggeredGridCountData(3, 2, data: '4'),
                    StaggeredGridCountData(1, 1, data: '5'),
                    StaggeredGridCountData(4, 1, data: '6'),
                    StaggeredGridCountData(1, 1, data: '7'),
                    StaggeredGridCountData(2, 1, data: '8'),
                    StaggeredGridCountData(1, 2, data: '9'),
                    StaggeredGridCountData(3, 2, data: '10'),
                    StaggeredGridCountData(1, 1, data: '11'),
                    StaggeredGridCountData(4, 1, data: '12'),
                  ],
                  builder: (context, index, data) => Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      data.data.toString(),
                    ),
                  ),
                  crossAxisCount: 4,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            ],
          ),
        ),
        Container(height: 1, color: HexColor('#e1e1e1')),
        const SafeAreaPaddingWidget(type: SafeAreaPadding.bottom),
      ],
    );
  }

  Widget header(String text) {
    return Container(
      height: 40,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(alignment: Alignment.center, color: HexColor('#e1e1e1'), child: Text(text, textAlign: TextAlign.center)),
          ),
          Container(height: 1, color: HexColor('#f7f7f7')),
        ],
      ),
    );
  }

  Widget wrapItem(dynamic data) {
    return Container(
      alignment: Alignment.center,
      width: Util.randomDouble(min: 50, max: 80),
      height: Util.randomDouble(min: 40, max: 40),
      color: Colors.grey,
      child: WidgetsFactory.text(data.toString(), color: Colors.white),
    );
  }
}
