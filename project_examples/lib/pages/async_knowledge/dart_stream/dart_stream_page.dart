import 'dart:async';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/widgets/app_widgets.dart';
import 'package:project_examples/file_headers.dart';

class DartStreamPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const DartStreamPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => DartStreamPageState();
}

class DartStreamPageState extends NormalStatefulWidgetState<DartStreamPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    // https://www.dartcn.com/articles/libraries/broadcast-streams
    // https://www.dartcn.com/tutorials/language/streams
    // https://zhuanlan.zhihu.com/p/63876241
    // https://juejin.cn/post/6844903897681625101
    // https://medium.com/flutter-community/flutter-stream-basics-for-beginners-eda23e44e32f
    // https://wizardforcel.gitbooks.io/gsyflutterbook/content/Flutter-11.html
    // https://www.jianshu.com/p/ed05b6b986c3
    return ListItemView(
      cells: [
        const ListItemCell(content: 'Stream', type: ListItemViewType.title),
        const ListItemCell(
          content:
              'Stream就像一个管道,你从管道的一头发送数据,管道的另一头的监听者就能收到数据.一个Stream可以拥有多个监听者(广播),也可以只拥有一个监听者(单个监听),他们都能收到从管道一头发出的同样的数据,你可以通过使用StreamController来控制Stream发送数据.',
          type: ListItemViewType.info,
        ),
        const ListItemCell(content: 'Single-Subscription vs. Broadcast Streams.png', type: ListItemViewType.image),
        const ListItemCell(content: 'Stream的类方法', type: ListItemViewType.title),
        ListItemCell(
            content: '[factory 单订阅流] Stream.fromIterable\n将数组元素当成数据发送出去',
            onTap: (_) {
              Stream.fromIterable([1, 2, 3, 4, 5, 6]).listen(
                (event) async {
                  var value = await Future.delayed(const Duration(seconds: 1), () => Future.value(event));
                  appPrint(value);
                },
                onDone: () => appPrint('Stream事件结束'),
              );
            }),
        ListItemCell(
            content: '[factory 单订阅流] Stream.periodic\n周期性事件流',
            onTap: (_) {
              innerLoading.show();
              Stream<int> streamData = Stream<int>.periodic(
                const Duration(seconds: 1),
                (data) => data + 1,
              );
              streamData.take(5).listen((event) {
                appPrint('Stream.periodic -> $event');
              }).onDone(() {
                appPrint('Stream.periodic -> done 结束');
                innerLoading.hide();
              });
            }),
        ListItemCell(
            content: '[factory 单订阅流] Stream.fromFuture\n监听一个Future事件',
            onTap: (_) {
              innerLoading.show();

              // 创建Stream
              Stream<String> stream = Stream.fromFuture(
                  Future.delayed(const Duration(seconds: 3), () => Util.randomBool == true ? Future.value('结果') : Future.error('错误')));

              // 开始订阅
              StreamSubscription subscription = stream.listen(
                (data) => showMessage(context, data),
                onError: (e) => showMessage(context, e.toString(), success: false),
                onDone: () => appPrint('Stream事件结束'),
              );

              Future.delayed(const Duration(seconds: 5), () {
                // 结束订阅
                subscription.cancel().then((value) => appPrint('结束订阅'));
                innerLoading.hide();
              });
            }),
        ListItemCell(
            content: '[factory 单订阅流] Stream.fromFutures\n监听多个Future事件,与Future.wait类似,但可以单独接收每一个Future返回的事件',
            onTap: (_) {
              innerLoading.show();
              // 创建Stream
              Stream<String> stream = Stream.fromFutures([
                Future.delayed(const Duration(seconds: 2), () => '结果1'),
                Future.delayed(const Duration(seconds: 4), () => throw AssertionError('异常1')),
                Future.delayed(const Duration(seconds: 6), () => '结果3'),
                Future.delayed(const Duration(seconds: 8), () => throw AssertionError('异常2')),
              ]);

              StreamSubscription subscription = stream.listen(
                (data) => showMessage(context, data, duration: const Duration(seconds: 1)),
                onError: (e) =>
                    showMessage(context, (e as AssertionError).message.toString(), duration: const Duration(seconds: 1), success: false),
                onDone: () => innerLoading.hide(),
              );

              Future.delayed(const Duration(seconds: 10), () {
                // 结束订阅
                subscription.cancel().then((value) => appPrint('结束订阅'));
                innerLoading.hide();
              });
            }),
        const ListItemCell(content: 'Stream的方法', type: ListItemViewType.title),
        ListItemCell(
            content: '[func] take\n发送指定书目的数据(如果不够,则全部发送)',
            onTap: (_) {
              List list = Util.randomBool ? ['1'] : ['1', '2', 3, '4', '5'];
              Stream.fromIterable(list).take(3).listen((event) => appPrint(event), onDone: () => appPrint('结束'));
            }),
        ListItemCell(
            content: '[func] takeWhile\n通过takeWhile里面返回false来结束监听',
            onTap: (_) {
              Stream.fromIterable(
                ['1', '2', 3, '4', '5'],
              ).takeWhile((element) {
                if (element is int && element == 3) {
                  return false;
                } else {
                  return true;
                }
              }).listen((event) => appPrint(event), onDone: () => appPrint('结束'));
            }),
        ListItemCell(
            content: '[func] where\nwhere用于在当前Stream中创建一个新的Stream用来丢弃不符合test的数据,类似于数据过滤.where可以设置多次',
            onTap: (_) {
              Stream.fromIterable(
                ['1', '2', 3, '4', '5'],
              )
                  .where(
                    (event) => event is String,
                  )
                  .where(
                    (event) => event != '5',
                  )
                  .listen(
                    (event) => appPrint(event),
                    onDone: () => appPrint('结束'),
                  );
            }),
        ListItemCell(
            content: '[func] distinct\n相邻数据去重',
            onTap: (_) {
              Stream.fromIterable(
                ['1', '1', 2, '3', '3', '1'],
              ).distinct().listen(
                    (event) => appPrint(event),
                    onDone: () => appPrint('结束'),
                  );
            }),
        ListItemCell(
            content: '[func] skip\n跳过指定个数的数据,从第一个开始',
            onTap: (_) {
              Stream.fromIterable(
                ['1', '2', 3, '4', '5'],
              ).skip(4).listen(
                    (event) => appPrint(event),
                    onDone: () => appPrint('结束'),
                  );
            }),
        ListItemCell(
            content: '[func] skipWhile\n跳过数据,直到找到了不符合条件的数据(后续不跳过)',
            onTap: (_) {
              // 3不是字符串,所以返回了false,后续开始监听
              Stream.fromIterable(
                ['1', '2', 3, '4', '5'],
              ).skipWhile((element) => element is String).listen(
                    (event) => appPrint(event),
                    onDone: () => appPrint('结束'),
                  );
            }),
        ListItemCell(
            content: '[func] map\n对数据进行映射加工',
            onTap: (_) {
              Stream.fromIterable(
                ['1', '2', '3', '4', '5'],
              ).map((event) => '$event->String').listen(
                    (event) => appPrint(event),
                    onDone: () => appPrint('结束'),
                  );
            }),
        ListItemCell(
            content: '[func] expand\n返回迭代器来扩展数据',
            onTap: (_) {
              Stream.fromIterable(
                ['1', '2', 3, '4', '5'],
              ).expand(
                (v) {
                  if (v is int) {
                    return Iterable.generate(1, (t) => v);
                  } else {
                    return Iterable.generate(2, (t) => v);
                  }
                },
              ).listen(
                (event) => appPrint(event),
                onDone: () => appPrint('结束'),
              );
            }),
        ListItemCell(content: '[func] length\n监听订阅事件结束后，符合条件的数量', onTap: (_) => _streamOperation(1)),
        ListItemCell(content: '[func] isEmpty\n判断Stream是否为空', onTap: (_) => _streamOperation(2)),
        ListItemCell(content: '[func] isBroadcast\n判断Stream是否是广播', onTap: (_) => _streamOperation(3)),
        ListItemCell(content: '[func] first\n获取第一个符合条件的事件', onTap: (_) => _streamOperation(4)),
        ListItemCell(content: '[func] last\n获取最后一个符合条件的事件', onTap: (_) => _streamOperation(5)),
        ListItemCell(content: '[func] toList\n获取符合条件事件的数组', onTap: (_) => _streamOperation(6)),
        ListItemCell(content: '[func] toSet\n获取符合条件事件的集合', onTap: (_) => _streamOperation(7)),
        const ListItemCell(content: 'StreamController', type: ListItemViewType.title),
        const ListItemCell(
            content:
                'StreamController实现了StreamSink的相关方法如add,addError,close.因为StreamController在listen之前就与Stream产生关联,所以EventSource可以在StreamController进行缓存,直到listen开始.',
            type: ListItemViewType.info),
        const ListItemCell(content: 'listen-with-controller.png', type: ListItemViewType.image),
        ListItemCell(
            content: '[factory 广播] StreamController.broadcast\n创建广播类型的Stream',
            onTap: (_) {
              innerLoading.show();
              StreamController controller = StreamController.broadcast();

              // 订阅者1
              StreamSubscription subscription = controller.stream.listen(
                (event) => appPrint(event),
                onError: (e) => appPrint(e.toString()),
                onDone: () => appPrint('Stream事件结束'),
              );

              // 订阅者2
              controller.stream.listen(
                (event) => appPrint(event),
                onError: (e) => appPrint(e.toString()),
                onDone: () => appPrint('Stream事件结束'),
              );

              Future.delayed(const Duration(seconds: 1), () {
                // 发送广播
                Util.randomBool == true ? controller.add('事件1') : controller.addError('错误');
              });

              Future.delayed(const Duration(seconds: 2), () {
                // 订阅者1暂停接收数据
                subscription.pause();

                // 发送广播
                Util.randomBool == true ? controller.add('事件2') : controller.addError('错误');
              });

              Future.delayed(const Duration(seconds: 3), () {
                subscription.cancel();
                controller.close().then((_) => appPrint('stream已关闭'));
                innerLoading.hide();
              });
            }),
      ],
    );
  }

  void _streamOperation(index) async {
    List values = [1, 1, 2, 3, 4, 5, 6, 7, 7, 8, 9, 10, 11, 12];
    Stream<dynamic> stream =
        Stream.periodic(const Duration(milliseconds: 50), (index) => values[index]).take(10).skipWhile((element) => element < 7);

    switch (index) {
      case 1:
        var length = await stream.length;
        appPrint('Stream.length -> $length');
        break;
      case 2:
        var isEmpty = await stream.isEmpty;
        appPrint('Stream.isEmpty -> $isEmpty');
        break;
      case 3:
        var isBroadcast = stream.isBroadcast;
        appPrint('Stream.isBroadcast -> $isBroadcast');
        break;
      case 4:
        var first = await stream.first;
        appPrint('Stream.first -> $first');
        break;
      case 5:
        var last = await stream.last;
        appPrint('Stream.last -> $last');
        break;
      case 6:
        var toList = await stream.toList();
        appPrint('Stream.toList -> $toList');
        break;
      case 7:
        var toSet = await stream.toSet();
        appPrint('Stream.toList -> $toSet');
        break;
    }
  }
}
