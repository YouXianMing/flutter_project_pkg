import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/card_item_widget.dart';

enum AppRouteStyle {
  /// GetX风格
  getxType,

  /// 有名路由风格
  namedRouteType,
}

late AppRouteStyle appCurrentRouteStyle;

/// 根据路由的不同,获取的标题方式也不同
String appGetTitle({PageArguments? arguments}) {
  late String title;
  switch (appCurrentRouteStyle) {
    case AppRouteStyle.getxType:
      title = (Get.arguments as CartItemModel).title;
      break;
    case AppRouteStyle.namedRouteType:
      title = getT(arguments?.params?['title'], defaultValue: '');
      break;
  }
  return title;
}
