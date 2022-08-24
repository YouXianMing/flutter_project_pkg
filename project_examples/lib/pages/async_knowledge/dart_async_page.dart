import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base/widgets/base_stateful_widget.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/app_widgets.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_examples/app_route_style.dart';

class DartAsyncPage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const DartAsyncPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => DartAsyncPageState();
}

class DartAsyncPageState extends NormalStatefulWidgetState<DartAsyncPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
    context: context,
    title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
  );
  @override
  Widget body(BuildContext context) {
    return const ListItemView(
      cells: [
        ListItemCell(content: 'Dart的事件循环', type: ListItemViewType.title),
        ListItemCell(
          content: '''
一个Dart应用中有一个消息循环和两个队列，一个是event队列，一个是microtask队列。
优先级问题：microtask队列的优先级是最高的，当所有microtask队列执行完之后才会从event队列中读取事件进行执行。
microtask队列中的event，
event队列包含所有的外来事件：I/O，mouse events，drawing events，timers，isolate之间的message等。
一般Future创建的事件是属于event队列的（利用Future.microtask方法例外），所以创建一个Future后，会插入到event队列中，顺序执行。
          ''',
          type: ListItemViewType.info,
        ),
        ListItemCell(content: 'dart_event_queue.jpg', type: ListItemViewType.image),
      ],
    );
  }
}
