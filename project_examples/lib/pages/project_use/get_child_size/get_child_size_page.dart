import 'package:project_examples/file_headers.dart';

class GetChildSizePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const GetChildSizePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => GetChildSizePageState();
}

class GetChildSizePageState extends NormalStatefulWidgetState<GetChildSizePage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return const SizedBox();
  }
}
