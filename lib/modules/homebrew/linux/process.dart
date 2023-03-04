import 'package:front_env/class/ModuleProcess.dart';

import '../HomeBrewProcess.dart';

class LinuxProcess implements HomeBrewProcess{
  @override
  Future<bool> install() {
    // TODO: implement install
    throw UnimplementedError();
  }

  @override
  Future<bool> remove() {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<List<String>> search() {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<bool> update() {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> checkInstall() {
    // TODO: implement checkInstall
    throw UnimplementedError();
  }

  @override
  Future<String> checkVersion() {
    // TODO: implement checkVersion
    throw UnimplementedError();
  }

  @override
  Future<List<String>> searchVersion() {
    // TODO: implement searchVersion
    throw UnimplementedError();
  }

  @override
  Future<List<SoftVersion>> checkSoftUpdate() {
    // TODO: implement checkSoftUpdate
    throw UnimplementedError();
  }

}