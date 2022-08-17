import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemModel {
  final String title;
  final String? route;

  CartItemModel({
    required this.title,
    this.route,
  });
}

class CartItemWidget extends StatelessWidget {
  final CartItemModel? model;
  final WidgetEventCallback? callback;

  const CartItemWidget({
    Key? key,
    this.model,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback!(context, WidgetEventItem(widget: this, data: model));
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.w, bottom: 30.w),
        color: Colors.white,
        child: Text(model?.title ?? ''),
      ).addDefaultTextStyle(),
    );
  }
}
