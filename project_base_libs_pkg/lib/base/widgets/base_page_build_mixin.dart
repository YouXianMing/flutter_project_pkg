import 'package:flutter/material.dart';

mixin BasePageBuildMixin {
  /// (abstract) 获取首次加载数据的控件,如果需要加载网络请求,需要重写该方法
  Widget firstTimeLoadingWidgetStartLoading(BuildContext context);

  /// (abstract) 内部的stackContainer
  Widget innerStackContainerWidget(BuildContext context);

  /// (abstract) 内部的Loading控件
  Widget innerLoadingWidget(BuildContext context);

  /// (abstract) 外部的stackContainer
  Widget outerStackContainerWidget(BuildContext context);

  /// (abstract) 外部的Loading控件
  Widget outerLoadingWidget(BuildContext context);

  /// (overwrite) 背景控件
  Widget backgroundWidget(BuildContext context) => Container(color: Colors.transparent);

  /// (abstract) appBar
  PreferredSizeWidget? appBar(BuildContext context);

  /// (abstract) body
  Widget body(BuildContext context);

  /// (overwrite) 是否使用WillPopScope,默认使用(iOS使用后会导致侧滑返回失效)
  bool useWillPopScope(BuildContext context) => true;

  ///  WillPopScope方法会调用此方法,返回上一级
  Future<bool> canPopBack(BuildContext context) => Future.value(true);

  /// 检查是否可以pop,只有返回了Future<bool>才有效(在canPopBack调用之前先拦截下)
  Future<dynamic>? checkWillPop(BuildContext context) => null;

  ///  直接返回上一级
  void pop(BuildContext context, {dynamic result}) => Navigator.of(context).pop(result);

  /// 调用此方法会会触发WillPopScope中的onWillPop方法调用(如果当前页面设置了WillPopScope),不要在canPopBack方法中调用此方法,否则会导致死循环
  Future<bool> maybePop<T extends Object?>(BuildContext context, [T? result]) => Navigator.of(context).maybePop();

  /// 隐藏键盘
  void hideKeyBoard(BuildContext context) => FocusScope.of(context).requestFocus(FocusNode());

  /// 获取当前的context
  /// 注意: 只在BaseStatefulWidgetState中进行重写,根据mounted来判断是否返回context
  BuildContext? get currentContext => null;

  /// 根控件
  Widget buildRootWidget(BuildContext context) {
    return Stack(
      children: [
        useWillPopScope(context) == true
            ? WillPopScope(
                onWillPop: () async {
                  // 检查是否可以pop,只有返回了Future<bool>才有效(在canPopBack调用之前先拦截下)
                  var willPop = checkWillPop(context);
                  if (willPop != null) {
                    dynamic value = await willPop;
                    if (value is bool) {
                      return Future.value(value);
                    }
                  }

                  return canPopBack(context);
                },
                child: buildMainWidget(context))
            : buildMainWidget(context),
        outerStackContainerWidget(context),
        outerLoadingWidget(context),
      ],
    );
  }

  /// 主控件
  Widget buildMainWidget(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context),
      body: Stack(
        children: [
          backgroundWidget(context),
          body(context),
          innerStackContainerWidget(context),
          firstTimeLoadingWidgetStartLoading(context),
          innerLoadingWidget(context),
        ],
      ),
    );
  }
}
