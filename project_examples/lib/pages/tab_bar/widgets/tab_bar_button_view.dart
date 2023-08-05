import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/tools/util.dart';
import 'package:project_examples/pages/tab_bar/widgets/tar_bar_button.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class TabBarButtonViewController extends GetxController {
  final RxInt selectIndex = 0.obs;
}

class TabBarButtonView extends StatelessWidget {
  final TabBarButtonViewController _controller = TabBarButtonViewController();
  final bool Function(TabBarButton) canTap;
  final Function(TabBarButton) didTap;

  TabBarButtonView({
    Key? key,
    required this.canTap,
    required this.didTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // 标题
      List<String> titles = ['tab_首页'.tr, 'tab_类目'.tr, 'tab_购物车'.tr, 'tab_账户'.tr];
      List<IconData> iconDatas = [Icons.home, Icons.category, Icons.add_shopping_cart, Icons.account_circle_rounded];

      // 按钮控件
      List<Expanded> buttons = [];
      for (int i = 0; i < titles.length; i++) {
        buttons.add(
          Expanded(
            flex: 1,
            child: TabBarButton(
              title: titles[i],
              iconData: iconDatas[i],
              badgeCount: i == 0 ? Util.randomInt(max: 200, min: 1) : 0,
              onTap: tabBarButtonTapEvent,
              select: _controller.selectIndex.value == i ? true : false,
              index: i,
            ),
          ),
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons,
      );
    });
  }

  void tabBarButtonTapEvent(TabBarButton button) {
    if (canTap(button) == true) {
      _controller.selectIndex.value = button.index;
      didTap(button);
    }
  }
}
