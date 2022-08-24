import 'package:flutter/material.dart';
import 'package:project_examples/route/page_route_enum.dart';

/// 获取当前的路由名字
String get appCurrentRouting => _appCurrentRouting;

String _appCurrentRouting = '';

/// 记录当前的路由名字
void appRecordCurrentRoutingName(String name) => _appCurrentRouting = name;

/* 路由管理 */

/// 页面基础信息(抽象类)
abstract class BasePageInfo {}

/// 常规页面信息(可以由枚举值直接找到对应的界面)
class NormalPageInfo extends BasePageInfo {
  PageArguments? arguments;
  PageRouteEnum pageRoute;

  NormalPageInfo({required this.pageRoute, this.arguments});
}

/// app路由跳转管理器
Future appRouteTo<T extends BasePageInfo>(BuildContext context, T pageInfo) async {
  // 如果是常规页面信息
  if (pageInfo is NormalPageInfo) {
    return pageInfo.pageRoute.push(context, arguments: pageInfo.arguments);
  }
}

/* 页面参数 */

/// 页面参数
class PageArguments {
  /// 页面参数(基础的参数)
  final Map? params;

  /// 其他参数(可能包含对象啥的)
  final dynamic other;

  const PageArguments({this.params, this.other});
}
