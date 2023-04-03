/*
 * @Description: 文件描述
 * @Author: lijiahua1
 * @Date: 2022-07-13 17:37:44
 * @LastEditors: lijiahua1
 * @LastEditTime: 2023-04-03 17:01:04
 * @LastDescription: 
 */
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_env/core/provider/devops.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';

class StoryData extends Object {
  String title;
  String acceptanceCriteria;
  String sit;
  String uat;
  String po;
  List<TaskData> tasks = [];
  StoryData(this.title, this.acceptanceCriteria, this.po,this.sit, this.uat);
  
}

class TaskData extends Object {
  String title;
  String date;
  String workTime;
  String person;
  TaskData(this.title,this.date,this.workTime,this.person);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  bool _dragging = false;

  bool _dropEnable = true;

  final devopsAction = Get.put(DevopsProvider());

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(title: Text('敏捷开发'), actions: []),
      children: [
        ContentArea(builder: (context, scrollControler)=> Center(
          child: DropTarget(
          enable: _dropEnable,
          onDragDone: (detail) {
           setState(() {
              _dragging = false;
            });
            try {
              devopsAction.generateFormExcel(detail.files.first.path);
              Get.toNamed('/confirm');
            } catch (e) {
              Get.toNamed('/result', arguments: {
                "result": "fail" ,
                "errMsg": "源文件格式不符合"
              });
            }
            // devopsAction.exportToExcel();
            // convertToCard(detail.files.first.path);
          },
          onDragEntered: (detail) {
            setState(() {
              _dragging = true;
            });
          },
          onDragExited: (detail) {
            setState(() {
              _dragging = false;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: _dragging ? Colors.blueAccent.withOpacity(0.05) : Colors.transparent,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(child: Text( _dragging ? "松手🐿️" :"请把敏捷用户故事任务放到这^_^"))
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      child: const Icon(
                        CupertinoIcons.question_circle,
                        size: 32.0,
                        // color: CupertinoColors.systemBlue,
                      ),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext dialogContext) => MacosAlertDialog(
                            appIcon: const FlutterLogo(
                              size: 56,
                            ),
                            title: Column(
                              children: [
                                Text(
                                  '敏捷生成卡片 ',
                                  style: MacosTheme.of(context).typography.headline,
                                ),
                                Text(
                                  'v2.0.0',
                                  style: MacosTheme.of(context).typography.footnote,
                                )
                              ],
                            ),
                            message: Text(
                              'Excel 第一行标题请放：（Task	Story	开发/测试	完成日期 工时 SIT时间	UAT时间	PO 验收标准）顺序不限',
                              textAlign: TextAlign.center,
                              style: MacosTheme.of(context).typography.headline,
                            ),
                            primaryButton: PushButton(
                              buttonSize: ButtonSize.large,
                              child: const Text('明白'),
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                            ),
                          ),
                        );

                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )),
        )
      ],
    );
  }
}
