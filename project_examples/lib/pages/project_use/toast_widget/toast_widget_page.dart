import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';
import 'package:shimmer/shimmer.dart';

class ToastWidgetPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ToastWidgetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ToastWidgetPageState();
}

class ToastWidgetPageState extends NormalStatefulWidgetState<ToastWidgetPage> {
  final ToastWidget _toastWidget = ToastWidget();

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
                _toastWidget
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
                              WidgetsFactory.text('Loading...', color: Colors.grey, fontSize: 13.sp),
                            ],
                          ),
                        ),
                      );
                    })
                    .show()
                    .hide(afterDelay: const Duration(seconds: 3), complete: (v) => appPrint('did hide'));
              },
              child: Text('点击我'.tr)),
        ),
        _toastWidget,
      ],
    );
  }
}
