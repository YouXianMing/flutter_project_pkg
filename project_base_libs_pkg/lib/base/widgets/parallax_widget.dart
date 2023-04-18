import 'package:flutter/material.dart';
import 'dart:math' as math;

// -------------------- 水平方向视差效果组件 --------------------
// 参考 https://pub.flutter-io.cn/packages/parallax 修改

typedef ParallaxItemWidgetBuilder = Widget Function(
  BuildContext context,
  int index,
  dynamic data,
  double? height,
  double? width,
  Alignment alignment,
);

class ParallaxWidget extends StatefulWidget {
  /// 数据源
  final List<dynamic> items;

  /// widget构造器
  final ParallaxItemWidgetBuilder builder;

  /// 倾斜值alpha
  final double? skewAlpha;

  /// 倾斜值beta
  final double? skewBeta;

  /// 高度
  final double? height;

  /// 宽度
  final double? width;

  /// 水平方向上的padding值
  final double paddingHorizontal;

  /// 页面占据视口倍率
  final double viewportFraction;

  /// 圆角值
  final double borderRadius;

  /// physics
  final ScrollPhysics physics;

  /// 视差倍率值
  final double parallaxMultiple;

  /// 页面值改变回调
  final Function(int)? onPageChanged;

  const ParallaxWidget({
    Key? key,
    required this.items,
    required this.builder,
    this.height,
    this.width,
    this.viewportFraction = 0.75,
    this.skewAlpha,
    this.skewBeta,
    this.borderRadius = 0.0,
    this.paddingHorizontal = 10,
    this.physics = const ClampingScrollPhysics(),
    this.parallaxMultiple = 1.2,
    this.onPageChanged,
  }) : super(key: key);

  @override
  ParallaxWidgetState createState() => ParallaxWidgetState();
}

class ParallaxWidgetState extends State<ParallaxWidget> {
  late PageController pageController;
  late double? pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: widget.viewportFraction);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: PageView.builder(
        physics: widget.physics,
        itemCount: widget.items.length,
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: widget.onPageChanged,
        itemBuilder: (context, i) {
          Widget itemWidget = widget.builder(
            context,
            i,
            widget.items[i],
            widget.height,
            widget.width,
            Alignment((-pageOffset!.abs() + i) * widget.parallaxMultiple.abs(), 0),
          );

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal, vertical: 0),
            child: Transform(
              transform: Matrix4.skew(math.pi * (widget.skewAlpha ?? 0) / 180, math.pi * (widget.skewBeta ?? 0) / 180),
              child: Stack(
                alignment: AlignmentDirectional.center,
                fit: StackFit.loose,
                children: <Widget>[
                  widget.borderRadius > 0
                      ? ClipRRect(borderRadius: BorderRadius.circular(widget.borderRadius), child: itemWidget)
                      : itemWidget,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
