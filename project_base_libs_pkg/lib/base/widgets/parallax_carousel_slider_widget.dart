import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/typedef/project_typedef.dart';

/// 一个处理视差效果的组件
class ParallaxCarouselSliderWidget extends StatefulWidget {
  /// 数据源
  final List<dynamic> items;

  /// ItemWidgetBuilder
  final ItemWidgetBuilder builder;

  /// 页面滑动回调
  final ValueChanged<int>? onPageChanged;

  /// ItemWidget的padding
  final EdgeInsets? itemPadding;

  /// 滑动方向
  final Axis scrollDirection;

  /// 页面比例,默认为1
  final double viewportFraction;

  /// 初始化页面,默认0
  final int initialPage;

  /// 背景色
  final Color? backgroundColor;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 视差效果值
  final double parallaxValue;

  /// 滑动风格
  final ScrollPhysics? physics;

  const ParallaxCarouselSliderWidget({
    Key? key,
    required this.items,
    required this.builder,
    this.onPageChanged,
    this.itemPadding,
    this.scrollDirection = Axis.horizontal,
    this.viewportFraction = 1.0,
    this.initialPage = 0,
    this.backgroundColor,
    this.width,
    this.height,
    this.parallaxValue = 0,
    this.physics,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ParallaxCarouselSliderWidgetState();
}

class ParallaxCarouselSliderWidgetState extends State<ParallaxCarouselSliderWidget> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController(viewportFraction: widget.viewportFraction, initialPage: widget.initialPage);
    pageOffset = widget.initialPage.toDouble();

    // 添加监听
    pageController.addListener(() {
      pageOffset = pageController.page ?? 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Axis scrollDirection = widget.scrollDirection;
    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      width: widget.width,
      child: PageView.builder(
        scrollDirection: scrollDirection,
        itemCount: widget.items.length,
        controller: pageController,
        onPageChanged: widget.onPageChanged,
        physics: widget.physics,
        itemBuilder: (c, i) {
          double percentOffset = pageOffset - i;
          late double x = 0;
          late double y = 0;
          late double gap = widget.parallaxValue;
          switch (scrollDirection) {
            case Axis.horizontal:
              x = percentOffset * gap;
              y = 0;
              break;
            case Axis.vertical:
              x = 0;
              y = percentOffset * gap;
              break;
          }

          return Container(
            margin: widget.itemPadding,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(),
            child: Transform.translate(offset: Offset(x, y), child: widget.builder(c, i, widget.items[i])),
          );
        },
      ),
    );
  }
}
