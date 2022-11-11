import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title; //  AppBar标题
  final bool titleCenter; // AppBar标题居中
  final bool showBackButton; // 是否显示返回按钮
  final Function? customBack; // 自定义返回函数
  final Color color; // AppBar 颜色
  final Gradient? gradientBackground;
  final Widget right; // AppBar 右栏
  final Widget? left; // AppBar 左栏

  CustomAppBar({
    this.title,
    this.titleCenter = false,
    this.showBackButton = true,
    this.customBack,
    this.color = Colors.white,
    this.gradientBackground,
    this.right = const SizedBox(width: 40, height: 40),
    this.left,
  });

  @override
  State<CustomAppBar> createState() {
    return _CustomAppBarState();
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 12, right: 12),
      height: 48 + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
          color: widget.gradientBackground != null ? null : widget.color,
          gradient: widget.gradientBackground),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.titleCenter
            ? [
                widget.showBackButton
                    ? (widget.left ??
                        (widget.gradientBackground != null
                            ? GestureDetector(
                                child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onTap: () => widget.customBack != null
                                    ? widget.customBack!()
                                    : Get.back())
                            : GestureDetector(
                                child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: Icon(Icons.arrow_back_ios),
                                  ),
                                ),
                                onTap: () => widget.customBack != null
                                    ? widget.customBack!()
                                    : Get.back())))
                    : const SizedBox(
                        width: 40,
                        height: 40,
                      ),
                widget.title!,
                widget.right
              ]
            : [
                Row(children: [
                  widget.showBackButton
                      ? GestureDetector(
                          child: const SizedBox(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Icon(Icons.arrow_back_ios),
                            ),
                          ),
                          onTap: () => widget.customBack != null
                              ? widget.customBack!()
                              : Get.back())
                      : const SizedBox(
                          width: 40,
                          height: 40,
                        ),
                  widget.title!,
                ]),
                widget.right
              ],
      ),
    );
  }
}
