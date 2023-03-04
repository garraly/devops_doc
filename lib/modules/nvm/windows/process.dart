import 'dart:io';
import 'package:front_env/class/ModuleProcess.dart';
import 'package:front_env/entities/CommandFailException.dart';
import 'package:front_env/entities/CommandNotFoundException.dart';
import 'package:process_run/shell.dart';

class WindowsProcess implements ModuleProcess{
  var shell = Shell();

  void _checkResult(List<ProcessResult> result) {
    if(result.first.outText.contains('/bin/bash: brew: command not found')) {
      throw CommandNotFoundException('Homebrew');
    }
  }

  void _checkError(List<ProcessResult> result) {
    if (result.first.outText.startsWith('Error')) {
      throw CommandFailException(result.first.outText);
    }
  }

  @override
  Future<bool> install() async {
    var result = await shell.run('/bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"');
    _checkError(result);
    // todo 测试
    return true;
  }

  @override
  Future<bool> remove() async {
    var result = await shell.run('/bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"');
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
    var result = await shell.run('/bin/bash -c brew update');
    // todo 测试
    return true;
  }

  @override
  Future<bool> checkInstall() async {
    var result = await shell.run('/bin/bash -c brew --version');
    if(result.first.outText.startsWith('Homebrew')) {
      return true;
    }
    return false;
  }

  @override
  Future<String> checkVersion() async {
    var result = await shell.run('/bin/bash -c brew --version');
    _checkResult(result);
    return result.first.outText.replaceFirst('Homebrew ', '');
  }
}