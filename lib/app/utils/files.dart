import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManage {

  ///
  /// 读取文件数据
  ///
  static Future<List<String>> readFile(String filePath) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filePath');
    if (file.existsSync()) {
      List<String> lines = file.readAsLinesSync();
      return lines;
    }

    return [];
  }

  ///
  /// 删除文件
  ///
  static Future removeFile(String filePath) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filePath');
    if (file.existsSync()) {
      file.delete();
    }
  }

  ///
  /// 创建文件
  ///
  static Future<File> createFile(String filePath) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filePath');
    if (file.existsSync()) {
      print('文件管理系统：文件已存在');
      return file;
    }

    file.create(recursive: true);
    return file;
  }

  ///
  /// 创建文件夹
  ///
  static Future createDir(String filePath) async {
    final dir = await getApplicationDocumentsDirectory();
    final directory = Directory('${dir.path}/$filePath');
    if (directory.existsSync()) {
      print('文件管理系统：文件夹已存在');
      return;
    }

    await directory.create(recursive: true);
    print('文件管理系统：文件夹创建成功');
  }

  ///
  /// 写入文件
  ///
  static Future writeFile(String filePath, String content) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filePath');
    if (file.existsSync()) {
      file.writeAsStringSync(content);
      print('文件管理系统：文件修改成功');
      return;
    }

    print('文件管理系统：文件不存在');
  }

}