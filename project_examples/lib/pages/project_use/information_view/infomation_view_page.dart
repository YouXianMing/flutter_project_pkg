import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/pages/base/normal_stateless_widget.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationViewPage extends NormalStatelessWidget {
  InformationViewPage({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
      );

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverListSection.builderTypeWidget(items: [
          InformationViewTestModel.use1(context),
          InformationViewTestModel.use2(context),
          InformationViewTestModel.use3(context),
          InformationViewTestModel.use4(context),
          InformationViewTestModel.use5(context),
          InformationViewTestModel.use6(context),
          InformationViewTestModel.use7(context),
        ], builder: (c, i, d) => itemWidget((d as InformationViewTestModel).title, d.tap)),
      ],
    );
  }

  Widget itemWidget(String title, Function? onTap) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.w, bottom: 30.w),
      color: Colors.white,
      child: Text(title),
    ).addTapEvent(() {
      if (onTap != null) onTap();
    });
  }
}

class InformationViewTestModel {
  final String title;
  final Function? tap;
  final BuildContext context;
  InformationViewTestModel({required this.context, required this.title, this.tap});

  static InformationViewTestModel use1(BuildContext context) {
    return InformationViewTestModel(
        title: 'innerLoading.show(可以点击返回键返回)',
        context: context,
        tap: () {
          NormalStatelessWidget widget = context.widget as NormalStatelessWidget;
          widget.innerLoading.show();
          widget.innerLoading.hide(afterDelay: const Duration(seconds: 2));
        });
  }

  static InformationViewTestModel use2(BuildContext context) {
    return InformationViewTestModel(
        title: 'outerLoading.show(不可以点击返回键返回)',
        context: context,
        tap: () {
          NormalStatelessWidget widget = context.widget as NormalStatelessWidget;
          widget.outerLoading.show();
          widget.outerLoading.hide(afterDelay: const Duration(seconds: 2));
        });
  }

  static InformationViewTestModel use3(BuildContext context) {
    return InformationViewTestModel(
        title: 'InformationView用作文本信息展示',
        context: context,
        tap: () {
          String info = 'InformationView用作文本信息展示';
          double fontSize = 20;

          NormalStatelessWidget widget = context.widget as NormalStatelessWidget;
          InformationView(
            type: AnimatedWidgetType.simpleToast,
            waitForBuild: true,
            self: (v) => widget.outerStackContainer.insertWidget(v),
            data: info,
          )
              .setWidgetBuilder((v) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 70),
                    padding: const EdgeInsets.all(10),
                    color: Colors.blueGrey,
                    child: WidgetsFactory.text(
                      v.data,
                      color: Colors.white,
                      fontSize: fontSize,
                      textAlign: TextAlign.center,
                    ).addDefaultTextStyle(),
                  ),
                );
              })
              .show()
              .hide(afterDelay: const Duration(seconds: 3), complete: (v) => widget.outerStackContainer.deleteWidget(v));
        });
  }

  static InformationViewTestModel use4(BuildContext context) {
    return InformationViewTestModel(
        title: 'InformationView用作自定义Toast',
        context: context,
        tap: () {
          NormalStatelessWidget widget = context.widget as NormalStatelessWidget;
          InformationView(
            type: AnimatedWidgetType.simpleToast,
            waitForBuild: true,
          )
              .inStackContainer(widget.outerStackContainer)
              .setWidgetBuilder((v) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: IndicatorWidget(
                      config: CytrynIndicatorConfig(
                        type: CytrynIndicatorType.bouncingGridCircle,
                        borderColor: Colors.transparent,
                        backgroundColor: Colors.blueGrey,
                      ),
                    ),
                  ),
                );
              })
              .show()
              .hide(afterDelay: const Duration(seconds: 3));
        });
  }

  static InformationViewTestModel use5(BuildContext context) {
    // ignore: prefer_function_declarations_over_variables
    Widget Function(InformationView, StatusWidget, StatusWidgetStatus) blueButtonBlock = (v, s, status) {
      return Container(
        color: Colors.transparent,
        width: double.infinity,
        alignment: Alignment.center,
        height: 80.w,
        child: WidgetsFactory.text(
          s.data,
          fontSize: 30.w,
          fontWeight: FontWeight.bold,
          color: status == StatusWidgetStatus.normal ? Colors.blueAccent : Colors.blueAccent.withOpacity(0.5),
        ),
      );
    };

    // ignore: prefer_function_declarations_over_variables
    Widget Function(InformationView, StatusWidget, StatusWidgetStatus) redButtonBlock = (v, s, status) {
      return Container(
        color: Colors.transparent,
        width: double.infinity,
        alignment: Alignment.center,
        height: 90.w,
        child: WidgetsFactory.text(
          s.data,
          fontSize: 30.w,
          fontWeight: FontWeight.w300,
          color: status == StatusWidgetStatus.normal ? Colors.redAccent : Colors.redAccent.withOpacity(0.5),
        ),
      );
    };

    return InformationViewTestModel(
        title: 'InformationView用作AlertView',
        context: context,
        tap: () {
          NormalStatelessWidget widget = context.widget as NormalStatelessWidget;
          InformationView(
            type: AnimatedWidgetType.popView,
            waitForBuild: true,
          ).inStackContainer(widget.outerStackContainer).setWidgetBuilder((v) {
            return Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Container(
                width: Get.width * 0.75,
                padding: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetsFactory.text('标题', fontSize: 36.sp).addPadding(EdgeInsets.only(top: 20.w)),
                    WidgetsFactory.text('这是一个AlertView,用于展示警告信息!', fontSize: 28.sp, textAlign: TextAlign.center)
                        .addPadding(EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.w)),
                    Container(height: 1.w, color: Colors.grey.withOpacity(0.2)),
                    StatusWidget.normalButton(
                      initData: '确定',
                      normalStatusBuilder: (s) => blueButtonBlock(v, s, StatusWidgetStatus.normal),
                      highlightedStatusBuilder: (s) => blueButtonBlock(v, s, StatusWidgetStatus.highlighted),
                      onTap: (s) => v.hide(),
                    ),
                    Container(height: 1.w, color: Colors.grey.withOpacity(0.2)),
                    StatusWidget.normalButton(
                      initData: '取消',
                      normalStatusBuilder: (s) => redButtonBlock(v, s, StatusWidgetStatus.normal),
                      highlightedStatusBuilder: (s) => redButtonBlock(v, s, StatusWidgetStatus.highlighted),
                      onTap: (s) => v.hide(),
                    ),
                  ],
                ),
              ).addTapEvent(() {}),
            ).addDefaultTextStyle();
          }).show();
        });
  }

  static InformationViewTestModel use6(BuildContext context) {
    return InformationViewTestModel(
        title: 'InformationView用作弹出表单(从下往上弹出)',
        context: context,
        tap: () {
          NormalStatelessWidget widget = context.widget as NormalStatelessWidget;
          InformationView(
            type: AnimatedWidgetType.sheetView,
            waitForBuild: true,
            config: AnimatedSheetViewConfig(backgroundColor: Colors.black.withOpacity(0.75)),
          ).inStackContainer(widget.outerStackContainer).setWidgetBuilder((v) {
            return Container(
              color: Colors.transparent,
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  Container(padding: EdgeInsets.only(top: Get.height * 0.35), color: Colors.transparent).addTapEvent(() => v.hide()),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          // 顶部标题
                          SizedBox(
                            height: 80.w,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                WidgetsFactory.text('Sheet', color: Colors.black, fontSize: 28.sp).addDefaultTextStyle(),
                                Positioned(
                                  right: 5,
                                  child: const Icon(Icons.close).addTapEvent(() => v.hide()),
                                ),
                              ],
                            ),
                          ),
                          // 线条
                          Container(height: 2.w, color: Colors.grey.withOpacity(0.2)),
                          Expanded(
                            child: CustomScrollView(
                              slivers: [
                                SliverListSection.builderTypeWidget(
                                  items: [
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                  ],
                                  builder: (c, i, d) => WidgetsFactory.textContainer(d,
                                          height: 90.w, textColor: Util.randomOpaqueColor, alignment: Alignment.center)
                                      .addDefaultTextStyle(),
                                ),
                                SliverBoxAdapterSection.widget(builder: (v) => const SafeAreaPaddingWidget(type: SafeAreaPadding.bottom)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).show();
        });
  }

  static InformationViewTestModel use7(BuildContext context) {
    return InformationViewTestModel(
        title: 'InformationView用作弹出表单(从上往下弹出)',
        context: context,
        tap: () {
          NormalStatelessWidget widget = context.widget as NormalStatelessWidget;
          InformationView(
            type: AnimatedWidgetType.sheetView,
            waitForBuild: true,
            config: AnimatedSheetViewConfig(backgroundColor: Colors.black.withAlpha(75), type: AnimatedSheetType.fromTopToBottom),
          ).inStackContainer(widget.outerStackContainer).setWidgetBuilder((v) {
            return Container(
              color: Colors.transparent,
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: CustomScrollView(
                              slivers: [
                                SliverBoxAdapterSection.widget(builder: (v) => const SafeAreaPaddingWidget(type: SafeAreaPadding.top)),
                                SliverListSection.builderTypeWidget(
                                  items: [
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                    Util.randomWordPairAsCamelCase,
                                  ],
                                  builder: (c, i, d) => WidgetsFactory.textContainer(d,
                                          height: 90.w, textColor: Util.randomOpaqueColor, alignment: Alignment.center)
                                      .addDefaultTextStyle(),
                                ),
                              ],
                            ),
                          ),
                          // 线条
                          Container(height: 2.w, color: Colors.grey.withOpacity(0.2)),
                          // 顶部标题
                          SizedBox(
                            height: 80.w,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                WidgetsFactory.text('Sheet', color: Colors.black, fontSize: 28.sp).addDefaultTextStyle(),
                                Positioned(
                                  right: 5,
                                  child: const Icon(Icons.close).addTapEvent(() => v.hide()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(padding: EdgeInsets.only(top: Get.height * 0.35), color: Colors.transparent).addTapEvent(() => v.hide()),
                ],
              ),
            );
          }).show();
        });
  }
}
