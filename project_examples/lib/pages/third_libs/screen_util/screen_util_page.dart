import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_examples/file_headers.dart';

class ScreenUtilPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ScreenUtilPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ScreenInfoPageState();
}

class ScreenInfoPageState extends NormalStatefulWidgetState<ScreenUtilPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
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
          return Padding(padding: EdgeInsets.all(5.sp), child: Text(d));
        },
      ),
    );
  }
}
