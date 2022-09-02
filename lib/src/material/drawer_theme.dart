import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class DrawerThemeModifier extends SingleChildStatelessWidget {
  const DrawerThemeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final DrawerThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DrawerTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
