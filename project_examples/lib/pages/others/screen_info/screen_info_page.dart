import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/pages/base/normal_stateful_widget.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenInfoPage extends NormalStatefulWidget {
  const ScreenInfoPage({Key? key}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ScreenInfoPageState();
}

class ScreenInfoPageState extends NormalStatefulWidgetState<ScreenInfoPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
      );

  @override
  Widget body(BuildContext context) {
    return WidgetsFactory.listViewBuilder(
      build: ListViewBuilderConfig(
        items: [
          'Device width dp:${1.sw}dp',
          'Device height dp:${1.sh}dp',
          'Device pixel density:${ScreenUtil().pixelRatio}',
          'Bottom safe zone distance dp:${ScreenUtil().bottomBarHeight}dp',
          'Status bar height dp:${ScreenUtil().statusBarHeight}dp',
          'The ratio of actual width to UI design:${ScreenUtil().scaleWidth}',
          'The ratio of actual height to UI design:${ScreenUtil().scaleHeight}',
          'System font scaling:${ScreenUtil().textScaleFactor}',
          '0.5 times the screen width:${0.5.sw}dp',
          '0.5 times the screen height:${0.5.sh}dp',
          'Screen orientation:${ScreenUtil().orientation}',
        ],
        builder: (c, i, d) {
          return Padding(padding: EdgeInsets.all(10.sp), child: Text(d));
        },
      ),
    );
  }
}
