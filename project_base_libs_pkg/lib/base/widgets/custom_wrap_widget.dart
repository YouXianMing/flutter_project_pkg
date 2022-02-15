import 'package:flutter/material.dart';

/// 可是设置显示几行的Wrap自定义控件
class CustomWrapWidget extends StatelessWidget {
  final List<Widget> children;
  final double width;
  final double height;
  final EdgeInsets padding;
  final double spacing;
  final double runSpacing;
  final int maxLines;
  final Color backgroundColor;
  final TextDirection? textDirection;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAlignment;
  final bool clip;
  final Function(CustomWrapWidget)? didFinishPaint;

  const CustomWrapWidget({
    Key? key,
    this.children = const [],
    this.width = double.infinity,
    this.height = double.infinity,
    this.padding = EdgeInsets.zero,
    this.spacing = 0,
    this.runSpacing = 0,
    this.maxLines = 0,
    this.backgroundColor = Colors.transparent,
    this.textDirection,
    this.alignment = WrapAlignment.start,
    this.crossAlignment = WrapCrossAlignment.start,
    this.clip = false,
    this.didFinishPaint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: backgroundColor,
      alignment: Alignment.topLeft,
      child: Flow(
        delegate: CustomWrapDelegate(
          padding: padding,
          spacing: spacing,
          runSpacing: runSpacing,
          maxLines: maxLines,
          alignment: alignment,
          crossAlignment: crossAlignment,
          clip: clip,
          didFinishPaint: didFinishPaint == null ? null : () => didFinishPaint!(this),
          textDirection: textDirection ?? Directionality.of(context),
        ),
        children: children,
      ),
    );
  }
}

class CustomWrapDelegate extends FlowDelegate {
  final EdgeInsets padding;
  final double spacing;
  final double runSpacing;
  final int maxLines;
  final TextDirection textDirection;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAlignment;
  final bool clip;
  final Function()? didFinishPaint;

  CustomWrapDelegate({
    required this.textDirection,
    required this.padding,
    required this.spacing,
    required this.runSpacing,
    required this.maxLines,
    required this.alignment,
    required this.crossAlignment,
    required this.clip,
    this.didFinishPaint,
  });

  @override
  void paintChildren(FlowPaintingContext context) {
    CustomWrapSizeManager wrapSizeManager = CustomWrapSizeManager(
      maxWidth: context.size.width - padding.left - padding.right,
      maxHeight: context.size.height - padding.top - padding.bottom,
      gap: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      crossAlignment: crossAlignment,
      spacing: spacing,
      padding: padding,
      maxLines: maxLines,
      textDirection: textDirection,
      clip: clip,
    ).accessContext(context);

    List<CustomWrapItemInfo> positions = wrapSizeManager.itemPositions;
    for (int i = 0; i < positions.length; i++) {
      context.paintChild(i, transform: Matrix4.translationValues(positions[i].x, positions[i].y, 0.0));
    }

    if (didFinishPaint != null) Future.value().then((value) => didFinishPaint!());
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => oldDelegate != this;
}

class CustomWrapItemInfo {
  final double x;
  final double y;
  CustomWrapItemInfo({required this.x, required this.y});
}

class CustomWrapSizeManager {
  final List<List<Size>> sizesList = [];
  final List<double> allItemsWidthList = [];
  final List<double> maxItemsHeightList = [];
  final double maxWidth;
  final double maxHeight;
  final double gap;
  final EdgeInsets padding;
  final double spacing;
  final double runSpacing;
  final int maxLines;
  final TextDirection textDirection;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAlignment;
  final bool clip;

  CustomWrapSizeManager({
    required this.maxWidth,
    required this.maxHeight,
    required this.gap,
    required this.padding,
    required this.spacing,
    required this.runSpacing,
    required this.textDirection,
    required this.maxLines,
    required this.alignment,
    required this.crossAlignment,
    required this.clip,
  });

  final List<Size> _sizes = [];
  double _offsetX = 0;

  CustomWrapSizeManager accessContext(FlowPaintingContext context) {
    int childCount = context.childCount;
    for (int i = 0; i < childCount; i++) {
      if (_addSize(context.getChildSize(i)!)) break;
    }
    _saveToSizesListAndClearSizes();
    return this;
  }

  List<CustomWrapItemInfo> get itemPositions {
    List<CustomWrapItemInfo> positions = [];

    if (textDirection == TextDirection.ltr) {
      if (alignment == WrapAlignment.start) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double offsetX = padding.left;
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX += sizes[index].width + gap;
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      } else if (alignment == WrapAlignment.end) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double offsetX = padding.left + (maxWidth - allItemsWidthList[line] - (sizes.length - 1) * gap);
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX += sizes[index].width + gap;
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      } else if (alignment == WrapAlignment.center) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double offsetX = padding.left + (maxWidth - allItemsWidthList[line] - (sizes.length - 1) * gap) / 2;
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX += sizes[index].width + gap;
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      } else if (alignment == WrapAlignment.spaceBetween) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double offsetX = padding.left;
          double spaceGap = 0;
          if (sizes.length == 1) {
            spaceGap = 0;
          } else {
            spaceGap = (maxWidth - allItemsWidthList[line]) / (sizes.length - 1);
          }
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX += sizes[index].width + spaceGap;
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      } else if (alignment == WrapAlignment.spaceAround) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double spaceGap = (maxWidth - allItemsWidthList[line]) / sizes.length;
          double offsetX = padding.left + spaceGap / 2;
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX += sizes[index].width + spaceGap;
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      } else if (alignment == WrapAlignment.spaceEvenly) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double spaceGap = (maxWidth - allItemsWidthList[line]) / (sizes.length + 1);
          double offsetX = padding.left + spaceGap;
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX += sizes[index].width + spaceGap;
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      }
    } else if (textDirection == TextDirection.rtl) {
      if (alignment == WrapAlignment.start) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double offsetX = maxWidth + padding.left;
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX - sizes[index].width, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX -= (sizes[index].width + gap);
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      } else if (alignment == WrapAlignment.end) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double offsetX = maxWidth + padding.left - (maxWidth - allItemsWidthList[line] - (sizes.length - 1) * gap);
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX - sizes[index].width, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX -= (sizes[index].width + gap);
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      } else if (alignment == WrapAlignment.center) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double offsetX = maxWidth + padding.left - (maxWidth - allItemsWidthList[line] - (sizes.length - 1) * gap) / 2;
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX - sizes[index].width, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX -= (sizes[index].width + gap);
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      } else if (alignment == WrapAlignment.spaceBetween) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double offsetX = maxWidth + padding.left;
          double spaceGap = 0;
          if (sizes.length == 1) {
            spaceGap = 0;
          } else {
            spaceGap = (maxWidth - allItemsWidthList[line]) / (sizes.length - 1);
          }
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX - sizes[index].width, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX -= (sizes[index].width + spaceGap);
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      } else if (alignment == WrapAlignment.spaceAround) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double spaceGap = (maxWidth - allItemsWidthList[line]) / sizes.length;
          double offsetX = maxWidth + padding.left - spaceGap / 2;
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX - sizes[index].width, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX -= (sizes[index].width + spaceGap);
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      } else if (alignment == WrapAlignment.spaceEvenly) {
        double offsetY = padding.top;
        for (int line = 0; line < sizesList.length; line++) {
          if (shouldBreakWhenClip(offsetY, line)) break;
          List<Size> sizes = sizesList[line];
          double spaceGap = (maxWidth - allItemsWidthList[line]) / (sizes.length + 1);
          double offsetX = maxWidth + padding.left - spaceGap;
          for (int index = 0; index < sizes.length; index++) {
            positions.add(CustomWrapItemInfo(x: offsetX - sizes[index].width, y: _itemOffsetY(offsetY, sizes[index], line)));
            offsetX -= (sizes[index].width + spaceGap);
          }
          offsetY += maxItemsHeightList[line] + runSpacing;
        }
      }
    }

    return positions;
  }

  bool shouldBreakWhenClip(double offsetY, int line) {
    if (clip && ((offsetY - padding.top) + maxItemsHeightList[line] > maxHeight)) {
      return true;
    } else {
      return false;
    }
  }

  bool _addSize(Size size) {
    if (_offsetX + size.width > maxWidth) _saveToSizesListAndClearSizes();
    if (maxLines > 0 && sizesList.length >= maxLines) return true;
    _sizes.add(size);
    _offsetX += size.width + gap;
    return false;
  }

  void _saveToSizesListAndClearSizes() {
    if (_sizes.isNotEmpty) {
      List<Size> tmp = [];
      double allItemsWidth = 0;
      double maxItemsHeight = 0;
      for (var value in _sizes) {
        allItemsWidth += value.width;
        if (maxItemsHeight < value.height) maxItemsHeight = value.height;
        tmp.add(Size(value.width, value.height));
      }
      allItemsWidthList.add(allItemsWidth);
      maxItemsHeightList.add(maxItemsHeight);
      sizesList.add(tmp);
      _sizes.clear();
      _offsetX = 0;
    }
  }

  double _itemOffsetY(double sourceOffsetY, Size size, int line) {
    double itemOffsetY = sourceOffsetY;
    if (crossAlignment == WrapCrossAlignment.start) {
    } else if (crossAlignment == WrapCrossAlignment.center) {
      itemOffsetY += (maxItemsHeightList[line] - size.height) / 2;
    } else if (crossAlignment == WrapCrossAlignment.end) {
      itemOffsetY += maxItemsHeightList[line] - size.height;
    }
    return itemOffsetY;
  }
}
