import 'dart:io';
import 'package:front_env/entities/CommandFailException.dart';
import 'package:front_env/entities/CommandNotFoundException.dart';
import 'package:process_run/shell.dart';

import '../HomeBrewProcess.dart';

class MacosProcess implements HomeBrewProcess{
  var shell = Shell();

  void _checkResult(List<ProcessResult> result) {
    if(result.first.outText.contains('command not found')) {
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
    var result = await shell.run('brew update');
    _checkError(result);
    // todo 测试
    return true;
  }

  @override
  Future<bool> checkInstall() async {
    var result = await shell.run('brew --version');
    if(result.first.outText.startsWith('Homebrew')) {
      return true;
    }
    return false;
  }

  @override
  Future<String> checkVersion() async {
    var result = await shell.run('brew --version');
    _checkResult(result);
    return result.first.outText.replaceFirst('Homebrew ', '');
  }

  Future<List<SoftVersion>> checkSoftUpdate() async {
    var result = await shell.run('brew outdated');
    _checkResult(result);
    List<SoftVersion> data = [];
    result.forEach((element) {
      var item = SoftVersion();
      var textList = element.outText.split(' ');

      item.name = textList.first;
      item.currentVersion = textList.elementAt(1);
      item.latestVersion = textList.last;

      data.add(item);
    });
    return data;
  }
}