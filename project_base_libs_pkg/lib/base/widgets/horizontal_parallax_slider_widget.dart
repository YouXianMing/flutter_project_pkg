import 'package:flutter/material.dart';

class HorizontalParallaxSliderWidget extends StatefulWidget {
  /// 组件宽度
  final double width;

  /// 组件高度
  final double height;

  /// 视差效果值
  final double parallaxValue;

  /// 初始时的x值,默认值为0
  final double initPositionX;

  /// 页面粘滞效果
  final bool pageSnapping;

  /// 数据源
  final List<dynamic> items;

  /// widgetBuilder
  final Widget Function(double width, double height, BuildContext context, int index, dynamic data) widgetBuilder;

  /// positionItemBuilder
  final Positioned Function(double width, double height, BuildContext context, int index, dynamic data)? positionItemBuilder;

  const HorizontalParallaxSliderWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.parallaxValue,
    this.initPositionX = 0,
    this.pageSnapping = false,
    required this.items,
    required this.widgetBuilder,
    this.positionItemBuilder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => HorizontalParallaxSliderWidgetState();
}

class HorizontalParallaxSliderWidgetState extends State<HorizontalParallaxSliderWidget> {
  late PageController _pageController;
  double _pageOffset = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 1, initialPage: 0);

    // 添加监听并实时修改位移值
    _pageController.addListener(() {
      _pageOffset = _pageController.page ?? 0;
      setState(() {});
    });

    if (widget.initPositionX > 0) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _pageController.jumpTo(widget.initPositionX);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        controller: _pageController,
        physics: const ClampingScrollPhysics(),
        pageSnapping: widget.pageSnapping,
        itemBuilder: (c, i) {
          double percentOffset = _pageOffset - i;
          double gap = widget.parallaxValue;
          double x = percentOffset * gap;

          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Transform.translate(
                    offset: Offset(x, 0),
                    child: widget.widgetBuilder(widget.width, widget.height, c, i, widget.items[i]),
                  ),
                ),
                widget.positionItemBuilder != null
                    ? widget.positionItemBuilder!(widget.width, widget.height, c, i, widget.items[i])
                    : const Positioned(child: SizedBox()),
              ],
            ),
          );
        },
      ),
    );
  }
}
