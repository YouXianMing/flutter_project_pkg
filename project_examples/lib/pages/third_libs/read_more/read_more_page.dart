import 'package:readmore/readmore.dart';
import 'package:project_examples/file_headers.dart';

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
      children: const [
        Padding(
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
        Divider(color: Colors.grey),
        Padding(
          padding: EdgeInsets.all(10),
          child: ReadMoreText(
            '拜登政府5月曾下令让美国情报部门在90天内提交一份新冠病毒源头调查报告。所以，美国情报部门，3个月内你们真的能完成吗？美国一些政客试图用政治手段来回答这样一个科学问题，那么问题来了，如果用“政治编造”+“谎言污蔑”造出这样一份溯源调查报告，会有人相信吗？美国情报部门，请回答！(记者 冰洁 摄像 王潮 制作 周璟 技术 杨思雨 孙红卫）',
            trimLines: 3,
            style: TextStyle(color: Colors.black, height: 1.5),
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: '展开',
            trimExpandedText: '收起',
          ),
        ),
      ],
    );
  }
}
