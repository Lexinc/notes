import 'package:flutter/material.dart';

class ListModel extends ChangeNotifier {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
}

class ProviderListModel extends InheritedNotifier {
  const ProviderListModel(
      {required this.model, required Widget child, Key? key})
      : super(child: child, key: key, notifier: model);

  final ListModel model;

  static ProviderListModel? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderListModel>();
  }

  static ProviderListModel? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ProviderListModel>()
        ?.widget;
    return widget is ProviderListModel ? widget : null;
  }
}
