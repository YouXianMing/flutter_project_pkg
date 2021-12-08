import 'package:example/page_route/page_arguments.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class ToastWidgetPage extends NormalStatefulWidget {
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
        title: NormalAppBar.titleWidget(widget.arguments?.mark ?? ''),
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
                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.85)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.ac_unit, size: 60, color: Colors.grey),
                              const Padding(padding: EdgeInsets.only(top: 5)),
                              WidgetsFactory.text('Loading...', color: Colors.grey, fontSize: 18),
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
