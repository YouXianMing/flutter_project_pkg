import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:project_base_libs_pkg/base/tools/file_util.dart';
import 'package:path/path.dart' as path;
import 'package:project_base_libs_pkg/base_file_headers.dart';

class FilesManager {
  /// 初始化标记
  static bool _didInitialized = false;

  /// Documents文件夹
  static late Directory _documentsDirectory;

  /// 初始化操作
  static Future<void> init() async {
    _didInitialized = true;
    _documentsDirectory = await getApplicationDocumentsDirectory();
  }

  /// 在Documents目录根据提供的相对路径创建多个文件夹
  /// relativePaths: 相对路径文件夹数组,注意:第一个字母不能含有/,例如 ['caches/images', 'caches/.files']
  static Future<void> createDirectoriesAtDocumentsIfNotExist({required List<String> relativePaths}) async {
    if (_didInitialized == false) throw Exception('AppFilesManager 必须先初始化后再使用');
    await Future.forEach<String>(relativePaths, (value) async {
      // 拼接路径
      String dirPath = path.join(_documentsDirectory.path, value);

      // 判断是否存在,不存在则创建文件夹
      bool exist = await FileUtil.checkDirectoryExists(dirPath);
      if (exist == false) await FileUtil.createDirectory(dirPath, recursive: true);
    });
  }

  /// 在Documents目录中创建File
  /// pathComponents: 文件相对路径,注意:第一个字母不能含有/,如 'caches/images' 或者 'caches/.files' 等
  static File createFileAtDocuments({required String relativePath}) {
    if (_didInitialized == false) throw Exception('AppFilesManager 必须先初始化后再使用');
    return File(path.join(_documentsDirectory.path, relativePath));
  }

  /// 获取documents路径
  static String get documentsPath {
    if (_didInitialized == false) throw Exception('AppFilesManager 必须先初始化后再使用');
    return _documentsDirectory.path;
  }
}
