import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:project_examples/file_headers.dart';

class LiquidProgressIndicatorPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const LiquidProgressIndicatorPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => LiquidProgressIndicatorPageState();
}

class LiquidProgressIndicatorPageState extends NormalStatefulWidgetState<LiquidProgressIndicatorPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverListSection.staticTypeWidget(
          children: [
            const SizedBox(height: 20),
            _AnimatedLiquidCircularProgressIndicator(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 75,
                  height: 75,
                  child: LiquidCircularProgressIndicator(
                    backgroundColor: Colors.black,
                    valueColor: const AlwaysStoppedAnimation(Colors.red),
                  ),
                ),
                SizedBox(
                  width: 75,
                  height: 75,
                  child: LiquidCircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: const AlwaysStoppedAnimation(Colors.pink),
                    borderColor: Colors.red,
                    borderWidth: 5.0,
                    direction: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  width: 75,
                  height: 75,
                  child: LiquidCircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: const AlwaysStoppedAnimation(Colors.grey),
                    borderColor: Colors.blue,
                    borderWidth: 5.0,
                    center: const Text('Loading...', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  width: 75,
                  height: 75,
                  child: LiquidCircularProgressIndicator(
                    backgroundColor: Colors.lightGreen,
                    valueColor: const AlwaysStoppedAnimation(Colors.blueGrey),
                    direction: Axis.horizontal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _AnimatedLiquidCustomProgressIndicator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    LiquidCustomProgressIndicator(
                      direction: Axis.vertical,
                      value: 0.2,
                      shapePath: _buildBoatPath(),
                    ),
                    LiquidCustomProgressIndicator(
                      direction: Axis.horizontal,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation(Colors.red),
                      shapePath: _buildSpeechBubblePath(),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            _AnimatedLiquidLinearProgressIndicator(),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: LiquidLinearProgressIndicator(backgroundColor: Colors.black, valueColor: const AlwaysStoppedAnimation(Colors.red)),
            ),
            const SizedBox(height: 20),
            // Container(
            //   width: double.infinity,
            //   height: 35,
            //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //   child: LiquidLinearProgressIndicator(
            //     backgroundColor: Colors.white,
            //     valueColor: const AlwaysStoppedAnimation(Colors.pink),
            //     borderColor: Colors.red,
            //     borderWidth: 5.0,
            //     direction: Axis.vertical,
            //   ),
            // ),
            const SizedBox(height: 20),
            // Container(
            //   width: double.infinity,
            //   height: 35,
            //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //   child: LiquidLinearProgressIndicator(
            //     backgroundColor: Colors.white,
            //     valueColor: const AlwaysStoppedAnimation(Colors.grey),
            //     borderColor: Colors.blue,
            //     borderWidth: 5.0,
            //     center: const Text('Loading...', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
            //   ),
            // ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: LiquidLinearProgressIndicator(
                backgroundColor: Colors.lightGreen,
                valueColor: const AlwaysStoppedAnimation(Colors.blueGrey),
                direction: Axis.vertical,
              ),
            ),
            const SizedBox(height: 20),
            SafeAreaPaddingWidget.bottom(),
          ],
        ),
      ],
    );
  }

  Path _buildBoatPath() {
    return Path()
      ..moveTo(15, 120)
      ..lineTo(0, 85)
      ..lineTo(50, 85)
      ..lineTo(50, 0)
      ..lineTo(105, 80)
      ..lineTo(60, 80)
      ..lineTo(60, 85)
      ..lineTo(120, 85)
      ..lineTo(105, 120)
      ..close();
  }

  Path _buildSpeechBubblePath() {
    return Path()
      ..moveTo(50, 0)
      ..quadraticBezierTo(0, 0, 0, 37.5)
      ..quadraticBezierTo(0, 75, 25, 75)
      ..quadraticBezierTo(25, 95, 5, 95)
      ..quadraticBezierTo(35, 95, 40, 75)
      ..quadraticBezierTo(100, 75, 100, 37.5)
      ..quadraticBezierTo(100, 0, 50, 0)
      ..close();
  }
}

class _AnimatedLiquidCircularProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedLiquidCircularProgressIndicatorState();
}

class _AnimatedLiquidCircularProgressIndicatorState extends State<_AnimatedLiquidCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return Center(
      child: SizedBox(
        width: 150.0,
        height: 150.0,
        child: LiquidCircularProgressIndicator(
          value: _animationController.value,
          backgroundColor: Colors.white,
          valueColor: const AlwaysStoppedAnimation(Colors.blue),
          center: Text(
            '${percentage.toStringAsFixed(0)}%',
            style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _AnimatedLiquidCustomProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedLiquidCustomProgressIndicatorState();
}

class _AnimatedLiquidCustomProgressIndicatorState extends State<_AnimatedLiquidCustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return Center(
      child: LiquidCustomProgressIndicator(
        value: _animationController.value,
        direction: Axis.vertical,
        backgroundColor: Colors.white,
        valueColor: const AlwaysStoppedAnimation(Colors.green),
        shapePath: _buildHeartPath(),
        center: Text('${percentage.toStringAsFixed(0)}%',
            style: const TextStyle(color: Colors.lightGreenAccent, fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Path _buildHeartPath() {
    return Path()
      ..moveTo(55, 15)
      ..cubicTo(55, 12, 50, 0, 30, 0)
      ..cubicTo(0, 0, 0, 37.5, 0, 37.5)
      ..cubicTo(0, 55, 20, 77, 55, 95)
      ..cubicTo(90, 77, 110, 55, 110, 37.5)
      ..cubicTo(110, 37.5, 110, 0, 80, 0)
      ..cubicTo(65, 0, 55, 12, 55, 15)
      ..close();
  }
}

class _AnimatedLiquidLinearProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedLiquidLinearProgressIndicatorState();
}

class _AnimatedLiquidLinearProgressIndicatorState extends State<_AnimatedLiquidLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return Center(
      child: Container(
        width: double.infinity,
        height: 75.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: LiquidLinearProgressIndicator(
          value: _animationController.value,
          backgroundColor: Colors.white,
          valueColor: const AlwaysStoppedAnimation(Colors.blue),
          borderRadius: 12.0,
          center: Text(
            '${percentage.toStringAsFixed(0)}%',
            style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
