/*
 * @Description: 文件描述
 * @Author: lijiahua1
 * @Date: 2022-08-04 17:19:56
 * @LastEditors: lijiahua1
 * @LastEditTime: 2023-03-02 16:03:21
 * @LastDescription: 
 */
/*
 * @Description: 文件描述
 * @Author: lijiahua1
 * @Date: 2022-08-04 17:19:56
 * @LastEditors: lijiahua1
 * @LastEditTime: 2023-03-02 16:02:09
 * @LastDescription: 
 */
import 'package:flutter/cupertino.dart';

class ModulesListItem extends StatefulWidget{

  final String title;

  final String version;

  final bool isLoading;

  const ModulesListItem({Key? key,
    required this.title,
    this.version = "",
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ModulesListItemState();
  }
}

class _ModulesListItemState extends State<ModulesListItem> {

  void onPressAdd() {
    // todo
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        AnimatedContainer(
          duration: const Duration(microseconds: 500),
          child: Row(
            children: [
              Text(!widget.isLoading? widget.version : ''),
              !widget.isLoading? CupertinoButton(
                  onPressed: onPressAdd,
                  child: const Icon(
                    CupertinoIcons.plus_circle,
                    size: 20,
                  )
              ) : Container()
            ],
          ),
        )
    ],);
  }

}