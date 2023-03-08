import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class SliverSectionsWidgetController extends GetxController {
  /// 用以更新数据用(在updateWidget中调用后会触发Obx的更新操作)
  final RxInt _reloadData = 0.obs;

  /// SliverSection相关对象的数组
  List<BaseSliverSection> sliverSections = [];

  /// 更新控件(更新数据源后调用此方法才可以更新数据)
  void updateWidget() => _reloadData.value++;

  @override
  void update([List<Object>? ids, bool condition = true]) {
    _reloadData.value++;
    super.update(ids, condition);
  }
}

class SliverSectionsWidget<ST extends BaseScrollStyleConfig> extends StatelessWidget {
  /// 逻辑控制器
  final SliverSectionsWidgetController controller;

  /// scrollController
  final ScrollController? scrollController;

  /// 是否使用紧缩模式,默认为false
  final bool shrinkWrap;

  /// 缓存的距离
  final double? cacheExtent;

  /// 边缘裁剪方式,默认为Clip.hardEdge
  final Clip clipBehavior;

  /// 滑动方向,默认为垂直方向
  final Axis scrollDirection;

  /// 滑动的行为
  final ScrollBehavior? scrollBehavior;

  /// 滑动的模式
  final ScrollPhysics? physics;

  /// 键盘消失行为
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// 滑动风格配置
  final ST? scrollStyleConfig;

  const SliverSectionsWidget({
    Key? key,
    required this.controller,
    this.scrollController,
    this.shrinkWrap = false,
    this.cacheExtent,
    this.clipBehavior = Clip.hardEdge,
    this.scrollDirection = Axis.vertical,
    this.scrollBehavior,
    this.physics,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.scrollStyleConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 直接设置ScrollController会导致CustomScrollView内容过少时无法滑动
    // https://stackoverflow.com/questions/65369458/customscrollview-scroll-behavior-changes-when-scrollcontroller-is-passed
    return Obx(() {
      if (controller._reloadData.value > 0) {}

      var scrollView = CustomScrollView(
        controller: scrollController,
        shrinkWrap: shrinkWrap,
        cacheExtent: cacheExtent,
        clipBehavior: clipBehavior,
        scrollDirection: scrollDirection,
        scrollBehavior: scrollBehavior,
        physics: physics,
        keyboardDismissBehavior: keyboardDismissBehavior,
        slivers: controller.sliverSections.buildAllSliverSectionsWidget(),
      );

      if (scrollStyleConfig != null) {
        scrollStyleConfig!.controller = scrollController;
        return scrollStyleConfig!.widgetAccess(child: scrollView);
      } else {
        return scrollView;
      }
    });
  }
}
