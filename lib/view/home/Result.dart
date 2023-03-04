/*
 * @Description: 文件描述
 * @Author: lijiahua1
 * @Date: 2023-03-04 20:19:04
 * @LastEditors: lijiahua1
 * @LastEditTime: 2023-03-05 02:21:25
 * @LastDescription: 
 */
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return ResultScreenState();
  }
}

class ResultScreenState extends State<ResultScreen> {
  String result = Get.arguments['result'] ?? 'fail'; // success fail
  bool get isSuccess => result == "success";
  String errMsg = Get.arguments['errMsg'] ?? '';
  

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(title: Text('生成卡片'), actions: []),
      children: [
        ContentArea(builder: (context, scrollControler)=> Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isSuccess ? const Icon(
                  CupertinoIcons.check_mark_circled,
                  color: MacosColors.systemGreenColor,
                ) : const Icon(
                  CupertinoIcons.xmark_circle,
                  color: MacosColors.systemRedColor,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                isSuccess ? Text('已导出', 
                  style: MacosTheme.of(context).typography.title1,
                ) : Text('导出失败', 
                  style: MacosTheme.of(context).typography.title1,
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
                Text(errMsg, style: MacosTheme.of(context).typography.body),
                const Padding(padding: EdgeInsets.only(top: 20)),
                PushButton(
                  onPressed: () {
                    Get.offAllNamed('/');
                  },
                  buttonSize: ButtonSize.small,
                  child: const Text('返回')
                )
              ],
            )),
        )
      ],
    );
  }
}
