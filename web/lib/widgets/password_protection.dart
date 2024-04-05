import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:howard_chen_portfolio/main.dart';
import 'package:howard_chen_portfolio/widgets/utility_widgets.dart';
import '../style/app_theme.dart';
import 'navigation.dart';

class UnlockButton extends StatefulWidget {
  const UnlockButton({
    this.isDialog = false,
    this.highContrast = false,
    super.key,
  });

  final bool isDialog;
  final bool highContrast;

  @override
  State<StatefulWidget> createState() => _UnlockButtonState();
}

class _UnlockButtonState extends State<UnlockButton> {
  late bool showInputBox;
  bool validate = false;

  final myController = TextEditingController();

  @override
  void initState() {
    showInputBox = widget.isDialog;
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (unlocked == false && showInputBox == false) {
      return HoverEffect(
        highContrast: widget.highContrast,
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.lock,
              size: 24,
              color: widget.highContrast
                  ? Theme.of(universalContext).scaffoldBackgroundColor
                  : Theme.of(universalContext).primaryColor,
            ),
            Styling.contentMediumSpacing,
            Expanded(
              child: Text(
                  style: widget.highContrast
                      ? Apptheme.labelSmall.copyWith(
                          color: Theme.of(universalContext)
                              .scaffoldBackgroundColor)
                      : Apptheme.labelSmall,
                  'Portfolio is locked, Please enter password to view Locked content.'),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            showInputBox = true;
          });
        },
      );
    }
    if (unlocked == false && showInputBox == true) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(

              style: Apptheme.bodyLarge.copyWith(
                  color: widget.highContrast
                      ? Theme.of(universalContext).scaffoldBackgroundColor
                      : Theme.of(universalContext).primaryColor),
              onSubmitted: (value) {
                if (myController.text == 'TallGiraffe') {
                  navigateToUnlockedHome(context);
                  context.pop();
                } else {
                  setState(() {
                    validate = true;
                  });
                }
              },
              controller: myController,
              textInputAction: TextInputAction.go,
              decoration: Styling.defaultInputDecoration(
                  'Enter the password', 'Password Incorrect', validate, highContrast: widget.highContrast),
            ),
          ),
          Styling.contentMediumSpacing,
          HoverEffect(
            highContrast: widget.highContrast,
              onTap: () {
                if (myController.text == 'TallGiraffe') {
                  navigateToUnlockedHome(context);
                  context.pop();
                } else {
                  setState(() {
                    validate = true;
                  });
                }
              },
              child: Icon(FontAwesomeIcons.circleArrowRight,
                  color: widget.highContrast
                      ? Theme.of(universalContext).scaffoldBackgroundColor
                      : Theme.of(universalContext).primaryColor))
        ],
      );
    } else {
      return Styling.defaultPaper(
        highContrast: widget.highContrast,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(FontAwesomeIcons.unlock,
                size: 24, color: Theme.of(context).splashColor),
            Styling.contentMediumSpacing,
            Expanded(
                child: Text(
                    style: Apptheme.labelSmall
                        .copyWith(color: Theme.of(context).splashColor),
                    'Portfolio is now unlocked')),
          ],
        ),
      );
    }
  }
}
