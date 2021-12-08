extension IterableUtils<E> on Iterable<E> {
  /// Similar to Iterable.forEach() but:
  /// - with an index argument
  /// - with the optional capacity to break the loop, returning false
  /// - Note: as for the return clause, you can omit it, as with forEach()
  void forEachIndexed(Function(E element, int index) f) {
    int index = 0;
    for (E element in this) {
      if (f(element, index) == false) break;
      index++;
    }
  }
}

/// 将垂直方向上的girdView的数据源转换成水平方向上显示的数据源专用data数据
class HorizontalGridData {
  /// 数据
  final dynamic data;

  /// 是否是占位数据
  final bool isPlaceHolder;

  /// 构造函数
  HorizontalGridData({this.data, required this.isPlaceHolder});
}

extension HorizontalGridDataExt on List {
  /// 将垂直方向上的girdView的数据源转换成水平方向上显示的数据源
  /// - 如将下列左侧排序方式转化为右侧排序方式(不足的地方补上占位数据)
  /// - 01, 04, 07, 10, 13    01, 02, 03, 04, 05,
  /// - 02, 05, 08, 11,    => 06, 07, 08, 09, 10,
  /// - 03, 06, 09, 12        11, 12, 13, [占], [占]
  /// - verticalCrossAxisCount表示垂直方向上的列,此处代表5
  List<HorizontalGridData> transformVerticalGridDatasToHorizontalGridDatas(int verticalCrossAxisCount) {
    int line = (length / verticalCrossAxisCount).ceil();

    List<List> arrays = [];
    for (int i = 0; i < verticalCrossAxisCount; i++) {
      arrays.add([]);
    }
    for (int i = 0; i < length; i++) {
      arrays[i % verticalCrossAxisCount].add(this[i]);
    }

    List<HorizontalGridData> gridDataList = [];
    for (int i = 0; i < verticalCrossAxisCount; i++) {
      for (int j = 0; j < line; j++) {
        if (arrays[i].length > j) {
          gridDataList.add(HorizontalGridData(isPlaceHolder: false, data: arrays[i][j]));
        } else {
          gridDataList.add(HorizontalGridData(isPlaceHolder: true));
        }
      }
    }

    return gridDataList;
  }
}
