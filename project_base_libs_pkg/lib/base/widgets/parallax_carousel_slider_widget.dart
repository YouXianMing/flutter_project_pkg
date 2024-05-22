import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/typedef/project_typedef.dart';

class ParallaxCarouselSliderController {
  PageController? _pageController;

  void jumpTo(double value) {
    _pageController?.jumpTo(value);
  }

  void jumpToPage(int value) {
    _pageController?.jumpToPage(value);
  }
}

/// 一个处理视差效果的组件
class ParallaxCarouselSliderWidget extends StatefulWidget {
  /// 数据源
  final List<dynamic> items;

  /// ItemWidgetBuilder
  final ItemWidgetBuilder builder;

  /// 控制器
  final ParallaxCarouselSliderController? controller;

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

  /// 页面粘滞效果
  final bool pageSnapping;

  /// 页面偏移量回调
  final Function(double pageOffset)? onPageOffset;

  const ParallaxCarouselSliderWidget({
    Key? key,
    required this.items,
    required this.builder,
    this.controller,
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
    this.pageSnapping = true,
    this.onPageOffset,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ParallaxCarouselSliderWidgetState();
}

class ParallaxCarouselSliderWidgetState extends State<ParallaxCarouselSliderWidget> {
  late PageController pageController;
  ParallaxCarouselSliderController? controller;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController(viewportFraction: widget.viewportFraction, initialPage: widget.initialPage);
    pageOffset = widget.initialPage.toDouble();

    controller = widget.controller;
    controller?._pageController = pageController;

    // 添加监听
    pageController.addListener(() {
      pageOffset = pageController.page ?? 0;
      if (widget.onPageOffset != null) widget.onPageOffset!(pageOffset);
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
        pageSnapping: widget.pageSnapping,
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
