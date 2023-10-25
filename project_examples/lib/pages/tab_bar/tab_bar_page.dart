import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/managers/page_view_manager.dart';
import 'package:project_examples/pages/tab_bar/account_page.dart';
import 'package:project_examples/pages/tab_bar/cart_page.dart';
import 'package:project_examples/pages/tab_bar/category_page.dart';
import 'package:project_examples/pages/tab_bar/home_page.dart';
import 'package:project_examples/pages/tab_bar/widgets/tab_bar_button_view.dart';
import 'package:project_examples/pages/tab_bar/widgets/tar_bar_button.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TabBarPageState();
}

class TabBarPageState extends State<TabBarPage> {
  Key _key = UniqueKey();
  final PageViewManager _pageViewManager = PageViewManager();
  final List _pages = [const HomePage(), const CategoryPage(), const CartPage(), const AccountPage()];

  void resetPages() {
    _key = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
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
                    child: _pageViewManager.buildPageView(itemBuilder: (context, index) => _pages[index], itemCount: _pages.length),
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
    _pageViewManager.makeSelectIndex(button.index);
  }
}
