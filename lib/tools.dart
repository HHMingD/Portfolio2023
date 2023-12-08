import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'json_parse.dart';
import 'network.dart';

class HoverEffect extends StatefulWidget {
  const HoverEffect(
      {super.key,
      required this.child,
      this.backGroundColor = Apptheme.noColor,
      this.transparentBackground = false,
      required this.context});

  final bool transparentBackground;
  final Color backGroundColor;

  final BuildContext context;
  final Widget child;

  @override
  State<HoverEffect> createState() => _HoverEffectState();
}

class _HoverEffectState extends State<HoverEffect> {
  bool isHover = false;
  late Color borderColor;
  late Color lateBackGroundColor;
  late Color hoverColor;

  void _incrementEnter(PointerEvent details) {
    setState(() {
      isHover = true;
    });
  }

  void _incrementExit(PointerEvent details) {
    setState(() {
      isHover = false;
    });
  }

  @override
  void initState() {
    if (widget.transparentBackground) {
      borderColor = Apptheme.noColor;
      hoverColor = Apptheme.noColor;
      lateBackGroundColor = Apptheme.noColor;
    } else {
      borderColor = Theme.of(widget.context).primaryColor;
      hoverColor = Theme.of(widget.context).scaffoldBackgroundColor;
      if (widget.backGroundColor == Apptheme.noColor) {
        lateBackGroundColor = Theme.of(widget.context).scaffoldBackgroundColor;
      } else {
        lateBackGroundColor = widget.backGroundColor;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _incrementEnter,
      onExit: _incrementExit,
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: lateBackGroundColor,
            border: Border.all(
                width: 1, color: isHover ? borderColor : hoverColor)),
        child: widget.child,
      ),
    );
  }
}

class NavigationItem extends StatefulWidget {
  const NavigationItem({
    super.key,
    required this.buttonName,
    required this.isChallenge,
    required this.onItemSelection,
    required this.isSelected,
  });

  final String buttonName;
  final VoidCallback onItemSelection;
  final bool isChallenge;
  final bool isSelected;

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
          onTap: () {
            widget.onItemSelection();
          },
          onHover: (val) {
            setState(() {
              isHovered = val;
            });
          },
          child: Container(
              padding: EdgeInsets.all(isHovered ? 7 : 8),
              decoration: isHovered
                  ? BoxDecoration(
                      color: widget.isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                          width: 1, color: Theme.of(context).primaryColor))
                  : BoxDecoration(
                      color: widget.isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).scaffoldBackgroundColor,
                    ),
              child: widget.isChallenge
                  ? RichText(
                      text: TextSpan(
                        text: widget.buttonName,
                        style: widget.isSelected
                            ? Apptheme.labelMedium.copyWith(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontWeight: FontWeight.w400)
                            : Apptheme.labelMedium.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w400),
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        text: widget.buttonName,
                        style: widget.isSelected
                            ? Apptheme.labelMedium.copyWith(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontWeight: FontWeight.w600)
                            : Apptheme.labelMedium.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600),
                      ),
                    ))),
    );
  }
}

class ParagraphLayout {
  //provide a layout-type parameters or directly call a method to use this widget.
  const ParagraphLayout({
    required this.layoutType,
    required this.titleTextDisplay,
    required this.titleText,
    required this.subtitleText,
    required this.contentText,
    required this.imageLink,
    required this.context,
    required this.linkAddress,
    required this.navigation,
  });

  final String layoutType;
  final bool titleTextDisplay;
  final String titleText;
  final String subtitleText;
  final String contentText;
  final String imageLink;
  final BuildContext context;
  final LinkAddress linkAddress;
  final ValueSetter<LinkAddress> navigation;

  Widget linkToSeeMore() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            navigation(linkAddress);
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'See More >>',
              style: Apptheme.bodyLarge.copyWith(color: Apptheme.blue),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget imageComponent() {
    if (imageLink != "") {
      return Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: ImageWithOverlay(imageLink),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget titleTextComponent() {
    if (titleText != "") {
      return Column(
        children: <Widget>[
          titleText != ""
              ? Text(titleText, style: Apptheme.titleLarge)
              : const SizedBox(),
          titleText != ""
              ? const SizedBox(
                  height: 12,
                )
              : const SizedBox(),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget subtitleTextComponent() {
    return Column(
      children: <Widget>[
        subtitleText != ""
            ? Text(subtitleText,
                style: Apptheme.labelLarge.copyWith(
                    color: Apptheme.blue, fontWeight: FontWeight.w700))
            : const SizedBox(),
        subtitleText != ""
            ? const SizedBox(
                height: 12,
              )
            : const SizedBox(),
      ],
    );
  }

  Widget contentTextComponent() {
    return RichText(
        text: TextSpan(children: [
      const WidgetSpan(
          child: SizedBox(
        width: 30,
      )),
      TextSpan(text: contentText, style: Apptheme.bodyLarge)
    ]));
  }

  Widget textOnly() {
    return SizedBox(
//      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleTextComponent(),
                subtitleTextComponent(),
              ],
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Column(
              children: [
                contentTextComponent(),
                linkAddress.active ? linkToSeeMore() : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget columnImage() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleTextComponent(),
          subtitleTextComponent(),
          imageComponent(),
          const SizedBox(
            height: 8,
          ),
          contentTextComponent(),
          linkAddress.active ? linkToSeeMore() : const SizedBox(),
        ],
      ),
    );
  }

  Widget leftImage() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleTextComponent(),
          subtitleTextComponent(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: imageComponent(),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      contentTextComponent(),
                      linkAddress.active ? linkToSeeMore() : const SizedBox(),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget rightImage() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleTextComponent(),
          subtitleTextComponent(),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      contentTextComponent(),
                      linkAddress.active ? linkToSeeMore() : const SizedBox(),
                    ],
                  )),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 1,
                child: imageComponent(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget statement() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Theme.of(context).hoverColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(titleText, style: Apptheme.labelLarge),
            const SizedBox(
              height: 12,
            ),
            Text(contentText, style: Apptheme.headlineMedium),
            const SizedBox(
              height: 24,
            ),
          ],
        ));
  }

  Widget layoutSelector() {
    if (layoutType == 'left') {
      return leftImage();
    }
    if (layoutType == 'right') {
      return rightImage();
    }
    if (layoutType == 'column') {
      return columnImage();
    }
    if (layoutType == 'statement') {
      return statement();
    }
    if (layoutType == 'onlyText') {
      return textOnly();
    } else {
      return const Align(
        alignment: Alignment.center,
        child: Text("layout not definied"),
      );
    }
  }

  Widget layoutBuild(layoutType) {
    if (layoutType == 'left') {
      return leftImage();
    }
    if (layoutType == 'right') {
      return rightImage();
    }
    if (layoutType == 'column') {
      return rightImage();
    }
    if (layoutType == 'statement') {
      return rightImage();
    }
    if (layoutType == 'onlyText') {
      return rightImage();
    } else {
      return const Text('Layout parameter incorrect. Name widget directly');
    }
  }
}

class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;

  const ColumnBuilder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: List.generate(itemCount, (index) => itemBuilder(context, index))
          .toList(),
    );
  }
}

class RowBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;

  const RowBuilder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: List.generate(itemCount, (index) => itemBuilder(context, index))
          .toList(),
    );
  }
}
