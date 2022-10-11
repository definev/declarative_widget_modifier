import 'package:flutter/material.dart';

import '../modifier.dart';

/// A widget with a preferred size.
///
/// This widget does not impose any constraints on its child, and it doesn't
/// affect the child's layout in any way. It just advertises a preferred size
/// which can be used by the parent.
///
/// Parents like [Scaffold] use [PreferredSizeWidget] to require that their
/// children implement that interface. To give a preferred size to an arbitrary
/// widget so that it can be used in a `child` property of that type, this
/// widget, [PreferredSize], can be used.
///
/// Widgets like [AppBar] implement a [PreferredSizeWidget], so that this
/// [PreferredSize] widget is not necessary for them.
///
/// {@tool dartpad}
/// This sample shows a custom widget, similar to an [AppBar], which uses a
/// [PreferredSize] widget, with its height set to 80 logical pixels.
/// Changing the [PreferredSize] can be used to change the height
/// of the custom app bar.
///
/// ** See code in examples/api/lib/widgets/preferred_size/preferred_size.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AppBar.bottom] and [Scaffold.appBar], which require preferred size widgets.
///  * [PreferredSizeWidget], the interface which this widget implements to expose
///    its preferred size.
///  * [AppBar] and [TabBar], which implement PreferredSizeWidget.
class PreferredSizeModifier extends SingleChildStatelessModifier implements PreferredSizeWidget {
  /// Creates a widget that has a preferred size that the parent can query.
  const PreferredSizeModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.preferredSize,
  });

  @override
  final Size preferredSize;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => child!;
}
