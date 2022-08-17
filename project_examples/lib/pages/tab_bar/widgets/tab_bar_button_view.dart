import 'package:flutter/material.dart';
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
      List<String> titles = ['Home', 'Category', 'Cart', 'Account'];

      // 按钮控件
      List<Expanded> buttons = [];
      for (int i = 0; i < titles.length; i++) {
        buttons.add(
          Expanded(
            flex: 1,
            child: TabBarButton(
              onTap: tabBarButtonTapEvent,
              select: _controller.selectIndex.value == i ? true : false,
              index: i,
              title: titles[i],
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
