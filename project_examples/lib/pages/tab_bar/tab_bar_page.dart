import 'package:flutter/material.dart';
import 'package:project_examples/pages/root/account/account_page.dart';
import 'package:project_examples/pages/root/cart/cart_page.dart';
import 'package:project_examples/pages/root/category/category_page.dart';
import 'package:project_examples/pages/root/home/home_page.dart';
import 'package:project_examples/pages/tab_bar/widgets/tab_bar_button_view.dart';
import 'package:project_examples/pages/tab_bar/widgets/tar_bar_button.dart';
import 'package:project_base_libs_pkg/base/managers/page_view_manager.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TabBarPageState();
}

class TabBarPageState extends State<TabBarPage> {
  Key key = UniqueKey();
  final PageViewManager pageViewManager = PageViewManager();
  final List pages = [const HomePage(), const CategoryPage(), const CartPage(), const AccountPage()];

  void resetPages() {
    key = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                /// 页面
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: pageViewManager.buildPageView(itemBuilder: (context, index) => pages[index], itemCount: pages.length),
                  ),
                ),

                /// 线条
                Container(height: 0.5, color: Colors.grey.withOpacity(0.5)),

                /// 底部按钮
                Container(
                  color: Colors.white,
                  child: SafeArea(top: false, child: SizedBox(height: 49, child: TabBarButtonView(canTap: canTap, didTap: didTap))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool canTap(TabBarButton button) {
    return true;
  }

  void didTap(TabBarButton button) {
    pageViewManager.makeSelectIndex(button.index);
  }
}
