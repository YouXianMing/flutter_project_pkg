import 'package:example/page_route/page_arguments.dart';
import 'package:example/page_route/page_route_enum.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/card_item_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class HomePage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const HomePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => HomePageState();
}

class HomePageState extends NormalStatefulWidgetState<HomePage> with WidgetEventCallbackMixin {
  @override
  void widgetEventCallback(BuildContext? context, WidgetEventItem eventItem) {
    CartItemModel model = eventItem.data;
    model.routeEnum.push(context!, arguments: PageArguments(mark: model.title));
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => AppBar(title: const Text('Example'));

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverListSection.staticTypeWidget(children: [
          CartItemWidget(
            model: CartItemModel(title: 'CustomTabBarWidget', routeEnum: PageRouteEnum.tabBar),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'InformationView', routeEnum: PageRouteEnum.informationView),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'SliverRefreshWidget', routeEnum: PageRouteEnum.sliverRefreshWidget),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'SliverSection', routeEnum: PageRouteEnum.sliverSections),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'StatusWidget', routeEnum: PageRouteEnum.statusWidget),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'ToastWidget', routeEnum: PageRouteEnum.toastWidget),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'ReadMoreTextWidget', routeEnum: PageRouteEnum.readMoreTextWidget),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'LayoutMaskWidget', routeEnum: PageRouteEnum.layoutMask),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'TextField', routeEnum: PageRouteEnum.textField),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'IndicatorWidget', subTitle: '第三方indicator的封装', routeEnum: PageRouteEnum.indicatorWidget),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: '网络请求', routeEnum: PageRouteEnum.networks),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'SpVal', routeEnum: PageRouteEnum.spVal),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'checkWillPop', subTitle: '请用web模拟安卓物理返回键', routeEnum: PageRouteEnum.maybePop),
            callback: widgetEventCallback,
          ),
          kIsWeb
              ? const SizedBox()
              : CartItemWidget(
                  model: CartItemModel(title: 'fileScan', routeEnum: PageRouteEnum.fileScan),
                  callback: widgetEventCallback,
                ),
          CartItemWidget(
            model: CartItemModel(title: 'Regex', routeEnum: PageRouteEnum.regExp),
            callback: widgetEventCallback,
          ),
          CartItemWidget(
            model: CartItemModel(title: 'GetxRefresh', routeEnum: PageRouteEnum.getxRefresh),
            callback: widgetEventCallback,
          ),
        ]),
      ],
    );
  }
}
