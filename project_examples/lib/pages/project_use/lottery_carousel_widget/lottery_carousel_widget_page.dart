import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class LotteryCarouselWidgetPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const LotteryCarouselWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => LotteryCarouselWidgetPageState();
}

class LotteryCarouselWidgetPageState extends NormalStatefulWidgetState<LotteryCarouselWidgetPage> {
  final manager = LotteryCarouselManager();

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Util.image('lottery_bg.png'),
              Positioned.fill(child: LotteryCarouselWidget(manager: manager, rotateChild: Util.image('lottery_round_plate.png'))),
              Positioned.fill(
                child: ScaleButtonWidget(
                  child: Util.image('lottery_button.png'),
                  onTap: () => manager.startRotating(),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: -20,
                child: Container(
                  alignment: Alignment.center,
                  child: Util.image('lottery_arrow.png'),
                ),
              ),
            ],
          ),
          OpacityButtonWidget(
            margin: EdgeInsets.only(top: 30.w),
            onTap: () => manager.endRotatingAtPercent(Util.randomPercent),
            child: WidgetsFactory.text('停止', fontSize: 42.sp, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          OpacityButtonWidget(
            margin: EdgeInsets.only(top: 30.w),
            onTap: () => manager.reset(),
            child: WidgetsFactory.text('重置', fontSize: 42.sp, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
