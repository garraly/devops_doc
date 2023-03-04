import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class CupertinoExpansionHeader extends StatelessWidget{

  CupertinoExpansionHeader({Key? key, required this.title, required this.show}) : super(key: key);

  String title;

  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        show ? const MacosIcon(CupertinoIcons.chevron_down) : const MacosIcon(CupertinoIcons.chevron_right),
        Text(title)
      ],
    );
  }
}