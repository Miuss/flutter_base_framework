import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CsutomPage extends StatefulWidget {
  final Key? customKey;
  final Widget body;
  final Alignment childAlignment;
  final Widget? appBar;
  final Color? appBarColor;
  final bool floatAppBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool primary;
  final bool immersive;
  final bool resizeToAvoidBottomInset;
  final double liftOffset;
  final bool extendBody;
  final bool isBottomSafearea;
  final bool extendBodyBehindAppBar;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final void Function()? onShow;
  final void Function()? onHide;

  CsutomPage(
      {Key? key,
      this.customKey,
      required this.body,
      this.appBar,
      this.appBarColor,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.floatingActionButtonAnimator,
      this.persistentFooterButtons,
      this.drawer,
      this.endDrawer,
      this.drawerScrimColor,
      this.backgroundColor,
      this.bottomNavigationBar,
      this.bottomSheet,
      this.primary = true,
      this.drawerDragStartBehavior = DragStartBehavior.start,
      this.drawerEdgeDragWidth,
      this.immersive = false,
      this.floatAppBar = false,
      this.extendBodyBehindAppBar = false,
      this.systemOverlayStyle,
      this.onShow,
      this.onHide,
      this.childAlignment = Alignment.topLeft,
      this.resizeToAvoidBottomInset = false,
      this.liftOffset = 30,
      this.extendBody = false,
      this.isBottomSafearea = true})
      : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<CsutomPage> {
  bool pageOnShow = true;

  @override
  void dispose() {
    super.dispose();
  }

  Color get _appBarColor {
    Color defaultColor = widget.floatAppBar ? Colors.transparent : Colors.white;
    return widget.appBarColor ?? Colors.white;
  }

  bool get hasTopSafearea {
    if (widget.immersive) return false;
    if (widget.appBar != null) return false;
    if (widget.floatAppBar) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Widget current = MediaQuery.removePadding(
        context: context, removeTop: false, child: widget.body);

    Widget? appbar = widget.appBar != null
        ? CustomAppbar(
            child: widget.appBar!,
            appBarColor: _appBarColor,
            systemOverlayStyle: widget.systemOverlayStyle,
          )
        : null;

    if (widget.floatAppBar && widget.appBar != null) {
      current = Stack(
        children: [
          current,
          Positioned(
              child: IntrinsicHeight(
            child: appbar,
          ))
        ],
      );
    } else {
      current = Flex(
        direction: Axis.vertical,
        children: [
          if (widget.appBar != null) appbar!,
          Expanded(
              child:
                  Container(alignment: widget.childAlignment, child: current)),
        ],
      );
    }

    current = Scaffold(
        key: widget.customKey,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        persistentFooterButtons: widget.persistentFooterButtons,
        drawer: widget.drawer,
        endDrawer: widget.endDrawer,
        drawerScrimColor: widget.drawerScrimColor,
        backgroundColor: widget.backgroundColor,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        drawerDragStartBehavior: widget.drawerDragStartBehavior,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        extendBody: widget.extendBody,
        drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
        primary: widget.primary,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        body: SafeArea(
          top: hasTopSafearea,
          bottom: widget.isBottomSafearea,
          child: current,
        ));

    return current;
  }
}

class CustomAppbar extends StatefulWidget {
  final Color appBarColor;
  final Widget child;
  final SystemUiOverlayStyle? systemOverlayStyle;

  CustomAppbar({
    required this.appBarColor,
    required this.child,
    this.systemOverlayStyle,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return new _CustomAppbarState();
  }
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget current = Container(
      color: widget.appBarColor,
      child: widget.child is PreferredSizeWidget
          ? widget.child
          : SafeArea(child: widget.child),
    );
    if (widget.systemOverlayStyle != null) {
      current = AnnotatedRegion<SystemUiOverlayStyle>(
          child: current, value: widget.systemOverlayStyle!);
    }
    return current;
  }
}
