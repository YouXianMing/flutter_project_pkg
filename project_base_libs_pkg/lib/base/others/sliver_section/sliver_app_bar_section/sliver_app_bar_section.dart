import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../base_sliver_section.dart';

/// SliverAppBarSection
class SliverAppBarSection extends BaseSliverSection {
  @override
  String? mark;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Color? shadowColor;
  final bool forceElevated;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final TextTheme? textTheme;
  final bool primary;
  final bool? centerTitle;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double? collapsedHeight;
  final double? expandedHeight;
  final bool floating;
  final bool pinned;
  final ShapeBorder? shape;
  final bool snap;
  final bool stretch;
  final double stretchTriggerOffset;
  final AsyncCallback? onStretchTrigger;
  final double toolbarHeight;
  final double? leadingWidth;
  final bool? backwardsCompatibility;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;

  SliverAppBarSection({
    this.mark,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.forceElevated = false,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.collapsedHeight,
    this.expandedHeight,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.stretch = false,
    this.stretchTriggerOffset = 100.0,
    this.onStretchTrigger,
    this.shape,
    this.toolbarHeight = kToolbarHeight,
    this.leadingWidth,
    this.backwardsCompatibility,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
  });

  static Widget widget({
    String? mark,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation,
    Color? shadowColor,
    bool forceElevated = false,
    Color? backgroundColor,
    Color? foregroundColor,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    bool primary = true,
    bool? centerTitle,
    bool excludeHeaderSemantics = true,
    double? titleSpacing,
    double? collapsedHeight,
    double? expandedHeight,
    bool floating = false,
    bool pinned = false,
    ShapeBorder? shape,
    bool snap = false,
    bool stretch = false,
    double stretchTriggerOffset = 100,
    AsyncCallback? onStretchTrigger,
    double toolbarHeight = kToolbarHeight,
    double? leadingWidth,
    bool? backwardsCompatibility,
    TextStyle? toolbarTextStyle,
    TextStyle? titleTextStyle,
    SystemUiOverlayStyle? systemOverlayStyle,
  }) {
    return SliverAppBarSection(
      mark: mark,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shadowColor: shadowColor,
      forceElevated: forceElevated,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      collapsedHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      floating: floating,
      pinned: pinned,
      snap: snap,
      stretch: stretch,
      stretchTriggerOffset: stretchTriggerOffset,
      onStretchTrigger: onStretchTrigger,
      shape: shape,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      backwardsCompatibility: backwardsCompatibility,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle: systemOverlayStyle,
    ).buildWidget();
  }

  @override
  Widget buildWidget() {
    return SliverAppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shadowColor: shadowColor,
      forceElevated: forceElevated,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      collapsedHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      floating: floating,
      pinned: pinned,
      snap: snap,
      stretch: stretch,
      stretchTriggerOffset: stretchTriggerOffset,
      onStretchTrigger: onStretchTrigger,
      shape: shape,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      backwardsCompatibility: backwardsCompatibility,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle: systemOverlayStyle,
    );
  }
}
