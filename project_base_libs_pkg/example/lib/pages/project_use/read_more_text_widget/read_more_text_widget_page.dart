import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class ReadMoreTextWidgetPage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const ReadMoreTextWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _ReadMoreTextWidgetPageState();
}

class _ReadMoreTextWidgetPageState extends NormalStatefulWidgetState<ReadMoreTextWidgetPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) =>
      NormalAppBar(context: context, title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''));

  @override
  Widget body(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(10),
          child: ReadMoreTextWidget(
            'The project we’ll look at is split into two parts. The first part contains three identical newsfeed applications for three separate native platforms: Android, iOS, and the web. The app is interactive, so you can run it on a device and scroll through the articles, click on the news items, and more. The second part of this project is a dialog that pops up when interacting with the app and asks users to submit feedback. This feature, which we’ll call the NPS (Net Promoter Score) module, is built with Flutter.',
            style: TextStyle(color: Colors.black, fontSize: 18),
            trimMode: TrimMode.line,
            trimLines: 4,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: ReadMoreTextWidget(
            'The project we’ll look at is split into two parts. The first part contains three identical newsfeed applications for three separate native platforms: Android, iOS, and the web. The app is interactive, so you can run it on a device and scroll through the articles, click on the news items, and more. The second part of this project is a dialog that pops up when interacting with the app and asks users to submit feedback. This feature, which we’ll call the NPS (Net Promoter Score) module, is built with Flutter.',
            style: TextStyle(color: Colors.black, fontSize: 18),
            trimMode: TrimMode.length,
            trimLength: 270,
            trimExpandedText: 'Collapsed',
            trimCollapsedText: 'More >',
            moreStyle: TextStyle(color: Colors.blue, fontSize: 18, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
            lessStyle: TextStyle(color: Colors.red, fontSize: 18, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
