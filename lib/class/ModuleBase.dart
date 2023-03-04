import 'package:front_env/class/ModuleProcess.dart';

abstract class ModuleBase {
  String name = '';

  String version = '';

  // 公司指定版本
  String standardVersion = '';

  List<String> versionList = [];

  bool checkLoading = false;

  bool installLoading = false;

  bool isInstalled = false;

  late ModuleProcess _process;

  // 检查版本
  Future<void> check() => Future(() => null);

  // 安装
  Future<bool> install() => Future(() => false);

  Future<void> search() => Future(() => null);

  // 卸载
  Future<void> uninstall() => Future(() => null);

  // 是否等于公司指定使用版本
  bool get isStandard => true;
}
