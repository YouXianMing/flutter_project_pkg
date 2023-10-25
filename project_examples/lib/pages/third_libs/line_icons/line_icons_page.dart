import 'package:line_icons/line_icons.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class LineIconsPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const LineIconsPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => LineIconsPageState();
}

class LineIconsPageState extends NormalStatefulWidgetState<LineIconsPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    // https://icons8.com/line-awesome
    // Icon(LineIcons.byName('desktop'), size: 40, color: Util.randomOpaqueColor),
    // Icon(LineIcons.values['radiation'], size: 40, color: Util.randomOpaqueColor),
    // Icon(LineIcons.addressCardAlt, size: 40, color: Util.randomOpaqueColor),
    // LineIcon.tablet(size: 40, color: Util.randomOpaqueColor),
    // LineIcon.lemon(size: 40, color: Util.randomOpaqueColor),

    var map = LineIcons.values;
    return CustomScrollView(
      slivers: [
        SliverGridSection.builderTypeWidget(
          crossAxisCount: 2,
          childAspectRatio: 3,
          items: List.from(map.keys),
          builder: (c, i, d) {
            var name = (d as String).capitalCaseString;
            return Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(map[d], size: 40, color: Util.randomOpaqueColor),
                    WidgetsFactory.text('${i + 1}', textAlign: TextAlign.center, color: Colors.grey, fontSize: 10),
                  ],
                ).addPaddingOnly(left: 5, right: 5),
                Expanded(child: WidgetsFactory.text(name, maxLines: 2).addPaddingOnly(right: 5)),
              ],
            ).addTapEvent(() => appPrint('${map[d]} LineIcons.$d'), includeContainer: true);
          },
        ),
      ],
    );
  }
}
