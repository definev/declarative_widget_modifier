import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// The signature of the [LayoutBuilder] builder function.
typedef SingleChildLayoutWidgetBuilder = Widget Function(
    BuildContext context, BoxConstraints constraints, Widget? child);


/// Builds a widget tree that can depend on the parent widget's size.
///
/// Similar to the [Builder] widget except that the framework calls the [builder]
/// function at layout time and provides the parent widget's constraints. This
/// is useful when the parent constrains the child's size and doesn't depend on
/// the child's intrinsic size. The [LayoutBuilder]'s final size will match its
/// child's size.
///
/// {@macro flutter.widgets.ConstrainedLayoutBuilder}
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=IYDVcriKjsw}
///
/// If the child should be smaller than the parent, consider wrapping the child
/// in an [Align] widget. If the child might want to be bigger, consider
/// wrapping it in a [SingleChildScrollView] or [OverflowBox].
///
/// {@tool dartpad}
/// This example uses a [LayoutBuilder] to build a different widget depending on the available width. Resize the
/// DartPad window to see [LayoutBuilder] in action!
///
/// ** See code in examples/api/lib/widgets/layout_builder/layout_builder.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [SliverLayoutBuilder], the sliver counterpart of this widget.
///  * [Builder], which calls a `builder` function at build time.
///  * [StatefulBuilder], which passes its `builder` function a `setState` callback.
///  * [CustomSingleChildLayout], which positions its child during layout.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class LayoutBuilderModifier extends SingleChildStatelessModifier {
  /// Creates a widget that defers its building until layout.
  ///
  /// The [builder] argument must not be null.
  const LayoutBuilderModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.builder,
  });

  /// Called at layout time to construct the widget tree.
  ///
  /// The builder must not return null.
  final SingleChildLayoutWidgetBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return LayoutBuilder(
      key: modifierKey,
      builder: (BuildContext context, BoxConstraints constraints) => builder(context, constraints, child),
    );
  }
}
