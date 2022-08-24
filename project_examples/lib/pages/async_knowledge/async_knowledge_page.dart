import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

class AsyncKnowledgePage extends NormalStatefulWidget {
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
          items: [
            const CartItemModel(title: 'async 与 await', pageRouteEnum: PageRouteEnum.asyncAwaitExamplePage),
            const CartItemModel(title: 'Dart的事件循环', pageRouteEnum: PageRouteEnum.dartAsyncPage),
            const CartItemModel(title: 'Future', pageRouteEnum: PageRouteEnum.dartFuturePage),
            const CartItemModel(title: 'Stream', pageRouteEnum: PageRouteEnum.dartStreamPage),
            const CartItemModel(title: 'FutureBuilder', pageRouteEnum: PageRouteEnum.futureBuilderPage),
            const CartItemModel(title: 'StreamBuilder', pageRouteEnum: PageRouteEnum.streamBuilderPage),
            const CartItemModel(title: 'Completer', pageRouteEnum: PageRouteEnum.completerPage),
            const CartItemModel(title: 'Isolate', pageRouteEnum: PageRouteEnum.isolatePage),
          ],
          builder: (c, i, d) => CartItemWidget(model: d, callback: widgetEventCallback),
        ).buildWidget(),
      ],
    );
  }

  @override
  void widgetEventCallback(BuildContext? context, WidgetEventItem eventItem) {
    if (eventItem.data is CartItemModel) {
      CartItemModel item = eventItem.data;
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
