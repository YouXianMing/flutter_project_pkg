import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_base_libs_pkg/third_lib_marqueer.dart';
import 'package:project_examples/file_headers.dart';

class MarqueerPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const MarqueerPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => MarqueerPageState();
}

class MarqueerPageState extends NormalStatefulWidgetState<MarqueerPage> {
  final _controller = MarqueerController();

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
        // 带控制器的版本
        SizedBox(
          height: 30,
          child: Marqueer(
            pps: 40,

            /// optional
            controller: _controller,

            /// optional
            direction: MarqueerDirection.rtl,

            /// optional
            restartAfterInteractionDuration: const Duration(seconds: 6),

            /// optional
            restartAfterInteraction: false,

            /// optional
            onChangeItemInViewPort: (index) {
              appPrint('item index: $index');
            },
            onInteraction: () {
              appPrint('on interaction callback');
            },
            onStarted: () {
              appPrint('on started callback');
            },
            onStopped: () {
              appPrint('on stopped callback');
            },
            child: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pretium massa mollis lorem blandit imperdiet. Nulla mattis vitae mauris vel condimentum. Nam posuere, augue vitae lobortis consequat, odio ante condimentum est, at maximus augue purus id metus. Curabitur condimentum aliquet ante at aliquet. Quisque vel massa congue, bibendum leo sodales, malesuada ante. Maecenas sed tortor quis ipsum dictum sollicitudin.',
            ),
          ),
        ),

        // builder版本
        SizedBox(
          height: 50,
          child: Marqueer.builder(
            itemCount: 200,
            direction: MarqueerDirection.ltr,
            itemBuilder: (context, index) => Container(
              alignment: Alignment.center,
              color: Util.randomColor,
              padding: const EdgeInsets.all(10),
              child: Text('index: $index'),
            ),
          ),
        ),
      ],
    );
  }
}
