import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class SliderThemeModifier extends SingleChildStatelessWidget {
  const SliderThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
  final SliderThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliderTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
