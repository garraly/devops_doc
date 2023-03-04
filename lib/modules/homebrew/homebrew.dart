import 'package:front_env/class/ModuleBase.dart';
import 'package:front_env/entities/CommandFailException.dart';
import 'package:front_env/entities/CommandNotFoundException.dart';
import 'package:front_env/modules/homebrew/linux/process.dart';
import 'dart:io';

import 'HomeBrewProcess.dart';
import 'macos/process.dart';

class Homebrew implements ModuleBase {

  Homebrew() {
    if (Platform.isMacOS) {
      _process = MacosProcess();
    }else if(Platform.isLinux) {
      _process = LinuxProcess();
    } else {
      _process = HomeBrewProcess();
    }
  }

  @override
  bool checkLoading  = false;

  @override
  bool installLoading  = false;

  @override
  String name = 'HomeBrew';

  @override
  String standardVersion = '';

  @override
  String version = '';

  @override
  List<String> versionList = [];

  @override
  bool isInstalled = false;

  List<SoftVersion> soft = [];

  late HomeBrewProcess _process;

  @override
  Future<void> check() async {
    checkLoading = true;
    try {
      version = await _process.checkVersion();
      isInstalled = true;
    } on CommandNotFoundException {
      isInstalled = false;
    }
    checkLoading = false;
  }

  @override
  Future<bool> install() async {
    installLoading = true;
    try {
      isInstalled = await _process.checkInstall();
    } on CommandFailException {
      isInstalled = false;
    }
    installLoading = false;
    return isInstalled;
  }

  @override
  bool get isStandard => standardVersion == version;

  @override
  Future<void> search() {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<void> uninstall() async {
    return;
  }

  Future<void> checkSoft() async {
    soft = await _process.checkSoftUpdate();
  }
}
