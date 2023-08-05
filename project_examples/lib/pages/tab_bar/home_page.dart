import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/base/widget_callback_mixin.dart';
import 'package:project_examples/file_headers.dart';

class HomePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const HomePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => HomePageState();
}

class HomePageState extends NormalStatefulWidgetState<HomePage> with WidgetEventCallbackMixin {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget backgroundWidget(BuildContext context) => Container(color: Colors.white);

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverListSection.builderTypeWidget(
            items: [
              MenuItemModel(title: '第三方库'.tr, pageRouteEnum: PageRouteEnum.thirdLibPage),
              MenuItemModel(title: '项目用库'.tr, pageRouteEnum: PageRouteEnum.projectUsePage),
              MenuItemModel(title: '动画'.tr, pageRouteEnum: PageRouteEnum.animationListPage),
              MenuItemModel(title: '异步编程'.tr, pageRouteEnum: PageRouteEnum.asyncKnowledgePage),
              MenuItemModel(title: '语言设置'.tr, pageRouteEnum: PageRouteEnum.languagePage),
            ],
            builder: (c, i, d) => MenuItemWidget(model: d, callback: widgetEventCallback),
          ),
        ],
      ),
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
