import 'dart:async';
import 'dart:io';
import 'package:example/page_route/page_arguments.dart';
import 'package:example/page_route/page_route_enum.dart';
import 'package:example/pages/base/normal_stateful_widget.dart';
import 'package:example/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

class FilesScanPage extends NormalStatefulWidget {
  final PageArguments? arguments;
  const FilesScanPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => _FilesScanPageState();
}

class _FilesScanPageState extends NormalStatefulWidgetState<FilesScanPage> {
  bool canLoadData = false;
  Completer completer = Completer();
  late ScanFilesTool scanFilesTool;
  late FileInfo fileInfo;

  @override
  void initState() {
    super.initState();

    if (widget.arguments!.arguments == null) {
      Util.delayedMilliseconds(900, () async {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;

        scanFilesTool = ScanFilesTool(directoryPath: appDocPath);
        scanFilesTool.startScanFiles().then((value) {
          if (value != null) {
            fileInfo = value;
            canLoadData = true;
            completer.complete();
            setState(() {});
          }
        });
      });
    } else {
      fileInfo = widget.arguments!.arguments! as FileInfo;
      completer.complete();
      canLoadData = true;
    }
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return NormalAppBar(context: context, title: NormalAppBar.titleWidget(canLoadData ? fileInfo.basename! : ''));
  }

  @override
  Widget firstTimeLoadingWidgetStartLoading(BuildContext context) {
    if (canLoadData) {
      return firstTimeLoadingWidget.setDone();
    } else {
      return firstTimeLoadingWidget.listenFuture(() => completer.future);
    }
  }

  @override
  Widget body(BuildContext context) {
    return canLoadData
        ? CustomScrollView(
            slivers: [
              SliverListSection.builderTypeWidget(
                items: fileInfo.subFiles,
                builder: (c, i, d) {
                  FileInfo file = d;
                  return Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('[${file.level}] ${file.basename!}'),
                        file.isDirectory ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blueAccent) : const SizedBox(),
                      ],
                    ),
                  ).addTapEvent(() {
                    if (file.isDirectory) {
                      PageRouteEnum.fileScan.push(context, arguments: PageArguments(arguments: file));
                    }
                  });
                },
              ),
            ],
          )
        : const SizedBox();
  }
}
