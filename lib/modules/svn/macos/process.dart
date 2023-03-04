import 'dart:io';
import 'package:front_env/class/ModuleProcess.dart';
import 'package:front_env/entities/CommandFailException.dart';
import 'package:front_env/entities/CommandNotFoundException.dart';
import 'package:process_run/shell.dart';

class MacosProcess implements ModuleProcess{
  var shell = Shell();

  void _checkResult(List<ProcessResult> result) {
    if(result.first.outText.contains('command not found')) {
      throw CommandNotFoundException('Svn');
    }
  }

  void _checkError(List<ProcessResult> result) {
    if (result.first.outText.startsWith('Error')) {
      throw CommandFailException(result.first.outText);
    }
  }

  @override
  Future<bool> install() async {
    var result = await shell.run('brew install svn');
    _checkError(result);
    // todo 测试
    return true;
  }

  @override
  Future<bool> remove() async {
    var result = await shell.run('brew uninstall svn');
    _checkError(result);
    // todo 测试
    return true;
  }

  @override
  Future<List<String>> searchVersion() async {
    return [];
  }

  @override
  Future<bool> update() async {
    var result = await shell.run('brew upgrade svn');
    _checkError(result);
    // todo 测试
    return true;
  }

  @override
  Future<bool> checkInstall() async {
    var result = await shell.run('svn --version');
    _checkResult(result);
    return true;
  }

  @override
  Future<String> checkVersion() async {
    var result = await shell.run('svn --version');
    _checkResult(result);
    return result.first.outText;
  }
}