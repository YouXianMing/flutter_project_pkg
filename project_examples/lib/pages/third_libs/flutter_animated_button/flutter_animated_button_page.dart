import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:project_examples/file_headers.dart';

class FlutterAnimatedButtonPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const FlutterAnimatedButtonPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => FlutterAnimatedButtonPageState();
}

class FlutterAnimatedButtonPageState extends NormalStatefulWidgetState<FlutterAnimatedButtonPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget backgroundWidget(BuildContext context) => Container(color: Colors.black);

  @override
  Widget body(BuildContext context) {
    var submitTextStyle = const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300);
    return CustomScrollView(
      slivers: [
        SliverGridSection.staticTypeWidget(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 2.5 / 1,
          children: [
            Center(
              child: AnimatedButton(
                // animatedOn: AnimatedOn.onHover, // web专用参数
                onPress: () {},
                onChanges: (change) {},
                text: 'SUBMIT-1',
                isReverse: true,
                selectedTextColor: Colors.white,
                transitionType: TransitionType.LEFT_TOP_ROUNDER,
                textStyle: submitTextStyle,
                backgroundColor: Colors.black,
                selectedBackgroundColor: Colors.lightGreen,
                borderColor: Colors.white,
                borderWidth: 1,
              ),
            ),
            Center(
              child: AnimatedButton(
                onPress: () {},
                text: 'SUBMIT-2',
                gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
                selectedGradientColor: const LinearGradient(colors: [Colors.pinkAccent, Colors.purpleAccent]),
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.LEFT_CENTER_ROUNDER,
                textStyle: submitTextStyle,
                borderColor: Colors.white,
                borderWidth: 1,
              ),
            ),
            Center(
              child: AnimatedButton(
                onPress: () {},
                text: 'SUBMIT-3',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.LEFT_BOTTOM_ROUNDER,
                textStyle: submitTextStyle,
                backgroundColor: Colors.black,
                borderColor: Colors.white,
                borderWidth: 1,
              ),
            ),
            Center(
              child: AnimatedButton(
                onPress: () {},
                text: 'SUBMIT-4',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.RIGHT_TOP_ROUNDER,
                textStyle: submitTextStyle,
                backgroundColor: Colors.black,
                borderColor: Colors.white,
                borderWidth: 1,
              ),
            ),
            Center(
              child: AnimatedButton(
                onPress: () {},
                text: 'SUBMIT-5',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.RIGHT_CENTER_ROUNDER,
                textStyle: submitTextStyle,
                backgroundColor: Colors.black,
                borderColor: Colors.white,
                borderWidth: 1,
              ),
            ),
            Center(
              child: AnimatedButton(
                onPress: () {},
                text: 'SUBMIT-6',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.RIGHT_BOTTOM_ROUNDER,
                textStyle: submitTextStyle,
                backgroundColor: Colors.black,
                borderColor: Colors.white,
                borderWidth: 1,
              ),
            ),
            Center(
              child: AnimatedButton(
                onPress: () {},
                text: 'SUBMIT-7',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.TOP_CENTER_ROUNDER,
                textStyle: submitTextStyle,
                backgroundColor: Colors.black,
                borderColor: Colors.white,
                borderWidth: 1,
              ),
            ),
            Center(
              child: AnimatedButton(
                onPress: () {},
                text: 'SUBMIT-8',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.BOTTOM_CENTER_ROUNDER,
                textStyle: submitTextStyle,
                backgroundColor: Colors.black,
                borderColor: Colors.white,
                borderWidth: 1,
              ),
            ),
            Center(
              child: AnimatedButton(
                onPress: () {},
                text: 'SUBMIT-9',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.CENTER_ROUNDER,
                textStyle: submitTextStyle,
                backgroundColor: Colors.black,
                borderColor: Colors.white,
                borderWidth: 1,
              ),
            ),
            Center(
              child: AnimatedButton.strip(
                // animatedOn: AnimatedOn.onHover, // web专用参数
                text: 'SUBMIT-10',
                isReverse: true,
                selectedTextColor: Colors.black,
                textStyle: submitTextStyle,
                backgroundColor: Colors.black,
                onPress: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
