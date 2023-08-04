import 'package:flutter/material.dart';
import 'package:project_examples/pages/tab_bar/tab_bar_page.dart';
import 'package:project_examples/pages/unknown/unknown_page.dart';
import 'package:project_examples/route/getx_route_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/widgets/launch_image_widget.dart';

void main() async {
  /// 确保所有的插件都初始化好了
  WidgetsFlutterBinding.ensureInitialized();
  await SpVal.initialized();
  pageRouteEnumPrepare();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 设定当前路由风格
    appCurrentRouteStyle = AppRouteStyle.namedRouteType;

    // 设计用的尺寸
    const designSize = Size(375, 667);

    // 根据路由风格的不同初始化方式也不一样
    switch (appCurrentRouteStyle) {
      case AppRouteStyle.getxType:
        return ScreenUtilInit(
          designSize: designSize,
          builder: (context, wgt) => GetMaterialApp(
            theme: ThemeData.light(),
            debugShowCheckedModeBanner: false,
            builder: (context, widget) => _widgetMain(context, widget),
            getPages: RouteConfig.getPages(),
            unknownRoute: GetPage(name: '/notFound', page: () => const UnknownPage()),
            initialRoute: '/',
            routingCallback: (routing) {
              appPrint("上一个界面: ${routing?.previous ?? "空"} 当前界面: ${routing?.current ?? "空"}", level: PrintLevel.verbose);
            },
          ),
        );

      case AppRouteStyle.namedRouteType:
        return ScreenUtilInit(
          designSize: designSize,
          builder: (context, wgt) => GetMaterialApp(
            theme: ThemeData.light(),
            debugShowCheckedModeBanner: false,
            builder: (context, widget) => _widgetMain(context, widget),
            unknownRoute: GetPage(name: '/notFound', page: () => const UnknownPage()),
            routes: {'/': (_) => const TabBarPage()},
            routingCallback: (routing) {
              appPrint("上一个界面: ${routing?.previous ?? "空"} 当前界面: ${routing?.current ?? "空"}", level: PrintLevel.verbose);
            },
            onGenerateRoute: (settings) {
              // 通过拦截有名路由的方式进行页面跳转
              PageRouteEnum? routePage = pageRouteEnumFromName(settings.name ?? '');
              if (routePage != null) return routePage.getMaterialPageRouteFromSetting(settings);
              return null;
            },
          ),
        );
    }
  }

  Widget _widgetMain(BuildContext context, Widget? widget) {
    return MediaQuery(
      // 设置文字大小不随系统设置改变
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Stack(children: [
        // 主Widget
        widget!,

        // 启动页
        const LaunchImageWidget(),
      ]),
    );
  }
}
