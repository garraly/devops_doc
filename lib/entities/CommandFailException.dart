class CommandFailException implements Exception {
  String msg;

  CommandFailException(this.msg);

  @override
  String toString() {
    return msg;
  }
}