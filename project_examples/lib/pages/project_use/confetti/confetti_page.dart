import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/pages/project_use/confetti/widgets/confetti.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_examples/app_route_style.dart';

class ConfettiPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ConfettiPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ConfettiPageState();
}

class ConfettiPageState extends NormalStatefulWidgetState<ConfettiPage> {
  final manager = LotteryCarouselManager();

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Confetti();
  }
}
