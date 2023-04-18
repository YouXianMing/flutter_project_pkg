import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/base/widget_callback_mixin.dart';
import 'package:project_examples/route/page_route_enum.dart';

class MenuItemModel {
  /// 标题
  final String title;

  /// 路由枚举值
  final PageRouteEnum pageRouteEnum;

  /// 指定路由方式
  final AppRouteStyle? setRouteStyle;

  const MenuItemModel({required this.title, required this.pageRouteEnum, this.setRouteStyle});
}

class MenuItemWidget extends StatelessWidget {
  final MenuItemModel model;
  final WidgetEventCallback callback;

  const MenuItemWidget({Key? key, required this.model, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.setRouteStyle == null || appCurrentRouteStyle == model.setRouteStyle) return _widget(context);
    return const SizedBox();
  }

  Widget _widget(BuildContext context) => OpacityButtonWidget(
        onTap: () => callback(context, WidgetEventItem(widget: this, data: model)),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.w, bottom: 30.w),
          color: Colors.white,
          child: Text(model.title),
        ),
      );
}
