import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/card_item_widget.dart';

enum RouteStyle {
  /// GetX风格
  getxStyle,

  /// 枚举值风格
  enumStyle,
}

RouteStyle appCurrentRouteStyle = RouteStyle.enumStyle;

String appGetTitle({PageArguments? arguments}) {
  late String title;
  switch (appCurrentRouteStyle) {
    case RouteStyle.getxStyle:
      title = (Get.arguments as CartItemModel).title;
      break;
    case RouteStyle.enumStyle:
      title = getT(arguments?.params?['title'], defaultValue: '');
      break;
  }
  return title;
}
