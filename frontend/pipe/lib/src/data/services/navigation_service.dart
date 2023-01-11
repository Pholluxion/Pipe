import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> popAndNavigateTo(String routeName) {
    return navigatorKey.currentState!.popAndPushNamed(routeName);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
