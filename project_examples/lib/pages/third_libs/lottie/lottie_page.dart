import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';

class LottiePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const LottiePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => LottiePageState();
}

class LottiePageState extends NormalStatefulWidgetState<LottiePage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    // 资源文件地址
    // https://github.com/xvrh/lottie-flutter/tree/master/example/assets

    return CustomScrollView(
      slivers: [
        // Lottie.network方式
        SliverGridSection(
          crossAxisCount: 4,
          items: ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'],
          builder: (c, i, d) => Lottie.network('https://rawgit.flutter-io.cn/xvrh/lottie-flutter/master/example/assets/Mobilo/$d.json'),
        ).buildWidget(),

        // Lottie.asset方式
        SliverGridSection(
          crossAxisCount: 2,
          items: ['assets/LottieLogo1.json', 'assets/LottieLogo2.json', 'assets/animated_graph.json', 'assets/LogoSmall.json'],
          builder: (c, i, d) => Lottie.asset(d),
        ).buildWidget(),
      ],
    );
  }
}
