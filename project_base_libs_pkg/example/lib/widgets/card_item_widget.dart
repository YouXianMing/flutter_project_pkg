import 'package:example/page_route/page_route_enum.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class CartItemModel {
  final String title;
  final String? subTitle;
  final PageRouteEnum routeEnum;

  CartItemModel({
    required this.title,
    required this.routeEnum,
    this.subTitle,
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
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        color: Colors.white,
        child: childWidget(),
      ).addDefaultTextStyle(),
    );
  }

  Widget childWidget() {
    if (checkStringIsEmpty(model?.subTitle)) {
      return Text(model?.title ?? '');
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model?.title ?? ''),
          const Padding(padding: EdgeInsets.only(top: 5)),
          WidgetsFactory.text(getT<String>(model?.subTitle, defaultValue: ''), color: Colors.grey),
        ],
      );
    }
  }
}
