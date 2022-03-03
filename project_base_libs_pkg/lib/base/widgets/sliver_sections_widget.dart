import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base_file_headers.dart';

class SliverSectionsWidgetController extends GetxController {
  /// 用以更新数据用(在updateWidget中调用后会触发Obx的更新操作)
  final RxInt _reloadData = 0.obs;

  /// SliverSection相关对象的数组
  List<SliverSection> sliverSections = [];

  /// 更新控件(更新数据源后调用此方法才可以更新数据)
  void updateWidget() => _reloadData.value++;

  @override
  void update([List<Object>? ids, bool condition = true]) {
    _reloadData.value++;
    super.update(ids, condition);
  }
}

class SliverSectionsWidget extends StatelessWidget {
  /// 逻辑控制器
  final SliverSectionsWidgetController controller;

  /// scrollController
  final ScrollController? scrollController;

  const SliverSectionsWidget({Key? key, required this.controller, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller._reloadData.value > 0) {}
      return CustomScrollView(
        controller: scrollController,
        slivers: controller.sliverSections.buildAllSliverSectionsWidget(),
      );
    });
  }
}
