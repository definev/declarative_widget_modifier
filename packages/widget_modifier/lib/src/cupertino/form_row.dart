import 'package:flutter/cupertino.dart';

import '../modifier.dart';

/// An iOS-style form row.
///
/// Creates an iOS-style split form row with a standard prefix and child widget.
/// Also provides a space for error and helper widgets that appear underneath.
///
/// The [child] parameter is required. This widget is displayed at the end of
/// the row.
///
/// The [prefix] parameter is optional and is displayed at the start of the
/// row. Standard iOS guidelines encourage passing a [Text] widget to [prefix]
/// to detail the nature of the row's [child] widget.
///
/// The [padding] parameter is used to pad the contents of the row. It defaults
/// to the standard iOS padding. If no edge insets are intended, explicitly pass
/// [EdgeInsets.zero] to [padding].
///
/// The [helper] and [error] parameters are both optional widgets targeted at
/// displaying more information about the row. Both widgets are placed
/// underneath the [prefix] and [child], and will expand the row's height to
/// accommodate for their presence. When a [Text] is given to [error], it will
/// be shown in [CupertinoColors.destructiveRed] coloring and
/// medium-weighted font.
///
/// {@tool dartpad}
/// Creates a [CupertinoFormSection] containing a [CupertinoFormRow] with [prefix],
/// [child], [helper] and [error] specified.
///
/// ** See code in examples/api/lib/cupertino/form_row/cupertino_form_row.0.dart **
/// {@end-tool}
///
class CupertinoFormRowModifier extends SingleChildStatelessModifier {
  /// Creates an iOS-style split form row with a standard prefix and child widget.
  /// Also provides a space for error and helper widgets that appear underneath.
  ///
  /// The [child] parameter is required. This widget is displayed at the end of
  /// the row.
  ///
  /// The [prefix] parameter is optional and is displayed at the start of the
  /// row. Standard iOS guidelines encourage passing a [Text] widget to [prefix]
  /// to detail the nature of the row's [child] widget.
  ///
  /// The [padding] parameter is used to pad the contents of the row. It defaults
  /// to the standard iOS padding. If no edge insets are intended, explicitly
  /// pass [EdgeInsets.zero] to [padding].
  ///
  /// The [helper] and [error] parameters are both optional widgets targeted at
  /// displaying more information about the row. Both widgets are placed
  /// underneath the [prefix] and [child], and will expand the row's height to
  /// accommodate for their presence. When a [Text] is given to [error], it will
  /// be shown in [CupertinoColors.destructiveRed] coloring and
  /// medium-weighted font.
  const CupertinoFormRowModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.prefix,
    this.padding,
    this.helper,
    this.error,
  });

  /// A widget that is displayed at the start of the row.
  ///
  /// The [prefix] parameter is displayed at the start of the row. Standard iOS
  /// guidelines encourage passing a [Text] widget to [prefix] to detail the
  /// nature of the row's [child] widget. If null, the [child] widget will take
  /// up all horizontal space in the row.
  final Widget? prefix;

  /// Content padding for the row.
  ///
  /// Defaults to the standard iOS padding for form rows. If no edge insets are
  /// intended, explicitly pass [EdgeInsets.zero] to [padding].
  final EdgeInsetsGeometry? padding;
 
  /// A widget that is displayed underneath the [prefix] and [child] widgets.
  ///
  /// The [helper] appears in primary label coloring, and is meant to inform the
  /// user about interaction with the child widget. The row becomes taller in
  /// order to display the [helper] widget underneath [prefix] and [child]. If
  /// null, the row is shorter.
  final Widget? helper;
  
  /// A widget that is displayed underneath the [prefix] and [child] widgets.
  ///
  /// The [error] widget is primarily used to inform users of input errors. When
  /// a [Text] is given to [error], it will be shown in
  /// [CupertinoColors.destructiveRed] coloring and medium-weighted font. The
  /// row becomes taller in order to display the [helper] widget underneath
  /// [prefix] and [child]. If null, the row is shorter.
  final Widget? error;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoFormRow(
      key: modifierKey,
      error: error,
      helper: helper,
      padding: padding,
      prefix: prefix,
      child: child!,
    );
  }
}
