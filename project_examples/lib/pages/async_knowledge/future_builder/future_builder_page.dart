import 'package:project_examples/file_headers.dart';

class FutureBuilderPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const FutureBuilderPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => FutureBuilderPageState();
}

class FutureBuilderPageState extends NormalStatefulWidgetState<FutureBuilderPage> {
  final RxBool _start = false.obs;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Obx(() => FutureBuilder(
          future: _start.value == true ? Future<String>.delayed(const Duration(seconds: 3), () => '结束'.tr) : null,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return GestureDetector(
                  onTap: () {
                    _start.value = true;
                    innerLoading.show();
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    color: Colors.black,
                    child: Text('开始'.tr, style: const TextStyle(color: Colors.white)),
                  ),
                );

              case ConnectionState.waiting:
                return Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  color: Colors.green,
                  child: Text('运行中'.tr, style: const TextStyle(color: Colors.white)),
                );

              case ConnectionState.done:
                innerLoading.hide(afterDelay: const Duration(milliseconds: 20));
                return Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  color: Colors.red,
                  child: Text(snapshot.data, style: const TextStyle(color: Colors.white)),
                );

              default:
                return const SizedBox();
            }
          },
        ));
  }
}
