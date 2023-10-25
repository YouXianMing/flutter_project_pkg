import 'dart:async';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/route/page_route_enum.dart';
import 'package:project_examples/file_headers.dart';

class FilesScanPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const FilesScanPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => FilesScanPageState();
}

class FilesScanPageState extends NormalStatefulWidgetState<FilesScanPage> {
  /// 是否可以加载数据
  bool _canLoadData = false;

  /// completer
  final Completer _completer = Completer();

  /// 文件扫描工具
  late ScanFilesTool _scanFilesTool;

  /// 根文件
  late FileInfo _fileInfo;

  @override
  void initState() {
    super.initState();

    var file = getSafeT<FileInfo>(widget.arguments?.params?['file']);
    if (file == null) {
      _eventScanFiles();
    } else {
      _fileInfo = file;
      _completer.complete();
      _canLoadData = true;
    }
  }

  Future<void> _eventScanFiles() async {
    // 创建几个文件夹
    await FilesManager.init();
    FilesManager.createDirectoriesAtDocumentsIfNotExist(
      relativePaths: [
        'caches/images/0',
        'caches/.files',
        'tmp/files',
      ],
    );

    Util.delayedMilliseconds(900, () async {
      _scanFilesTool = ScanFilesTool(directoryPath: FilesManager.documentsPath);
      _scanFilesTool.startScanFiles().then((value) {
        if (value != null) {
          _fileInfo = value;
          _canLoadData = true;
          _completer.complete();
          setState(() {});
        }
      });
    });
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget firstTimeLoadingWidgetStartLoading(BuildContext context) =>
      _canLoadData ? firstTimeLoadingWidget.setDone() : firstTimeLoadingWidget.listenFuture(() => _completer.future);

  @override
  Widget body(BuildContext context) {
    return _canLoadData
        ? CustomScrollView(
            slivers: [
              SliverListSection.builderTypeWidget(
                items: _fileInfo.subFiles,
                builder: (c, i, d) {
                  FileInfo file = d;
                  return OpacityButtonWidget(
                    padding: const EdgeInsets.all(15),
                    color: Colors.white,
                    onTap: () {
                      if (file.isDirectory) {
                        PageRouteEnum.filesScanPage.push(
                          context,
                          arguments: PageArguments(params: {'file': file, 'title': file.basename}),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('[${file.level}] ${file.basename!}'),
                        file.isDirectory ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blueAccent) : const SizedBox(),
                      ],
                    ),
                  );
                },
              ),
            ],
          )
        : const SizedBox();
  }
}
