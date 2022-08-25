import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToastWidgetPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ToastWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ToastWidgetPageState();
}

class ToastWidgetPageState extends NormalStatefulWidgetState<ToastWidgetPage> {
  final ToastWidget toastWidget = ToastWidget();

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: () {
                toastWidget
                    .setData(Util.randomObjectFromList(['desktop', 'radiation', 'lemon', 'tablet']))
                    .setWidgetBuilder((v) {
                      return Container(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.85)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.withOpacity(0.3),
                                period: const Duration(milliseconds: 1250),
                                child: Icon(LineIcons.byName(v.data), size: 60),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 5)),
                              WidgetsFactory.text('Loading...', color: Colors.grey, fontSize: 25.sp),
                            ],
                          ),
                        ),
                      );
                    })
                    .show()
                    .hide(afterDelay: const Duration(seconds: 3), complete: (v) => appPrint('did hide'));
              },
              child: const Text('点击我')),
        ),
        toastWidget,
      ],
    );
  }
}
