import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'json_parse.dart';
import 'tools.dart';
import 'package:books_finder/books_finder.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection(
      {super.key,
      required this.navigateToProjects,
      //required this.bookIRead,
      //required this.bookRecommended
      });

  final ValueSetter<LinkAddress> navigateToProjects;
  //final List<Book> bookIRead;
  //final List<Book> bookRecommended;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 1600),
            child: Row(
              children: [
                const SizedBox(
                  width: 32,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          navigateToProjects(LinkAddress(0, 0, 0));
                        },
                        child: HoverEffect(
                          transparentBackground: true,
                          context: context,
                          child: const Row(
                            children: [
                              Icon(Icons.arrow_back),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Back to home",
                                style: Apptheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Hi! I am Howard, \n",
                            style: Apptheme.headlineLarge.copyWith(
                                color: Theme.of(context).primaryColorLight)),
                        TextSpan(
                            text:
                                "A designer, book lover, a guitarist a badminton lover",
                            style: Apptheme.headlineLarge.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text:
                                "fascinated by culture all around the world and has travelled to have currently settle in the UK",
                            style: Apptheme.headlineLarge.copyWith(
                                color: Theme.of(context).primaryColorLight)),
                      ]))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
