import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class ResizeToAvoidBottomInsetPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ResizeToAvoidBottomInsetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ResizeToAvoidBottomInsetPageState();
}

class ResizeToAvoidBottomInsetPageState extends NormalStatefulWidgetState<ResizeToAvoidBottomInsetPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Widget backgroundWidget(BuildContext context) => Container(color: Colors.white);

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10.w), child: const TextField()),
        Expanded(
          child: Container(color: Colors.yellow.withOpacity(0.3), margin: EdgeInsets.only(left: 10.w, right: 10.w))
              .addTapEvent(() => hideKeyBoard(context)),
        ),

        // 用SafeArea与resizeToAvoidBottomInset来解决弹起键盘时底部按钮的安全距离问题
        SafeArea(
          child: OpacityButtonWidget(
            onTap: () => hideKeyBoard(context),
            child: Container(
              child: WidgetsFactory.text('Save', color: Colors.white, fontSize: 18).addContainerBorderRadius(
                color: Colors.lightBlue,
                padding: EdgeInsets.symmetric(vertical: 15.w),
                margin: EdgeInsets.all(10.w),
                width: double.infinity,
                alignment: Alignment.center,
                radius: 10.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
