import 'dart:async';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

class FileInfo {
  // 父母
  FileInfo? parent;

  // 是否是文件夹
  final bool isDirectory;

  // 文件路径
  String path;

  // 子文件目录
  List<FileInfo> subFiles = [];

  // 文件名字,带扩展名
  String? basename;

  // 文件名字,不带扩展名
  String? basenameWithoutExtension;

  // 扩展名
  String? extension;

  // 所处文件夹名字
  String? dirname;

  // 元数据信息
  String? get mimeInfo => lookupMimeType(path);

  // 所处文件夹层级
  int? level;

  FileInfo({required this.isDirectory, required this.path}) {
    basename = p.basename(path);
    basenameWithoutExtension = p.basenameWithoutExtension(path);
    extension = p.extension(path);
    dirname = p.dirname(path);
  }

  @override
  String toString() => '${isDirectory ? '[D]' : '[F]'} ${basename ?? ''}';

  // 通过递归的方式获取所有的子文件或者子文件夹
  List<FileInfo> get allSubFiles {
    List<FileInfo> list = [];
    _storeSubFiles(this, list);
    return list;
  }

  void _storeSubFiles(FileInfo fileInfo, List<FileInfo> list) {
    if (fileInfo.isDirectory) {
      list.addAll(fileInfo.subFiles);
      for (var file in fileInfo.subFiles) {
        if (file.isDirectory) {
          _storeSubFiles(file, list);
        }
      }
    }
  }
}

class ScanFilesTool {
  // 文件夹路径
  final String directoryPath;

  // 是否正在扫描当中
  bool get isScanning => _isScanning;
  bool _isScanning = false;

  // 阻塞时间
  final Duration blockingTime;

  // future阻塞
  Completer? _completer;

  // 确保所有的startScan的递归调用都执行完了
  Timer? _timer;

  ScanFilesTool({required this.directoryPath, this.blockingTime = const Duration(milliseconds: 250)});

  // 开始扫描文件(如果目标地址不是文件夹,则返回空数组)
  // depth为扫描深度,默认为无限深度
  Future<FileInfo?> startScanFiles({int? depth}) async {
    Directory directory = Directory(directoryPath);
    bool exist = directory.existsSync();

    // 如果是文件夹,则开始扫描
    if (exist == true) {
      _isScanning = true;
      FileInfo rootFileInfo = FileInfo(isDirectory: true, path: directoryPath);
      _completer = Completer();
      _startScan(rootFileInfo: rootFileInfo, depth: depth, level: 0);

      // 开始阻塞
      await _completer!.future;
      _isScanning = false;
      return rootFileInfo;
    }
  }

  // 开始递归调用查找文件
  Future _startScan({required FileInfo rootFileInfo, int? depth, required level}) async {
    if (_timer != null) _timer!.cancel();
    // 解除阻塞
    _timer = Timer(blockingTime, () => _completer!.complete());

    // 如果是文件夹
    if (rootFileInfo.isDirectory) {
      // 遍历文件夹
      Directory directory = Directory(rootFileInfo.path);
      await directory.list().forEach((element) async {
        // 检测是否是文件
        var file = File(element.path);
        if (file.existsSync()) {
          FileInfo fileInfo = FileInfo(isDirectory: false, path: element.path);
          fileInfo.parent = rootFileInfo;
          fileInfo.level = level;
          rootFileInfo.subFiles.add(fileInfo);
        } else {
          // 检测是否是文件夹
          var dir = Directory(element.path);
          if (dir.existsSync()) {
            FileInfo fileInfo = FileInfo(isDirectory: true, path: dir.path);
            fileInfo.parent = rootFileInfo;
            fileInfo.level = level;
            rootFileInfo.subFiles.add(fileInfo);

            if (depth != null) {
              if (depth > 1) await _startScan(rootFileInfo: fileInfo, depth: depth - 1, level: level + 1);
            } else {
              await _startScan(rootFileInfo: fileInfo, level: level + 1);
            }
          }
        }
      });
    }
  }
}
