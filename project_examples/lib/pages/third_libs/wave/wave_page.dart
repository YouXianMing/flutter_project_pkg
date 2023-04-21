import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:project_examples/file_headers.dart';

class WavePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const WavePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => WavePageState();
}

class WavePageState extends NormalStatefulWidgetState<WavePage> {
  /// 卡片
  SizedBox _widgetCard({
    required Config config,
    Color? backgroundColor = Colors.transparent,
    DecorationImage? backgroundImage,
    double height = 152.0,
  }) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Card(
        elevation: 12.0,
        margin: const EdgeInsets.only(right: 16, left: 16, bottom: 16.0),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: WaveWidget(
          config: config,
          backgroundColor: backgroundColor,
          backgroundImage: backgroundImage,
          size: const Size(double.infinity, double.infinity),
          waveAmplitude: 0,
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: <Widget>[
            const SizedBox(height: 16.0),
            _widgetCard(
              backgroundColor: Colors.indigo,
              config: CustomConfig(
                gradients: [
                  [Colors.red, const Color(0xEEF44336)],
                  [Colors.red[800]!, const Color(0x77E57373)],
                  [Colors.orange, const Color(0x66FF9800)],
                  [Colors.yellow, const Color(0x55FFEB3B)]
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.20, 0.33, 0.45, 0.50],
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
            ),
            _widgetCard(
              backgroundImage: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1554779147-a2a22d816042?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3540',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight),
              ),
              config: CustomConfig(
                colors: [Colors.pink[400]!, Colors.pink[300]!, Colors.pink[200]!, Colors.pink[100]!],
                durations: [18000, 8000, 5000, 12000],
                heightPercentages: [0.75, 0.76, 0.88, 0.90],
              ),
            ),
            _widgetCard(
                config: CustomConfig(
                  colors: [Colors.white70, Colors.white54, Colors.white30, Colors.white24],
                  durations: [32000, 21000, 18000, 5000],
                  heightPercentages: [0.45, 0.26, 0.28, 0.31],
                ),
                backgroundColor: Colors.blue[600]),
            Align(
              child: Container(
                height: 128,
                width: 128,
                decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(color: Color(0xFF9B5DE5), blurRadius: 2.0, spreadRadius: -5.0, offset: Offset(0.0, 8.0)),
                ]),
                child: ClipOval(
                  child: WaveWidget(
                    config: CustomConfig(
                      colors: [const Color(0xFFFEE440), const Color(0xFF00BBF9)],
                      durations: [5000, 4000],
                      heightPercentages: [0.65, 0.66],
                    ),
                    backgroundColor: const Color(0xFFF15BB5),
                    size: const Size(double.infinity, double.infinity),
                    waveAmplitude: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: SizedBox(
            height: 90,
            child: WaveWidget(
              config: CustomConfig(
                colors: [
                  Colors.indigo[400]!.withOpacity(0.5),
                  Colors.indigo[300]!.withOpacity(0.5),
                  Colors.indigo[200]!.withOpacity(0.5),
                  Colors.indigo[100]!.withOpacity(0.5),
                ],
                durations: [18000, 8000, 5000, 12000],
                heightPercentages: [0.35, 0.34, 0.32, 0.3],
              ),
              size: const Size(double.infinity, double.infinity),
              waveAmplitude: 0,
            ),
          ),
        ),
      ],
    );
  }
}
