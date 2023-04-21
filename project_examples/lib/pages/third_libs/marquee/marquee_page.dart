import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/widgets/app_button.dart';
import 'package:marquee/marquee.dart';
import 'package:project_examples/file_headers.dart';

class MarqueePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const MarqueePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => MarqueePageState();
}

class MarqueePageState extends NormalStatefulWidgetState<MarqueePage> {
  bool _useRtlText = false;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        AppButton(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.only(bottom: 20),
          style: AppButtonStyle.blue,
          onTap: () => setState(() => _useRtlText = !_useRtlText),
          child: WidgetsFactory.text(_useRtlText ? 'RTL' : 'LTR', color: Colors.white),
        ),
        _buildMarquee(),
        _buildComplexMarquee(),
      ],
    );
  }

  Widget _buildMarquee() {
    return Container(
      height: 50,
      color: Util.randomColor,
      child: Marquee(
        key: Key('$_useRtlText'),
        text: !_useRtlText ? 'There once was a boy who told this story about a boy: "' : 'פעם היה ילד אשר סיפר סיפור על ילד:"',
        velocity: 50.0,
      ),
    );
  }

  Widget _buildComplexMarquee() {
    return Container(
      height: 50,
      color: Util.randomColor,
      child: Marquee(
        key: Key('$_useRtlText'),
        text: !_useRtlText ? 'Some sample text that takes some space.' : 'זהו משפט ראשון של הטקסט הארוך. זהו המשפט השני של הטקסט הארוך',
        style: const TextStyle(fontWeight: FontWeight.bold),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        blankSpace: 20,
        velocity: 100,
        pauseAfterRound: const Duration(seconds: 1),
        showFadingOnlyWhenScrolling: true,
        fadingEdgeStartFraction: 0.1,
        fadingEdgeEndFraction: 0.1,
        numberOfRounds: 3,
        startPadding: 10,
        accelerationDuration: const Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
        textDirection: _useRtlText ? TextDirection.rtl : TextDirection.ltr,
      ),
    );
  }
}
