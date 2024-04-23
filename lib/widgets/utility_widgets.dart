import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:howard_chen_portfolio/main.dart';
import 'package:howard_chen_portfolio/widgets/password_protection.dart';
import 'package:url_launcher/url_launcher.dart';
import '../style/app_theme.dart';
import '../functions/network.dart';

List<TextSpan> AddLink(List<TextSpan> content, String link) {
  content.add(TextSpan(
      text: "... Read More on Google Books",
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          launchUrlFuture(link);
        }));
  return content;
}

TextSpan SplitCSSParagraphs(String content) {
  List<TextSpan> contentList = [];
  RegExp pattern = RegExp(r'<p>|<br>');

  String cleanContent =
      content.replaceAll("</p>", "\n").replaceAll("<br><br>", "<br>").replaceAll("<br>", "<br>\n");

  for (int i = 0; i < cleanContent.split(pattern).length; i++) {
    contentList
        .add(ImplementCSS(TextSpan(text: cleanContent.split(pattern)[i])));
  }

  return TextSpan(
      children: contentList,
      style: Apptheme.bodyMedium.copyWith(fontWeight: FontWeight.w300));
}

TextSpan ImplementCSS(TextSpan content) {
  String? text = content.text;
  TextStyle? textStyle = Apptheme.bodyMedium;
  if (text!.contains("<b>")) {
    text = text.replaceAll("<b>", "");
    textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
  }
  if (text!.contains("</b>")) {
    text = text.replaceAll("</b>", "");
  }
  if (content.text!.contains("<i>")) {
    text = text.replaceAll("<i>", "").replaceAll("</i>", "");
  }
  return TextSpan(text: text, style: textStyle);
}

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    super.key,
    required this.buttonTitle,
    required this.buttonDescription,
    required this.onToggle,
    this.isActive = false,
    this.isSelected = false,
  });

  final String buttonTitle;
  final String buttonDescription;
  final Function()? onToggle;
  final bool isActive;
  final bool isSelected;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  late bool isHover = false;
  late bool _isSelected;
  late BoxDecoration decoration;
  late TextStyle textStyle;

  @override
  void initState() {
    decoration = Styling.defaultTabState;
    _isSelected = widget.isSelected;
    super.initState();
  }

  @override
  void didUpdateWidget(ToggleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      setState(() {
        decoration = Styling.defaultTabState;
        _isSelected = widget.isSelected;
      });
    }
  }

  void _incrementEnter(PointerEvent details) {
    setState(() {
      isHover = true;
      decoration = Styling.hoveredTabState;
    });
  }

  void _incrementExit(PointerEvent details) {
    setState(() {
      isHover = false;
      if (widget.isSelected == true) {
        decoration = Styling.focusTabState;
      } else {
        decoration = Styling.defaultTabState;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _incrementEnter,
      onExit: _incrementExit,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onToggle,
        child: Container(
          padding: const EdgeInsets.only(bottom: 4),
          decoration: _isSelected ? Styling.focusTabState : decoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.buttonTitle,
                style: Apptheme.titleLarge.copyWith(color: Apptheme.prime700),
              ),
              Text(
                widget.buttonDescription,
                style: Apptheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HoverEffect extends StatefulWidget {
  const HoverEffect({
    super.key,
    this.backGroundColor = Apptheme.noColor,
    this.highContrast = false,
    this.transparentBackground = false,
    required this.onTap,
    required this.child,
  });

  final bool transparentBackground;
  final bool highContrast;
  final Color backGroundColor;
  final Function()? onTap;
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
    if (widget.transparentBackground == true && widget.highContrast != true) {
      borderColor = Apptheme.noColor;
      hoverColor = Theme.of(universalContext).scaffoldBackgroundColor;
      lateBackGroundColor = Apptheme.noColor;
      return;
    }
    if (widget.transparentBackground != true && widget.highContrast == true) {
      borderColor = Apptheme.noColor;
      hoverColor = Theme.of(universalContext).scaffoldBackgroundColor;
      lateBackGroundColor = Theme.of(universalContext).primaryColorDark;
      return;
    } else {
      borderColor = Theme.of(universalContext).scaffoldBackgroundColor;
      hoverColor = Theme.of(universalContext).primaryColor;
      if (widget.backGroundColor == Apptheme.noColor) {
        lateBackGroundColor =
            Theme.of(universalContext).scaffoldBackgroundColor;
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
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: Styling.smallPadding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: lateBackGroundColor,
              border: Border.all(
                  width: 1, color: isHover ? hoverColor : borderColor)),
          child: widget.child,
        ),
      ),
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
  });

  final String layoutType;
  final bool titleTextDisplay;
  final String titleText;
  final String subtitleText;
  final String contentText;
  final String imageLink;

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
        padding: Styling.mediumPadding,
        decoration: BoxDecoration(color: Theme.of(universalContext).hoverColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Styling.contentSmallSpacing,
            Text(titleText, style: Apptheme.labelLarge),
            Styling.contentSmallSpacing,
            Text(contentText, style: Apptheme.headlineSmall),
            Styling.contentSmallSpacing,
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

class QuickLinks extends StatelessWidget {
  const QuickLinks(
      {super.key, this.highContrast = false, this.hasPadding = true});

  final bool hasPadding;
  final bool highContrast;

  @override
  Widget build(BuildContext context) {
    return Styling.defaultPaper(
      hasPadding: hasPadding,
      highContrast: highContrast,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              HoverEffect(
                highContrast: highContrast,
                child: Icon(
                  Icons.mail_rounded,
                  size: 24,
                  color: highContrast
                      ? Theme.of(universalContext).scaffoldBackgroundColor
                      : Theme.of(universalContext).primaryColor,
                ),
                onTap: () {
                  launchUrlFuture('mailto:howard8479@gmail.com');
                },
              ),
              Styling.contentSmallSpacing,
              HoverEffect(
                highContrast: highContrast,
                child: Icon(
                  FontAwesomeIcons.linkedinIn,
                  size: 24,
                  color: highContrast
                      ? Theme.of(universalContext).scaffoldBackgroundColor
                      : Theme.of(universalContext).primaryColor,
                ),
                onTap: () {
                  launchUrlFuture('https://www.linkedin.com/in/howard-h-chen/');
                },
              ),
            ],
          ),
          highContrast
              ? Styling.dividerSmallSpacingHighContrast
              : Styling.dividerSmallSpacing,
          UnlockButton(
            highContrast: highContrast,
          ),
        ],
      ),
    );
  }
}

Future<void> launchUrlFuture(String webpagelink) async {
  if (!await launchUrl(Uri.parse(webpagelink))) {
    throw Exception(webpagelink);
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Styling.mediumPadding,
      width: double.infinity,
      decoration:
          BoxDecoration(color: Theme.of(universalContext).primaryColorDark),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 1400),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Styling.contentLargeSpacing,
                      Text(
                        'Due to NDA constrains some of the images may not be available. Please feel free to reach out if you are interested in learning more about my work.',
                        style: Apptheme.bodyMedium.copyWith(
                            color: Theme.of(universalContext)
                                .scaffoldBackgroundColor),
                      ),
                      Styling.contentMediumSpacing,
                      Text(
                        'This websire contains sensitive information. Please do not replicate and redistribute the content',
                        style: Apptheme.bodyMedium.copyWith(
                            color: Theme.of(universalContext)
                                .scaffoldBackgroundColor),
                      ),
                      Styling.contentMediumSpacing,
                      Text(
                        'For any inquiry please reach hobing.tan@gmail.com',
                        style: Apptheme.bodyMedium.copyWith(
                            color: Theme.of(universalContext)
                                .scaffoldBackgroundColor),
                      ),
                    ],
                  ),
                ),
                Styling.contentMediumSpacing,
                const Expanded(
                  child: QuickLinks(
                    hasPadding: false,
                    highContrast: true,
                  ),
                ),
              ],
            ),
          ),
          Styling.contentLargeSpacing,
        ],
      ),
    );
  }
}
