import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class GetChildSizePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const GetChildSizePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => GetChildSizePageState();
}

class GetChildSizePageState extends NormalStatefulWidgetState<GetChildSizePage> {
  final _sizeStr = ''.obs;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        OpacityButtonWidget(
          onTap: () => setState(() {}),
          child: WidgetsFactory.text('点击更新'.tr, color: Colors.white).addContainerBorderRadius(
            radius: 6,
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          ),
        ).addPaddingOnly(bottom: 20, top: 20),
        Center(
          child: GetChildSize(
            onChange: (Size size) => _sizeStr.value = '${size.width.toInt()} x ${size.height.toInt()}',
            child: Stack(
              children: [
                SizedBox(
                  width: Util.randomDouble(min: 100, max: 200),
                  height: Util.randomDouble(min: 100, max: 200),
                ).addDebugContainer(),
                Positioned(child: Obx(() => WidgetsFactory.text(_sizeStr.value).addContainerBorderRadius(color: Colors.white))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
