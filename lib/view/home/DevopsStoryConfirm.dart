/*
 * @Description: 文件描述
 * @Author: lijiahua1
 * @Date: 2023-03-04 12:56:50
 * @LastEditors: lijiahua1
 * @LastEditTime: 2023-03-05 12:26:58
 * @LastDescription: 
 */
import 'package:flutter/material.dart';
import 'package:front_env/core/provider/devops.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';

class DevopsStoryConfirmScreen extends StatefulWidget {
  const DevopsStoryConfirmScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DevopsStoryConfirmScreenState();
  }
}

class DevopsStoryConfirmScreenState extends State<DevopsStoryConfirmScreen> {
  final devopsAction = Get.put(DevopsProvider());

  @override
  void initState() {
    super.initState();
  }

  onPressedNex() async {
    try{ 
      await devopsAction.exportToExcel();
      Get.toNamed('/result', arguments: {
        "result": "success"
      });
    } catch (e) {
      Get.toNamed('/result', arguments: {
        "result": "fail"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(title: Text('确认故事'), actions: []),
      children: [
        ContentArea(
          builder: (BuildContext context, ScrollController scrollController) {
            return GetBuilder<DevopsProvider>(
              builder: (devops) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const MacosListTile(
                      title: Text('选择你的专项', style: TextStyle(fontSize: 12),),
                      subtitle: Text('点击勾选属于专项的故事，专项与非专项会导出不同卡片。'),
                      ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                                border: Border.all(color: MacosTheme.of(context).dividerColor),
                                borderRadius: BorderRadius.circular(10)
                              ),
                        child: ListView.separated(
                          itemCount: devops.storydata.length,
                          controller: scrollController,
                          itemBuilder: (BuildContext context, index) {
                            var e = devops.storydata.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                if (!e.isDevops) {
                                  devopsAction.confirmDevopsStory(e.id);
                                } else {
                                  devopsAction.confirmCommonStory(e.id);
                                }
                              },
                              child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(e.title,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 11,
                                            ))),
                                    Padding(padding: const EdgeInsets.only(right: 10),
                                    child: MacosCheckbox(
                                        value: e.isDevops,
                                        onChanged: (bool value) {
                                          if (value) {
                                            devopsAction.confirmDevopsStory(e.id);
                                          } else {
                                            devopsAction.confirmCommonStory(e.id);
                                          }
                                        }),)
                                  ],
                                ),
                            ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(height: 1,color: MacosTheme.of(context).dividerColor,);
                          },
                        ),
                      )
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PushButton(
                            onPressed: onPressedNex,
                            // padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                            buttonSize: ButtonSize.small,
                            child: const Text('下一步')
                          )
                      ],
                    )
                  ],
                ),);
              },
            );
          },
        )
      ],
    );
  }
}
