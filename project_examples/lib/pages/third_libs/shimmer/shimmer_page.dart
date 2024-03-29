import 'package:shimmer/shimmer.dart';
import 'package:project_examples/file_headers.dart';

class ShimmerPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ShimmerPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ShimmerPageState();
}

class ShimmerPageState extends NormalStatefulWidgetState<ShimmerPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.withOpacity(0.3),
        period: const Duration(milliseconds: 1500),
        child: const Padding(
            padding: EdgeInsets.all(40), child: Text('Shimmer', style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w300))),
      ),
    );
  }
}
