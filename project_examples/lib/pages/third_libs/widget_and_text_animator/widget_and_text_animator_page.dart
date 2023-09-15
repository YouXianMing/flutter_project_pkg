import 'package:project_examples/file_headers.dart';
import 'package:project_examples/pages/third_libs/widget_and_text_animator/widgets/widget_and_text_animator_samples.dart';

class WidgetAndTextAnimatorPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const WidgetAndTextAnimatorPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => WidgetAndTextAnimatorPageState();
}

class WidgetAndTextAnimatorPageState extends NormalStatefulWidgetState<WidgetAndTextAnimatorPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return const Samples();
  }
}
