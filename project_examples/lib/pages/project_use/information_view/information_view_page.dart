import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_page_build_mixin.dart';
import 'package:project_examples/file_headers.dart';
import 'package:project_examples/widgets/app_button.dart';

class InformationViewPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const InformationViewPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => InformationViewPageState();
}

class InformationViewPageState extends NormalStatefulWidgetState<InformationViewPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverListSection.builderTypeWidget(items: [
          InformationViewTestModel.use1(context, this),
          InformationViewTestModel.use2(context, this),
          InformationViewTestModel.use3(context, this),
          InformationViewTestModel.use4(context, this),
          InformationViewTestModel.use5(context, this),
          InformationViewTestModel.use6(context, this),
          InformationViewTestModel.use7(context, this),
          InformationViewTestModel.use8(context, this),
          InformationViewTestModel.use9(context, this),
        ], builder: (c, i, d) => itemWidget((d as InformationViewTestModel).title, d.tap)),
      ],
    );
  }

  Widget itemWidget(String title, Function? onTap) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.w, bottom: 15.w),
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

  static InformationViewTestModel use1(BuildContext context, NormalPageBuildMixin page) {
    return InformationViewTestModel(
        title: 'innerLoading.show(可以点击返回键返回)',
        context: context,
        tap: () {
          page.innerLoading.show();
          page.innerLoading.hide(afterDelay: const Duration(seconds: 2));
        });
  }

  static InformationViewTestModel use2(BuildContext context, NormalPageBuildMixin page) {
    return InformationViewTestModel(
        title: 'outerLoading.show(不可以点击返回键返回)',
        context: context,
        tap: () {
          page.outerLoading.show();
          page.outerLoading.hide(afterDelay: const Duration(seconds: 2));
        });
  }

  static InformationViewTestModel use3(BuildContext context, NormalPageBuildMixin page) {
    return InformationViewTestModel(
        title: 'InformationView用作文本信息展示',
        context: context,
        tap: () {
          String info = 'InformationView用作文本信息展示';
          double fontSize = 20;

          InformationView(
            type: AnimatedWidgetType.simpleToast,
            waitForBuild: true,
            self: (v) => page.outerStackContainer.insertWidget(v),
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
              .hide(afterDelay: const Duration(seconds: 3), complete: (v) => page.outerStackContainer.deleteWidget(v));
        });
  }

  static InformationViewTestModel use4(BuildContext context, NormalPageBuildMixin page) {
    return InformationViewTestModel(
        title: 'InformationView用作自定义Toast',
        context: context,
        tap: () {
          InformationView(
            type: AnimatedWidgetType.simpleToast,
            waitForBuild: true,
          )
              .inStackContainer(page.outerStackContainer)
              .setWidgetBuilder((v) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                      BoxShadow(color: Colors.grey.withAlpha(35), offset: const Offset(0.0, 0.0), blurRadius: 8.0, spreadRadius: 2.0)
                    ]),
                    child: IndicatorWidget(
                      config: CytrynIndicatorConfig(
                        type: CytrynIndicatorType.bouncingLineSquare,
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

  static InformationViewTestModel use5(BuildContext context, NormalPageBuildMixin page) {
    Widget button({required String title, required Color color, FontWeight fontWeight = FontWeight.normal}) {
      return AnimatedContainer(
        color: Colors.transparent,
        width: double.infinity,
        alignment: Alignment.center,
        height: 40,
        duration: const Duration(milliseconds: 150),
        child: WidgetsFactory.text(title, fontSize: 15, fontWeight: fontWeight, color: color),
      );
    }

    return InformationViewTestModel(
        title: 'InformationView用作AlertView',
        context: context,
        tap: () {
          InformationView(
            type: AnimatedWidgetType.popView,
            config: AnimatedPopViewConfig(showScale: 1.15, hideScale: 0.9),
            waitForBuild: true,
          ).inStackContainer(page.outerStackContainer).setWidgetBuilder((v) {
            return Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Container(
                width: 300,
                padding: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetsFactory.text('标题', fontSize: 18, fontWeight: FontWeight.bold).addPadding(const EdgeInsets.only(top: 10)),
                    WidgetsFactory.text('这是一个AlertView,用于展示警告信息!', fontSize: 14, textAlign: TextAlign.center)
                        .addPaddingOnly(left: 12.w, right: 12.w, top: 15.w, bottom: 20.w),
                    Container(height: 0.5, color: Colors.grey.withOpacity(0.2)),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: BaseButtonWidget(
                            onTap: () => v.hide(),
                            childBuilder: () => button(title: '取消', color: Colors.red),
                            highlightedChildBuilder: () => button(title: '取消', color: Colors.red.withOpacity(0.5)),
                          ),
                        ),
                        Container(width: 1, color: Colors.grey.withOpacity(0.2), height: 40),
                        Expanded(
                          flex: 1,
                          child: BaseButtonWidget(
                            onTap: () => v.hide(),
                            childBuilder: () => button(title: '确定', color: Colors.blueAccent, fontWeight: FontWeight.bold),
                            highlightedChildBuilder: () =>
                                button(title: '确定', color: Colors.blueAccent.withOpacity(0.5), fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).addTapEvent(() {}),
            ).addDefaultTextStyle();
          }).show();
        });
  }

  static InformationViewTestModel use6(BuildContext context, NormalPageBuildMixin page) {
    return InformationViewTestModel(
        title: 'InformationView用作弹出表单(从下往上弹出)',
        context: context,
        tap: () {
          InformationView(
            type: AnimatedWidgetType.sheetView,
            waitForBuild: true,
            config: AnimatedSheetViewConfig(backgroundColor: Colors.black.withAlpha(75)),
          ).managerMaybePopEvent(blockMaybePopEvent: true).inOverlay(context).setWidgetBuilder((v) {
            return Column(
              children: [
                Flexible(flex: 2, child: Container(color: Colors.transparent).addTapEvent(() => v.hide())),
                Flexible(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        // 顶部标题
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              WidgetsFactory.text('Sheet', color: Colors.black, fontSize: 14).addDefaultTextStyle(),
                              Positioned(right: 5, child: const Icon(Icons.close).addTapEvent(() => v.hide())),
                            ],
                          ),
                        ),
                        // 线条
                        Container(height: 1, color: Colors.grey.withOpacity(0.2)),
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverGridSection.builderTypeWidget(
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
                                builder: (c, i, d) => Center(
                                  child: WidgetsFactory.text((d as String).capitalCaseString,
                                      color: Util.randomOpaqueColor, textAlign: TextAlign.center),
                                ),
                                crossAxisCount: 2,
                                childAspectRatio: 3,
                              ),
                              SliverBoxAdapterSection.widget(builder: (v) => const SafeAreaPaddingWidget(type: SafeAreaPadding.bottom)),
                            ],
                          ).addDefaultTextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).show();
        });
  }

  static InformationViewTestModel use7(BuildContext context, NormalPageBuildMixin page) {
    return InformationViewTestModel(
        title: 'InformationView用作弹出表单(从上往下弹出)',
        context: context,
        tap: () {
          InformationView(
            type: AnimatedWidgetType.sheetView,
            waitForBuild: true,
            config: AnimatedSheetViewConfig(backgroundColor: Colors.black.withAlpha(75), type: AnimatedSheetType.fromTopToBottom),
          ).inStackContainer(page.innerStackContainer).setWidgetBuilder((v) {
            return Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
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
                                builder: (c, i, d) => WidgetsFactory.text((d as String).capitalCaseString, color: Util.randomOpaqueColor)
                                    .addPaddingOnly(left: 10, top: 10, bottom: 10),
                              ),
                            ],
                          ).addDefaultTextStyle(),
                        ),
                        // 线条
                        Container(height: 1, color: Colors.grey.withOpacity(0.2)),
                        // 顶部标题
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              WidgetsFactory.text('Sheet', color: Colors.black, fontSize: 14).addDefaultTextStyle(),
                              Positioned(right: 5, child: const Icon(Icons.close).addTapEvent(() => v.hide())),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(flex: 2, child: Container(color: Colors.transparent).addTapEvent(() => v.hide())),
              ],
            );
          }).show();
        });
  }

  static InformationViewTestModel use8(BuildContext context, NormalPageBuildMixin page) {
    return InformationViewTestModel(
        title: 'InformationView用作弹出表单(从左往右弹出)',
        context: context,
        tap: () {
          InformationView(
            type: AnimatedWidgetType.sheetView,
            waitForBuild: true,
            config: AnimatedSheetViewConfig(backgroundColor: Colors.black.withAlpha(75), type: AnimatedSheetType.fromLeftToRight),
          ).inStackContainer(page.outerStackContainer).setWidgetBuilder((v) {
            return Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
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
                                builder: (c, i, d) => WidgetsFactory.text((d as String).capitalCaseString, color: Util.randomOpaqueColor),
                              ),
                              SliverBoxAdapterSection.widget(
                                builder: (_) => AppButton(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                  style: AppButtonStyle.blue,
                                  onTap: () => v.hide(),
                                  child: WidgetsFactory.text('收起', color: Colors.white),
                                ),
                              ),
                            ],
                          ).addDefaultTextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(flex: 1, child: Container(color: Colors.transparent).addTapEvent(() => v.hide())),
              ],
            );
          }).show();
        });
  }

  static InformationViewTestModel use9(BuildContext context, NormalPageBuildMixin page) {
    return InformationViewTestModel(
        title: 'InformationView用作弹出表单(从右往左弹出)',
        context: context,
        tap: () {
          InformationView(
            type: AnimatedWidgetType.sheetView,
            waitForBuild: true,
            config: AnimatedSheetViewConfig(backgroundColor: Colors.black.withAlpha(75), type: AnimatedSheetType.fromRightToLeft),
          ).inStackContainer(page.innerStackContainer).setWidgetBuilder((v) {
            return Row(
              children: [
                Flexible(flex: 5, child: Container(color: Colors.transparent).addTapEvent(() => v.hide())),
                Flexible(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
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
                                builder: (c, i, d) => WidgetsFactory.text((d as String).capitalCaseString, color: Util.randomOpaqueColor),
                              ),
                            ],
                          ).addDefaultTextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).show();
        });
  }
}
