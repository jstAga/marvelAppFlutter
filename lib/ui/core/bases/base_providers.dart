import 'package:flutter/widgets.dart';

class NotifierProvider<Model extends ChangeNotifier>
    extends StatefulWidget {
  const NotifierProvider(
      {super.key,
      required this.create,
      required this.child,
      this.isManagingModel = true});

  final Model Function() create;
  final bool isManagingModel;
  final Widget child;

  @override
  _NotifierProviderState<Model> createState() =>
      _NotifierProviderState<Model>();

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedNotifierProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<_InheritedNotifierProvider<Model>>()
        ?.widget;
    return widget is _InheritedNotifierProvider<Model> ? widget.model : null;
  }
}

class _NotifierProviderState<Model extends ChangeNotifier>
    extends State<NotifierProvider<Model>> {
  late final Model _model;

  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  void dispose() {
    if (widget.isManagingModel) {
      _model.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedNotifierProvider(model: _model, child: widget.child);
  }
}

class _InheritedNotifierProvider<Model extends ChangeNotifier>
    extends InheritedNotifier {
  const _InheritedNotifierProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(notifier: model, child: child);

  final Model model;
}

class InheritedProvider<Model> extends InheritedWidget {
  const InheritedProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(child: child);

  final Model model;

  static Model? watch<Model>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedProvider<Model>>()
        ?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<InheritedProvider<Model>>()
        ?.widget;
    return widget is InheritedProvider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(InheritedProvider oldWidget) {
    return model != oldWidget.model;
  }
}
