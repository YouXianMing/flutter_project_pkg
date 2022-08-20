import 'package:get/get.dart';

/// 自动更新的Obx管理器,一般使用在不需要使用响应式的参数,但又需要手动更新组件时的情形,AutoObx需要作为final属性使用才能发挥效果
class AutoObx {
  /// 隐藏属性,用以驱使Obx重新build而使用
  final _obsValue = 0.obs;

  /// 手动调用更新组件(更新_obsValue的值来达到更新Obx的目的)
  void manualUpdate() => _obsValue.value++;

  /// 构建Obx组件
  Obx buildObx(WidgetCallback builder) => Obx(() {
        _obsValue.value;
        return builder();
      });
}
