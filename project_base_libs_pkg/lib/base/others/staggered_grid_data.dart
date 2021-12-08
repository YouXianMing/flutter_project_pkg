import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

abstract class StaggeredGridData {
  /// (abstract) 数据
  dynamic get data;
  set data(dynamic val);

  /// (abstract) SliverStaggeredGrid.countBuilder需要的数据
  StaggeredTile get tile;
}

/// 用于非标准瀑布流(控件的宽度可以不一致)
class StaggeredGridCountData extends StaggeredGridData {
  @override
  dynamic data;

  @override
  StaggeredTile get tile => _tile;
  late StaggeredTile _tile;

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
    _tile = StaggeredTile.count(crossAxisCellCount, mainAxisCellCount);
    return this;
  }

  StaggeredGridCountData(int crossAxisCellCount, double mainAxisCellCount, {this.data}) {
    _crossAxisCellCount = crossAxisCellCount;
    _mainAxisCellCount = mainAxisCellCount;
    _tile = StaggeredTile.count(crossAxisCellCount, mainAxisCellCount);
  }
}

/// 用于标准瀑布流(所有控件宽度一致)
class StaggeredGridFixedCountData extends StaggeredGridData {
  @override
  dynamic data;

  @override
  StaggeredTile get tile => _tile;
  late StaggeredTile _tile;

  /// 宽高比
  late double _aspectRatio;
  double get aspectRatio => _aspectRatio;

  /// 更新aspectRatio
  StaggeredGridFixedCountData update(double val) {
    _aspectRatio = val;
    _tile = StaggeredTile.count(1, 1 / val);
    return this;
  }

  StaggeredGridFixedCountData(double aspectRatio, {this.data}) {
    _tile = StaggeredTile.count(1, 1 / aspectRatio);
    _aspectRatio = aspectRatio;
  }
}
