import 'package:flutter/material.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/app_widgets.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_examples/route_style.dart';

class DartFuturePage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const DartFuturePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => DartFuturePageState();
}

class DartFuturePageState extends NormalStatefulWidgetState<DartFuturePage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
    context: context,
    title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
  );
  @override
  Widget body(BuildContext context) {
    return ListItemView(
      cells: [
        const ListItemCell(content: 'Future的方法', type: ListItemViewType.title),
        ListItemCell(
            content: 'Future(() {})\nFuture中包裹的代码会实现异步调用',
            onTap: (_) {
              Future(() => appPrint('1'));
              appPrint('2');
            }),
        ListItemCell(
            content: '[func] then\n通过then来接收Future返回的结果',
            onTap: (_) {
              innerLoading.show();
              Future.delayed(
                const Duration(seconds: 2),
                () => 'Hello world!',
              ).then((data) {
                innerLoading.hide();
                showMessage(context, data);
              });
            }),
        ListItemCell(
            content: '[func] catchError\n通过catchError来捕获异常',
            onTap: (_) {
              innerLoading.show();
              Future.delayed(const Duration(seconds: 2), () {
                if (Util.randomBool == true) {
                  throw AssertionError('Error');
                } else {
                  return 'Hello world!';
                }
              }).then((data) {
                //执行成功会走到这里
                innerLoading.hide();
                showMessage(context, data);
              }).catchError((e) {
                //执行失败会走到这里
                innerLoading.hide();
                showMessage(context, (e as AssertionError).message.toString(), success: false);
              });
            }),
        ListItemCell(
            content: '[func] whenComplete\n无论成功或异常都会走到whenComplete',
            onTap: (_) {
              innerLoading.show();
              Future.delayed(
                const Duration(seconds: 2),
                () => throw AssertionError('Error'),
              ).then((data) {
                //执行成功会走到这里
                appPrint('成功');
              }).catchError((e) {
                //执行失败会走到这里
                appPrint('失败');
              }).whenComplete(() {
                //无论成功或失败都会走到这里
                innerLoading.hide();
                showMessage(context, '无论成功失败都会走whenComplete');
              });
            }),
        ListItemCell(
            content: '[func] timeout\n设置了超时时间后,如果过了超时时间,则返回超时的数据',
            onTap: (_) {
              innerLoading.show();
              Future.delayed(const Duration(seconds: 2), () => '数据')
                  .timeout(Duration(seconds: Util.randomBool == true ? 1 : 3), onTimeout: () => 'Future超时')
                  .then((s) {
                innerLoading.hide();
                showMessage(context, s, success: s == '数据' ? true : false);
              });
            }),
        ListItemCell(
            content: '[factory] Future.microtask\n提高Future执行代码的优先级',
            onTap: (_) {
              Future(() => appPrint('低优先级1'));
              Future(() => appPrint('低优先级2'));
              Future(() => appPrint('低优先级3'));
              Future.microtask(() => appPrint('高优先级'));
            }),
        ListItemCell(
            content: '[factory] Future.delay\n延时操作',
            onTap: (_) {
              innerLoading.show();
              Future.delayed(const Duration(seconds: 1), () => Util.randomBool == true ? Future.value('结果') : Future.error('出错')).then((v) {
                innerLoading.hide();
                showMessage(context, v.toString());
              }).catchError((e) {
                innerLoading.hide();
                showMessage(context, e, success: false);
              });
            }),
        ListItemCell(
            content: '[factory] Future.value\n如果value值为普通值,通过then接收会立即返回普通值;如果value是Future对象,则then接收的是Future对象的值',
            onTap: (_) {
              dynamic randomValue = Util.randomObjectFromList([
                '数据',
                Future.delayed(const Duration(seconds: 1), () => '任务1结束'),
                Future.delayed(const Duration(seconds: 1), () => Future.error('任务2报错')),
              ]);

              innerLoading.show();
              Future.value(randomValue).then((v) {
                innerLoading.hide();
                showMessage(context, v as String);
              }).catchError((e) {
                innerLoading.hide();
                showMessage(context, e.toString(), success: false);
              });
            }),
        ListItemCell(
            content: '[factory] Future.sync\n如果值是普通值,则返回Future.value对普通值进行包裹;如果是Future对象,则直接返回该对象',
            onTap: (_) {
              dynamic randomValue = Util.randomObjectFromList([
                '数据',
                Future.delayed(const Duration(seconds: 1), () => '任务1结束'),
                Future.delayed(const Duration(seconds: 1), () => Future.error('任务2报错')),
              ]);

              innerLoading.show();
              Future.sync(() => randomValue).then((v) {
                innerLoading.hide();
                showMessage(context, v);
              }).catchError((e) {
                innerLoading.hide();
                showMessage(context, e.toString(), success: false);
              });
            }),
        ListItemCell(
            content: '[factory] Future.error\n手动创建一个会抛出异常的Future',
            onTap: (_) {
              innerLoading.show();
              Future.error('异常').then((v) {
                innerLoading.hide();
                showMessage(context, v);
              }).catchError((e) {
                innerLoading.hide();
                showMessage(context, e.toString(), success: false);
              });
            }),
        const ListItemCell(content: 'Future的类方法', type: ListItemViewType.title),
        ListItemCell(content: '[static] Future.forEach\n配合await与async将迭代器中有限的元素按照顺序进行处理', onTap: (_) => _forEachExample()),
        ListItemCell(
            content: '[static] Future.doWhile\n配合await与async进行while循环操作,直到返回false',
            onTap: (_) {
              _doWhileExample();
            }),
        ListItemCell(
            content: '[static Future<List<T>>] Future.wait\n等待多个异步任务都执行结束后才进行一些操作',
            onTap: (_) {
              innerLoading.show();
              Future.wait([
                Future.delayed(const Duration(seconds: 1), () => '数据1 '),
                Future.delayed(const Duration(seconds: 2), () => '数据2 '),
                Future.delayed(const Duration(seconds: 3), () => Util.randomBool == true ? '数据3' : throw AssertionError('数据3异常')),
              ]).then((results) {
                innerLoading.hide();
                showMessage(context, results[0] + results[1] + results[2]);
              }).catchError((e) {
                showMessage(context, e.toString(), success: false);
                innerLoading.hide();
              });
            }),
        ListItemCell(
            content: '[static Future<List<T>>] Future.any\n多个异步任务,通过then接收最早执行完的一个future',
            onTap: (_) {
              innerLoading.show();
              Future.any([
                Future.delayed(const Duration(seconds: 2), () => '任务1结束'),
                Future.delayed(Duration(seconds: Util.randomBool == true ? 1 : 3), () => throw AssertionError('任务2异常')),
              ]).then((value) {
                showMessage(context, value);
                innerLoading.hide();
              }).catchError((e) {
                showMessage(context, (e as AssertionError).message.toString(), success: false);
                innerLoading.hide();
              });
            }),
      ],
    );
  }

  void _forEachExample() async {
    innerLoading.show();

    List<int> lists = [1, 2, 3, 4, 5, 6];
    List<int> output = [];
    await Future.forEach(lists, (value) async {
      int result = await _someAsync();
      appPrint('输入值:$value 结果:$result');
      output.add(result);
    });
    appPrint(output);
    innerLoading.hide();
    if (mounted) showMessage(context, output.toString());
  }

  void _doWhileExample() async {
    innerLoading.show();

    int count = 0;
    List<int> output = [];
    await Future.doWhile(() async {
      if (count++ == 8) {
        return false;
      } else {
        int result = await _someAsync();
        appPrint('结果$result');
        output.add(result);
        return true;
      }
    });

    appPrint(output);
    innerLoading.hide();
    if (mounted) showMessage(context, output.toString());
  }

  Future<int> _someAsync() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Util.randomInt(max: 6);
  }
}
