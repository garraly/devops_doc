import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class DocScreen extends StatefulWidget{
  const DocScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DocScreenState();
  }
}

class DocScreenState extends State<DocScreen> {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('主页'),

    );
  }
}