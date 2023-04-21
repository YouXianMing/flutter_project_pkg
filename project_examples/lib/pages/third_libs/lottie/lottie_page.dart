import 'package:lottie/lottie.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

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
          items: [
            'lib/assets/LottieLogo1.json',
            'lib/assets/LottieLogo2.json',
            'lib/assets/animated_graph.json',
            'lib/assets/LogoSmall.json'
          ],
          builder: (c, i, d) => Lottie.asset(d),
        ).buildWidget(),
      ],
    );
  }
}
