import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A box in which a single widget can be scrolled.
///
/// This widget is useful when you have a single box that will normally be
/// entirely visible, for example a clock face in a time picker, but you need to
/// make sure it can be scrolled if the container gets too small in one axis
/// (the scroll direction).
///
/// It is also useful if you need to shrink-wrap in both axes (the main
/// scrolling direction as well as the cross axis), as one might see in a dialog
/// or pop-up menu. In that case, you might pair the [SingleChildScrollView]
/// with a [ListBody] child.
///
/// When you have a list of children and do not require cross-axis
/// shrink-wrapping behavior, for example a scrolling list that is always the
/// width of the screen, consider [ListView], which is vastly more efficient
/// than a [SingleChildScrollView] containing a [ListBody] or [Column] with
/// many children.
///
/// ## Sample code: Using [SingleChildScrollView] with a [Column]
///
/// Sometimes a layout is designed around the flexible properties of a
/// [Column], but there is the concern that in some cases, there might not
/// be enough room to see the entire contents. This could be because some
/// devices have unusually small screens, or because the application can
/// be used in landscape mode where the aspect ratio isn't what was
/// originally envisioned, or because the application is being shown in a
/// small window in split-screen mode. In any case, as a result, it might
/// make sense to wrap the layout in a [SingleChildScrollView].
///
/// Simply doing so, however, usually results in a conflict between the [Column],
/// which typically tries to grow as big as it can, and the [SingleChildScrollView],
/// which provides its children with an infinite amount of space.
///
/// To resolve this apparent conflict, there are a couple of techniques, as
/// discussed below. These techniques should only be used when the content is
/// normally expected to fit on the screen, so that the lazy instantiation of
/// a sliver-based [ListView] or [CustomScrollView] is not expected to provide
/// any performance benefit. If the viewport is expected to usually contain
/// content beyond the dimensions of the screen, then [SingleChildScrollView]
/// would be very expensive.
///
/// ### Centering, spacing, or aligning fixed-height content
///
/// If the content has fixed (or intrinsic) dimensions but needs to be spaced out,
/// centered, or otherwise positioned using the [Flex] layout model of a [Column],
/// the following technique can be used to provide the [Column] with a minimum
/// dimension while allowing it to shrink-wrap the contents when there isn't enough
/// room to apply these spacing or alignment needs.
///
/// A [LayoutBuilder] is used to obtain the size of the viewport (implicitly via
/// the constraints that the [SingleChildScrollView] sees, since viewports
/// typically grow to fit their maximum height constraint). Then, inside the
/// scroll view, a [ConstrainedBox] is used to set the minimum height of the
/// [Column].
///
/// The [Column] has no [Expanded] children, so rather than take on the infinite
/// height from its [BoxConstraints.maxHeight], (the viewport provides no maximum height
/// constraint), it automatically tries to shrink to fit its children. It cannot
/// be smaller than its [BoxConstraints.minHeight], though, and It therefore
/// becomes the bigger of the minimum height provided by the
/// [ConstrainedBox] and the sum of the heights of the children.
///
/// If the children aren't enough to fit that minimum size, the [Column] ends up
/// with some remaining space to allocate as specified by its
/// [Column.mainAxisAlignment] argument.
///
/// {@tool dartpad}
/// In this example, the children are spaced out equally, unless there's no more
/// room, in which case they stack vertically and scroll.
///
/// When using this technique, [Expanded] and [Flexible] are not useful, because
/// in both cases the "available space" is infinite (since this is in a viewport).
/// The next section describes a technique for providing a maximum height constraint.
///
/// ** See code in examples/api/lib/widgets/single_child_scroll_view/single_child_scroll_view.0.dart **
/// {@end-tool}
///
/// ### Expanding content to fit the viewport
///
/// The following example builds on the previous one. In addition to providing a
/// minimum dimension for the child [Column], an [IntrinsicHeight] widget is used
/// to force the column to be exactly as big as its contents. This constraint
/// combines with the [ConstrainedBox] constraints discussed previously to ensure
/// that the column becomes either as big as viewport, or as big as the contents,
/// whichever is biggest.
///
/// Both constraints must be used to get the desired effect. If only the
/// [IntrinsicHeight] was specified, then the column would not grow to fit the
/// entire viewport when its children were smaller than the whole screen. If only
/// the size of the viewport was used, then the [Column] would overflow if the
/// children were bigger than the viewport.
///
/// The widget that is to grow to fit the remaining space so provided is wrapped
/// in an [Expanded] widget.
///
/// This technique is quite expensive, as it more or less requires that the contents
/// of the viewport be laid out twice (once to find their intrinsic dimensions, and
/// once to actually lay them out). The number of widgets within the column should
/// therefore be kept small. Alternatively, subsets of the children that have known
/// dimensions can be wrapped in a [SizedBox] that has tight vertical constraints,
/// so that the intrinsic sizing algorithm can short-circuit the computation when it
/// reaches those parts of the subtree.
///
/// {@tool dartpad}
/// In this example, the column becomes either as big as viewport, or as big as
/// the contents, whichever is biggest.
///
/// ** See code in examples/api/lib/widgets/single_child_scroll_view/single_child_scroll_view.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ListView], which handles multiple children in a scrolling list.
///  * [GridView], which handles multiple children in a scrolling grid.
///  * [PageView], for a scrollable that works page by page.
///  * [Scrollable], which handles arbitrary scrolling effects.
class SingleChildScrollViewModifier extends SingleChildStatelessModifier {
  /// Creates a box in which a single widget can be scrolled.
  const SingleChildScrollViewModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the scroll view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the scroll view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry? padding;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  ///
  /// Must be null if [primary] is true.
  ///
  /// A [ScrollController] serves several purposes. It can be used to control
  /// the initial scroll position (see [ScrollController.initialScrollOffset]).
  /// It can be used to control whether the scroll view should automatically
  /// save and restore its scroll position in the [PageStorage] (see
  /// [ScrollController.keepScrollOffset]). It can be used to read the current
  /// scroll position (see [ScrollController.offset]), or change it (see
  /// [ScrollController.animateTo]).
  final ScrollController? controller;

  /// {@macro flutter.widgets.scroll_view.primary}
  final bool? primary;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.scroll_view.keyboardDismissBehavior}
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SingleChildScrollView(
      key: modifierKey,
      controller: controller,
      clipBehavior: clipBehavior,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      physics: physics,
      primary: primary,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      child: child,
    );
  }
}
