import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/utilities/hive_type_adapter.dart';

class ListModel extends ChangeNotifier {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  bool isLastAnimated = false;
  final Box<NoteListModel> box = Hive.box<NoteListModel>('NotesStorage');
  bool animatedToggle() {
    if (box.length == 0) {
      isLastAnimated = true;
      return isLastAnimated;
    } else {
      isLastAnimated = false;
      return isLastAnimated;
    }
  }
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
