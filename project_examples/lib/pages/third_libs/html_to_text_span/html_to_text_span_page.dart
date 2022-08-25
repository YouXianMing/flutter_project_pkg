import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HtmlToTextSpanPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const HtmlToTextSpanPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => HtmlToTextSpanPageState();
}

class HtmlToTextSpanPageState extends NormalStatefulWidgetState<HtmlToTextSpanPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    String text = '''
        <body>
    <h1 style='color: white; font-size:50px; font-style:italic; 
    background-color: rgb(0,122,255); font-weight:100;)'> Hello word! </h1>
    <h1 style=''>Convert your <span style='color:lightseagreen;'>
    HTML</span> and <span style='color:dodgerblue'>CSS</span> 
    easily into RichText</h1>
    <p>Lorem ipsum dolor sit, consectetur adipiscing elit. Pellentesque in leo 
    id dui bibendum fringilla in et arcu. In vehicula vel est sed mattis.</p>
    <p><a href="https://google.com">Need more? click this link</a></p>
    <p>We all spell <span style='color:crimson; 
    text-decoration: underline wavy;'>recieve</span> wrong.<br />Some times we 
    delete <del>stuff</del></p>
    <div style='font-size:17px'>We write things that are 
    <span style='font-size:1.5em;'>Big,</span> <b>bold</b>&nbsp; or 
    <span style='color:brown'>colorful</span></div>
    <p style='font-family:times;'>Some different FONT with 
    <span style='background-color:lightcyan;'>this part highlighted</span></p>
    <div style='line-height:2; font-size:17px;'><b style='color: rgb(0,122,255); 
    font-weight:500;'>Finally some line heights.</b> Lorem ipsum dolor sit amet, 
    consectetur adipiscing elit. Pellentesque in leo id dui bibendum fringilla 
    in et arcu. In vehicula vel est sed mattis. Duis varius, sem non mattis.</div>
</body>
        ''';

    return CustomScrollView(
      slivers: [
        SliverBoxAdapterSection(
            builder: (d) => RichText(
                  text: HTML.toTextSpan(
                    context,
                    text,
                    defaultTextStyle: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.normal, decoration: TextDecoration.none),
                    linksCallback: (d) => appPrint(d),
                  ),
                )).buildWidget(),
      ],
    );
  }
}
