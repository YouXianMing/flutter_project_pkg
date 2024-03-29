import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/base/widget_callback_mixin.dart';
import 'package:project_examples/file_headers.dart';

class AsyncKnowledgePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const AsyncKnowledgePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AsyncKnowledgePageState();
}

class AsyncKnowledgePageState extends NormalStatefulWidgetState<AsyncKnowledgePage> with WidgetEventCallbackMixin {
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
            MenuItemModel(title: 'async 与 await'.tr, pageRouteEnum: PageRouteEnum.asyncAwaitExamplePage),
            MenuItemModel(title: 'Dart的事件循环'.tr, pageRouteEnum: PageRouteEnum.dartAsyncPage),
            const MenuItemModel(title: 'Future', pageRouteEnum: PageRouteEnum.dartFuturePage),
            const MenuItemModel(title: 'Stream', pageRouteEnum: PageRouteEnum.dartStreamPage),
            const MenuItemModel(title: 'FutureBuilder', pageRouteEnum: PageRouteEnum.futureBuilderPage),
            const MenuItemModel(title: 'StreamBuilder', pageRouteEnum: PageRouteEnum.streamBuilderPage),
            const MenuItemModel(title: 'Completer', pageRouteEnum: PageRouteEnum.completerPage),
            const MenuItemModel(title: 'Isolate', pageRouteEnum: PageRouteEnum.isolatePage),
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
