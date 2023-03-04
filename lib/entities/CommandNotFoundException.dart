class CommandNotFoundException implements Exception {
  String command;

  CommandNotFoundException(this.command);

  @override
  String toString() {
    return '$command命令未找到';
  }
}