import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/base/widget_callback_mixin.dart';
import 'package:project_examples/file_headers.dart';

class ProjectUsePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ProjectUsePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ProjectUsePageState();
}

class ProjectUsePageState extends NormalStatefulWidgetState<ProjectUsePage> with WidgetEventCallbackMixin {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget backgroundWidget(BuildContext context) => Container(color: Colors.white);

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverListSection(
          padding: const EdgeInsets.only(bottom: 49),
          items: [
            MenuItemModel(title: 'SliverSections的使用'.tr, pageRouteEnum: PageRouteEnum.sliverSectionsPage),
            const MenuItemModel(title: 'SliverRefreshWidget', pageRouteEnum: PageRouteEnum.sliverRefreshWidgetPage),
            const MenuItemModel(title: 'SliverSectionsRefreshWidget', pageRouteEnum: PageRouteEnum.sliverSectionsRefreshWidgetPage),
            const MenuItemModel(title: 'InformationView', pageRouteEnum: PageRouteEnum.informationViewPage),
            const MenuItemModel(title: 'ToastWidget', pageRouteEnum: PageRouteEnum.toastWidgetPage),
            const MenuItemModel(title: 'LayoutMaskWidget', pageRouteEnum: PageRouteEnum.layoutMaskWidgetPage),
            const MenuItemModel(title: 'TextField', pageRouteEnum: PageRouteEnum.textFieldPage),
            const MenuItemModel(title: 'CustomTabBarWidget', pageRouteEnum: PageRouteEnum.customTabBarWidgetPage),
            const MenuItemModel(title: 'AnimatedSwitcherWidget', pageRouteEnum: PageRouteEnum.animatedSwitcherWidgetPage),
            const MenuItemModel(title: 'GetChildSize', pageRouteEnum: PageRouteEnum.getChildSizePage),
            MenuItemModel(title: '自定义按钮'.tr, pageRouteEnum: PageRouteEnum.customButtonsPage),
            MenuItemModel(title: '首次加载组件v1'.tr, pageRouteEnum: PageRouteEnum.firstTimeLoadingWidgetPage),
            MenuItemModel(title: '首次加载组件v2'.tr, pageRouteEnum: PageRouteEnum.futureLoadingWidgetPage),
            const MenuItemModel(title: 'Networks', pageRouteEnum: PageRouteEnum.networksPage),
            const MenuItemModel(title: 'SpVal', pageRouteEnum: PageRouteEnum.spValPage),
            const MenuItemModel(title: 'RegExp', pageRouteEnum: PageRouteEnum.regExpPage),
            const MenuItemModel(title: 'checkWillPop', pageRouteEnum: PageRouteEnum.maybePopPage),
            MenuItemModel(title: '文件扫描'.tr, pageRouteEnum: PageRouteEnum.filesScanPage, setRouteStyle: AppRouteStyle.namedRouteType),
            MenuItemModel(title: '抽奖'.tr, pageRouteEnum: PageRouteEnum.lotteryCarouselWidgetPage),
            MenuItemModel(title: '纸屑效果'.tr, pageRouteEnum: PageRouteEnum.confettiPage),
            MenuItemModel(title: '视差效果'.tr, pageRouteEnum: PageRouteEnum.scrollingParallaxEffectPage),
          ],
          builder: (c, i, d) => MenuItemWidget(model: d, callback: widgetEventCallback),
        ).buildWidget(),
      ],
    );
  }

  @override
  void widgetEventCallback(BuildContext? context, WidgetEventItem eventItem) {
    if (eventItem.data is MenuItemModel) {
      MenuItemModel item = eventItem.data;
      switch (appCurrentRouteStyle) {
        case AppRouteStyle.getxType:
          Get.toNamed(item.pageRouteEnum.routeName, arguments: eventItem.data);
          break;
        case AppRouteStyle.namedRouteType:
          appRouteTo(
            this.context,
            NormalPageInfo(
              pageRoute: item.pageRouteEnum,
              arguments: PageArguments(params: {'title': eventItem.data.title}),
            ),
          );
          break;
      }
    }
  }
}
