import 'package:flutter/material.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext? context, int index, dynamic data);

typedef ReorderableItemWidgetBuilder = Widget Function(BuildContext? context, int index, dynamic data, bool canDrag);
