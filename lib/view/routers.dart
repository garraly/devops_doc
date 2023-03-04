import 'package:flutter/widgets.dart';
import 'package:front_env/view/home/DevopsStoryConfirm.dart';
import 'package:front_env/view/home/Result.dart';
import 'home/Home.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => const HomeScreen(),
  '/confirm': (BuildContext context) => const DevopsStoryConfirmScreen(),
  '/result':(BuildContext context) => const ResultScreen(),
};