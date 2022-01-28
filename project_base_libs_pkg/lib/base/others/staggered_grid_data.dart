import 'package:project_base_libs_pkg/base/third_libs_mod/staggered_grid_view_0_4_0/mod_staggered_tile.dart';

abstract class StaggeredGridData {
  /// (abstract) 数据
  dynamic get data;
  set data(dynamic val);

  /// (abstract) SliverStaggeredGrid.countBuilder需要的数据
  ModStaggeredTile get tile;
}

/// 用于非标准瀑布流(控件的宽度可以不一致)
class StaggeredGridCountData extends StaggeredGridData {
  @override
  dynamic data;

  @override
  ModStaggeredTile get tile => _tile;
  late ModStaggeredTile _tile;

  /// 横向cell个数
  late int _crossAxisCellCount;
  int get crossAxisCellCount => _crossAxisCellCount;

  /// 纵向cell比例
  late double _mainAxisCellCount;
  double get mainAxisCellCount => _mainAxisCellCount;

  /// 更新crossAxisCellCount与mainAxisCellCount
  StaggeredGridCountData update(int crossAxisCellCount, double mainAxisCellCount) {
    _crossAxisCellCount = crossAxisCellCount;
    _mainAxisCellCount = mainAxisCellCount;
    _tile = ModStaggeredTile.count(crossAxisCellCount, mainAxisCellCount);
    return this;
  }

  StaggeredGridCountData(int crossAxisCellCount, double mainAxisCellCount, {this.data}) {
    _crossAxisCellCount = crossAxisCellCount;
    _mainAxisCellCount = mainAxisCellCount;
    _tile = ModStaggeredTile.count(crossAxisCellCount, mainAxisCellCount);
  }
}

/// 用于标准瀑布流(所有控件宽度一致)
class StaggeredGridFixedCountData extends StaggeredGridData {
  @override
  dynamic data;

  @override
  ModStaggeredTile get tile => _tile;
  late ModStaggeredTile _tile;

  /// 宽高比
  late double _aspectRatio;
  double get aspectRatio => _aspectRatio;

  /// 更新aspectRatio
  StaggeredGridFixedCountData update(double val) {
    _aspectRatio = val;
    _tile = ModStaggeredTile.count(1, 1 / val);
    return this;
  }

  StaggeredGridFixedCountData(double aspectRatio, {this.data}) {
    _tile = ModStaggeredTile.count(1, 1 / aspectRatio);
    _aspectRatio = aspectRatio;
  }
}
