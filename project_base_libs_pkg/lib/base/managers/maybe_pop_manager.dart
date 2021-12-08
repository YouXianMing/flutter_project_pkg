///
/// 需要结合WillPopScope使用,是一个单例,用以响应物理返回键的工具类
///
class MaybePopManager {
  /// --------------
  /// 单例相关操作
  /// --------------

  static MaybePopManager? _popManager;

  /// 构造方法创建单例
  factory MaybePopManager() => getInstance;

  /// 私有构造方法
  MaybePopManager._internal() {
    maybePopItems = [];
  }

  static MaybePopManager get getInstance {
    _popManager ??= MaybePopManager._internal();
    return _popManager!;
  }

  /// --------------
  /// 属性与方法
  /// --------------

  /// 管理MaybePopMixin的数组
  late List<MaybePopMixin> maybePopItems;

  /// 添加到maybePopItems数组中
  void addMaybePopItem(MaybePopMixin item) => maybePopItems.add(item);

  /// 从maybePopItems数组中移除
  void removeMaybePopItem(MaybePopMixin? popMixin) => maybePopItems.remove(popMixin);

  /// 判断当前能否pop
  bool? canPop() {
    bool? canPop;

    /// 获取最后一个弹出框来判断能否pop
    if (maybePopItems.isNotEmpty) {
      canPop = maybePopItems.last.pageMaybePop();
    }
    return canPop;
  }
}

mixin MaybePopMixin {
  /// (abstract) 当前页面能否执行pop操作,由mixin的实体来实现具体的业务逻辑
  bool? pageMaybePop();

  /// 由mixin的实体来执行此方法,show的时候添加到MaybePopManager中被其托管
  void addToMaybePopManager() => MaybePopManager.getInstance.addMaybePopItem(this);

  /// 由mixin的实体来执行此方法,hide之后从MaybePopManager中移除MaybePopMixin对象
  void removeFromMaybePopManager() => MaybePopManager.getInstance.removeMaybePopItem(this);
}
