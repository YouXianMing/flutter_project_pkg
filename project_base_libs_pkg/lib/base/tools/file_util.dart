import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class FileUtil {
  /// 检测文件夹是否存在
  static Future<bool> checkDirectoryExists(String directoryPath) => Directory(directoryPath).exists();

  /// 检测文件夹是否存在
  static bool checkDirectoryExistsSync(String directoryPath) => Directory(directoryPath).existsSync();

  /// 检测文件是否存在
  static Future<bool> checkFileExists(String filePath) => File(filePath).exists();

  /// 检测文件是否存在
  static bool checkFileExistsSync(String filePath) => File(filePath).existsSync();

  /// 创建文件夹
  static Future<Directory> createDirectory(String directoryPath, {bool recursive = false}) => Directory(directoryPath).create(recursive: recursive);

  /// 存储文本文件(根据FileMode的枚举值判断是否覆盖或者追加)
  static Future<File> writeAsString(String filePath,
          {required String contents, FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) =>
      File(filePath).writeAsString(contents, mode: mode, encoding: encoding, flush: flush);

  /// 读取文本文件
  static Future<String> readAsString(String filePath, {Encoding encoding = utf8}) => File(filePath).readAsString(encoding: encoding);

  /// 读取文本文件
  static String readAsStringSync(String filePath, {Encoding encoding = utf8}) => File(filePath).readAsStringSync(encoding: encoding);

  /// 读取字节文件
  static Future<Uint8List> readAsBytes(String filePath) => File(filePath).readAsBytes();

  /// 读取字节文件
  static Uint8List readAsBytesSync(String filePath) => File(filePath).readAsBytesSync();

  /// 读取字符串行数
  static Future<List<String>> readAsLines(String filePath, {Encoding encoding = utf8}) => File(filePath).readAsLines(encoding: encoding);

  /// 读取字符串行数
  static List<String> readAsLinesSync(String filePath, {Encoding encoding = utf8}) => File(filePath).readAsLinesSync(encoding: encoding);

  /// 删除文件
  static Future<FileSystemEntity> delete(String filePath, {bool recursive = false}) => File(filePath).delete(recursive: recursive);

  /// 删除文件
  static void deleteSync(String filePath, {bool recursive = false}) => File(filePath).deleteSync(recursive: recursive);

  /// 重命名文件
  static Future<File> rename(String filePath, {required String newPath}) => File(filePath).rename(newPath);

  /// 重命名文件
  static File renameSync(String filePath, {required String newPath}) => File(filePath).renameSync(newPath);

  /// 创建文件
  static Future<File> create(String filePath, {bool recursive = false}) => File(filePath).create(recursive: recursive);

  /// 创建文件
  static void createSync(String filePath, {bool recursive = false}) => File(filePath).createSync(recursive: recursive);

  /// 在指定的文件夹里面遍历文件或者文件夹
  static Stream<FileSystemEntity> fileSystemEntitiesInDirectory(String directoryPath, {bool recursive = false, bool followLinks = true}) =>
      Directory(directoryPath).list(recursive: recursive, followLinks: followLinks);
}
