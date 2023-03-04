/*
 * @Description: 文件描述
 * @Author: lijiahua1
 * @Date: 2023-03-04 16:00:46
 * @LastEditors: lijiahua1
 * @LastEditTime: 2023-03-04 20:06:56
 * @LastDescription: 
 */
import 'package:front_env/modules/devops/devops.dart';
import 'package:get/get.dart';

class DevopsProvider extends GetxController with DevopsData{
  
  @override
  confirmCommonStory(int id) {
    super.confirmCommonStory(id);
    update();
  }

  @override
  confirmDevopsStory(int id) {
    super.confirmDevopsStory(id);
    update();
  }
}