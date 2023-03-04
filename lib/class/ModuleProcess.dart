
abstract class ModuleProcess {
  Future<bool> install() => Future(() => true);

  Future<bool> update() => Future(() => true);

  Future<bool> remove() => Future(() => true);

  Future<bool> checkInstall() => Future(() => false);

  Future<String> checkVersion() => Future(() => '');

  Future<List<String>> searchVersion() => Future(() => []);
}