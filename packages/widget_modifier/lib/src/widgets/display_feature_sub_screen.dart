import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Positions [child] such that it avoids overlapping any [DisplayFeature] that
/// splits the screen into sub-screens.
///
/// A [DisplayFeature] splits the screen into sub-screens when both these
/// conditions are met:
///
///   * it obstructs the screen, meaning the area it occupies is not 0 or the
///     `state` is [DisplayFeatureState.postureHalfOpened].
///   * it is at least as tall as the screen, producing a left and right
///     sub-screen or it is at least as wide as the screen, producing a top and
///     bottom sub-screen
///
/// After determining the sub-screens, the closest one to [anchorPoint] is used
/// to render the content.
///
/// If no [anchorPoint] is provided, then [Directionality] is used:
///
///   * for [TextDirection.ltr], [anchorPoint] is `Offset.zero`, which will
///     cause the content to appear in the top-left sub-screen.
///   * for [TextDirection.rtl], [anchorPoint] is `Offset(double.maxFinite, 0)`,
///     which will cause the content to appear in the top-right sub-screen.
///
/// If no [anchorPoint] is provided, and there is no [Directionality] ancestor
/// widget in the tree, then the widget asserts during build in debug mode.
///
/// Similarly to [SafeArea], this widget assumes there is no added padding
/// between it and the first [MediaQuery] ancestor. The [child] is wrapped in a
/// new [MediaQuery] instance containing the [DisplayFeature]s that exist in the
/// selected sub-screen, with coordinates relative to the sub-screen. Padding is
/// also adjusted to zero out any sides that were avoided by this widget.
///
/// See also:
///
///  * [showDialog], which is a way to display a [DialogRoute].
///  * [showCupertinoDialog], which displays an iOS-style dialog.
class DisplayFeatureSubScreenModifier extends SingleChildStatelessModifier {
  /// Creates a widget that positions its child so that it avoids display
  /// features.
  const DisplayFeatureSubScreenModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.anchorPoint,
  });

  /// {@macro flutter.widgets.DisplayFeatureSubScreen.anchorPoint}
  final Offset? anchorPoint;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DisplayFeatureSubScreen(
      key: modifierKey,
      anchorPoint: anchorPoint,
      child: child!,
    );
  }
}
