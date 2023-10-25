import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class AnimatedSwitcherWidgetPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const AnimatedSwitcherWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AnimatedSwitcherWidgetPageState();
}

enum WidgetStatus { idle, startLoading, success, error }

class AnimatedSwitcherWidgetPageState extends NormalStatefulWidgetState<AnimatedSwitcherWidgetPage> {
  final List<WidgetStatus> _statusList = [WidgetStatus.idle, WidgetStatus.startLoading, WidgetStatus.success, WidgetStatus.error];
  int _start = 0;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    List<ValueKey> valueKeyList = [];
    for (var element in _statusList) {
      valueKeyList.add(ValueKey(element));
    }
    int index = _start++ % _statusList.length;

    return AnimatedSwitcherWidget(
      valueKey: valueKeyList[index],
      data: _statusList[index],
      builder: (c, d) {
        late Widget child;
        switch ((d as WidgetStatus)) {
          case WidgetStatus.idle:
            child = WidgetsFactory.text(d.toString());
            break;
          case WidgetStatus.startLoading:
            child = IndicatorWidget(
              config: WateryDesertIndicatorConfig(
                indicatorType: WateryDesertIndicatorType.newtonCradle,
                size: 80,
                color: Colors.blueAccent,
              ),
            );
            break;
          case WidgetStatus.success:
            child = WidgetsFactory.text(d.toString());
            break;
          case WidgetStatus.error:
            child = OpacityButtonWidget(
              onTap: () => setState(() {}),
              child: WidgetsFactory.text('点击重试'.tr, color: Colors.white, fontSize: 24).addContainerBorderRadius(
                radius: 6,
                color: Colors.indigoAccent,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            );
            break;
        }

        return Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: child,
        ).addTapEvent(() => setState(() {}), includeContainer: true);
      },
    );
  }
}
