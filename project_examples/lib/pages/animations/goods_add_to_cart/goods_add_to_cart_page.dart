import 'dart:math' as math;

import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class GoodsAddToCartPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const GoodsAddToCartPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => GoodsAddToCartPageState();
}

class GoodsAddToCartPageState extends NormalStatefulWidgetState<GoodsAddToCartPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) => const AnimationsManagerUseDemo();
}

class AnimationsManagerUseDemo extends StatefulWidget {
  const AnimationsManagerUseDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimationsManagerUseDemoState();
}

class _AnimationsManagerUseDemoState extends State<AnimationsManagerUseDemo> with TickerProviderStateMixin {
  static const String _alpha = 'alpha';
  static const String _scale = 'scale';
  static const String _offsetX = 'offsetX';
  static const String _offsetY = 'offsetY';
  late AnimationsManager cartAnimationsManager;

  late Widget _itemWidget;
  final GlobalKey _cartKey = GlobalKey();
  final GlobalKey _itemKey = GlobalKey();

  static const String rotate = 'rotate';
  late AnimationsManager rotateAnimationsManager;

  @override
  void initState() {
    super.initState();

    _itemWidget = Container(width: 80, height: 80, color: Colors.red, key: _itemKey);

    rotateAnimationsManager = AnimationsManager(
      tickerProvider: this,
      duration: const Duration(milliseconds: 300),
      animationObjectMap: {
        rotate: TweenSequenceObject(
          items: [
            TweenSequenceItem(tween: Tween<double>(begin: 0, end: math.pi * 0.15).chain(CurveTween(curve: Curves.linear)), weight: 1),
            TweenSequenceItem(
                tween: Tween<double>(begin: math.pi * 0.15, end: -math.pi * 0.15).chain(CurveTween(curve: Curves.linear)), weight: 1),
            TweenSequenceItem(tween: Tween<double>(begin: -math.pi * 0.15, end: 0).chain(CurveTween(curve: Curves.linear)), weight: 1),
          ],
        ),
      },
    );

    // 动画初始化
    cartAnimationsManager = AnimationsManager(
        tickerProvider: this,
        duration: const Duration(seconds: 2, milliseconds: 100),
        animationObjectMap: {
          _alpha: TweenSequenceObject(
            items: [
              TweenSequenceItem(tween: ConstantTween<double>(0), weight: 0.1), // 为了解决获取中点有误差的问题
              TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.linear)), weight: 1),
              TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.1).chain(CurveTween(curve: Curves.linear)), weight: 1),
            ],
          ),
          _scale: TweenSequenceObject(
            items: [
              TweenSequenceItem(tween: ConstantTween<double>(1), weight: 0.1), // 为了解决获取中点有误差的问题
              TweenSequenceItem(tween: Tween<double>(begin: 2, end: 1).chain(CurveTween(curve: Curves.easeOutQuint)), weight: 1),
              TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.4).chain(CurveTween(curve: Curves.easeOutQuint)), weight: 1),
            ],
          ),
          _offsetX: TweenSequenceObject(items: [TweenSequenceItem(tween: ConstantTween<double>(0), weight: 1)]),
          _offsetY: TweenSequenceObject(items: [TweenSequenceItem(tween: ConstantTween<double>(0), weight: 1)]),
        },
        completedCallback: () {
          rotateAnimationsManager.forward();
        });

    // 延迟1秒后执行动画
    Util.delayedSeconds(1, () {
      Offset offsetCart = _cartKey.globalPaintCenterPoint!;
      Offset offsetItem = _itemKey.globalPaintCenterPoint!;
      Offset offset = offsetCart - offsetItem;

      // 更新offsetX与offsetY的值
      cartAnimationsManager
          .setAnimationObject(
            key: _offsetX,
            value: TweenSequenceObject(
              items: [
                TweenSequenceItem(tween: ConstantTween<double>(0), weight: 0.1), // 为了解决获取中点有误差的问题
                TweenSequenceItem(tween: ConstantTween<double>(0), weight: 1),
                TweenSequenceItem(tween: Tween<double>(begin: 0, end: offset.dx).chain(CurveTween(curve: Curves.linear)), weight: 1),
              ],
            ),
          )
          .setAnimationObject(
            key: _offsetY,
            value: TweenSequenceObject(
              items: [
                TweenSequenceItem(tween: ConstantTween<double>(0), weight: 0.1), // 为了解决获取中点有误差的问题
                TweenSequenceItem(tween: ConstantTween<double>(0), weight: 1),
                TweenSequenceItem(tween: Tween<double>(begin: 0, end: offset.dy).chain(CurveTween(curve: Curves.easeInExpo)), weight: 1),
              ],
            ),
          );

      cartAnimationsManager.forward();
    });
  }

  @override
  void dispose() {
    cartAnimationsManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Container(), cartItemsAnimationWidget(), Positioned(bottom: 50, left: 30, child: cartIconAnimationWidget())],
    );
  }

  Widget cartItemsAnimationWidget() {
    return cartAnimationsManager.animatedBuilder(
      child: _itemWidget,
      builder: (context, child) => Opacity(
        opacity: cartAnimationsManager.animationByKey(_alpha).value,
        child: Transform.translate(
          offset: Offset(cartAnimationsManager.animationByKey(_offsetX).value, cartAnimationsManager.animationByKey(_offsetY).value),
          child: Transform.scale(
              scale: cartAnimationsManager.animationByKey(_scale).value, child: Container(alignment: Alignment.center, child: child)),
        ),
      ),
    );
  }

  Widget cartIconAnimationWidget() {
    return rotateAnimationsManager.animatedBuilder(
        child: Icon(Icons.add_shopping_cart, size: 40, key: _cartKey),
        builder: (context, child) {
          return Transform.rotate(angle: rotateAnimationsManager.animationByKey(rotate).value, child: child);
        });
  }
}
