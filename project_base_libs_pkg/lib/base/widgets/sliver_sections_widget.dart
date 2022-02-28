import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base_file_headers.dart';

class SliverSectionsWidgetController extends GetxController {
  /// 用以更新数据用(在updateWidget中调用后会触发Obx的更新操作)
  final RxInt _reloadData = 0.obs;

  /// SliverSection相关对象的数组
  List<SliverSection> sliverSections = [];

  /// ScrollController对象
  final ScrollController scrollController = ScrollController();

  /// 更新控件
  void updateWidget() => _reloadData.value++;

  @override
  void update([List<Object>? ids, bool condition = true]) {
    _reloadData.value++;
    super.update(ids, condition);
  }
}

class SliverSectionsWidget extends StatelessWidget {
  final SliverSectionsWidgetController controller;
  const SliverSectionsWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller._reloadData.value > 0) {}
      return CustomScrollView(
        controller: controller.scrollController,
        slivers: controller.sliverSections.buildAllSliverSectionsWidget(),
      );
    });
  }
}
