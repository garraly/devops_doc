/*
 * @Description: 文件描述
 * @Author: lijiahua1
 * @Date: 2022-07-22 15:07:58
 * @LastEditors: lijiahua1
 * @LastEditTime: 2023-03-04 18:36:46
 * @LastDescription: 
 */
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';


class Layout extends StatefulWidget {
  const Layout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return LayoutState();
  }
}

class LayoutState extends State<Layout> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        builder: (context, scrollController) {
          return SidebarItems(
            currentIndex: _pageIndex,
            onChanged: (index) {
              // setState(() => _pageIndex = index);
              // Get.toNamed('/doc');
            },
            items: const [
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.home),
                label: Text('生成'),
              ),
              // SidebarItem(
              //   leading: MacosIcon(CupertinoIcons.search),
              //   label: Text('开发文档'),
              // ),
            ],
          );
        },
      ),
      child: widget.child,
    );
  }
}

typedef ValueChanged = void Function(int value);

