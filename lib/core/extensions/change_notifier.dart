import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BaseChangeNotifierProvider<T extends ChangeNotifier>
    extends StatelessWidget {
  const BaseChangeNotifierProvider({
    required this.create,
    required this.builder,
    super.key,
    this.child,
  });

  final T Function() create;
  final Widget Function(BuildContext context, T controller, Widget? child)
  builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => create(),
      builder: (context, _) {
        return Consumer<T>(
          builder: builder,
          child: child,
        );
      },
    );
  }
}