import 'package:project_examples/file_headers.dart';
import 'package:readmore/readmore.dart';

class ReadMorePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ReadMorePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ReadMorePageState();
}

class ReadMorePageState extends NormalStatefulWidgetState<ReadMorePage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: ReadMoreText(
            'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
            trimLines: 2,
            style: TextStyle(color: Colors.black, height: 1.5),
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...Show more',
            trimExpandedText: ' show less',
          ),
        ),
        const Divider(color: Colors.grey),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ReadMoreText(
            'readMoreTip'.tr,
            trimLines: 3,
            style: const TextStyle(color: Colors.black, height: 1.5),
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: '展开'.tr,
            trimExpandedText: '收起'.tr,
          ),
        ),
      ],
    );
  }
}
