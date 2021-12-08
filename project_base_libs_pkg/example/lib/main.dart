import 'package:example/page_route/page_route_enum.dart';
import 'package:example/pages/tab_bar/tab_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => widget!,
      unknownRoute: GetPage(name: '/notFound', page: () => const UnknownPage()),
      routes: {'/': (_) => const TabBarPage()},
      onGenerateRoute: (settings) {
        PageRouteEnum? routePage = pageRouteEnumFromName(settings.name ?? '');
        if (routePage != null) return routePage.getMaterialPageRouteFromSetting(settings);
        return null;
      },
      routingCallback: (routing) {
        appPrintWarning("上一个界面: ${routing?.previous ?? "空"} 当前界面: ${routing?.current ?? "空"}");
      },
    );
  }
}

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UnknownPage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('404')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back_sharp),
      ),
    );
  }
}
