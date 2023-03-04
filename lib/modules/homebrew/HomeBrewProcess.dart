import 'package:front_env/class/ModuleProcess.dart';

class SoftVersion {
  String name = '';

  String currentVersion = '';

  String latestVersion = '';
}

class HomeBrewProcess implements ModuleProcess{
  @override
  Future<bool> checkInstall() {
    return Future(() => false);
  }

  @override
  Future<String> checkVersion() {
    return Future(() => '');

  }

  @override
  Future<bool> install() {
    return Future(() => false);

  }

  @override
  Future<bool> remove() {
    return Future(() => false);
  }

  @override
  Future<List<String>> searchVersion() {
    return Future(() => []);

  }

  @override
  Future<bool> update() {
    return Future(() => false);
  }

  Future<List<SoftVersion>> checkSoftUpdate() async {
    return [];
  }
}