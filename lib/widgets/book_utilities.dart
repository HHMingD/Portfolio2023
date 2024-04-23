import 'package:books_finder/books_finder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:howard_chen_portfolio/widgets/utility_widgets.dart';

import '../main.dart';
import '../style/app_theme.dart';
import 'navigation.dart';

final CollectionReference booksIRead =
    FirebaseFirestore.instance.collection('Books_I_Read');
final CollectionReference booksInProgress =
    FirebaseFirestore.instance.collection('Books_In_Progress');
final CollectionReference booksRecommended =
    FirebaseFirestore.instance.collection('Books_Recommended');

Future<List<Book>> searchBooks(String query) {
  return queryBooks(
    query,
    queryType: QueryType.intitle,
    maxResults: 3,
    printType: PrintType.books,
    orderBy: OrderBy.relevance,
  );
}

void emptyAction() {}

void emptyStringAction(value) {}

class BookExchangeIntroduction extends StatelessWidget {
  const BookExchangeIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Interested in book exchange?",
                    style: Apptheme.titleMedium,
                  ),
                  const Text(
                      style: Apptheme.bodyLarge,
                      "I've found that books are very powerful tools for connections. Do you have any interesting books to share? Or are you interested in the books I am currently reading?"),
                  Styling.contentMediumSpacing,
                  Align(
                    alignment: Alignment.center,
                    child: HoverEffect(
                      highContrast: true,
                      onTap: () {
                        navigateToBookExchange(context);
                      },
                      backGroundColor: Apptheme.prime100,
                      child: Text(
                        "Go to book exchange",
                        style: Apptheme.labelMedium
                            .copyWith(color: Apptheme.white),
                      ),
                    ),
                  ),
                ],
              )),
              Styling.contentMediumSpacing,
              Container(
                decoration: BoxDecoration(
                    color: Apptheme.prime100,
                    borderRadius: BorderRadius.circular(8)),
                padding: Styling.smallPadding,
                child: FutureBuilder(
                    future: booksInProgress
                        .orderBy('addedBy', descending: true)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData && snapshot.data?.docs != []) {
                        return FutureBuilder(
                            future: getSpecificBook(
                                snapshot.data!.docs[0]['bookID']),
                            builder: (BuildContext context,
                                AsyncSnapshot<Book> snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Now reading:"),
                                    SizedBox(
                                        height: 200,
                                        child: snapshot.data!.info
                                                    .imageLinks['thumbnail'] !=
                                                null
                                            ? Image.network(snapshot.data!.info
                                                .imageLinks['thumbnail']
                                                .toString()
                                                .replaceAll(
                                                    'http://', 'https://'))
                                            : Container(
                                                height: double.infinity,
                                                width: double.infinity,
                                                padding: Styling.smallPadding,
                                                decoration: const BoxDecoration(
                                                    color: Apptheme.prime100),
                                                child: const Center(
                                                    child: Text(
                                                        'No book cover available')))),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    const Text('Loading Book...'),
                                    Styling.contentSmallSpacing,
                                    Styling.centerCircularProgressIndicator,
                                  ],
                                );
                              }
                            });
                      } else {
                        return const Text(
                            'Out of book to read! Recommended me some nice ones?',
                            style: Apptheme.labelMedium);
                      }
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class QuickBookPreview extends StatelessWidget {
  const QuickBookPreview({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSpecificBook(id),
        builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 200,
              child: Row(
                children: [
                  Container(
                      child: snapshot.data!.info.imageLinks['thumbnail'] != null
                          ? Image.network(snapshot
                              .data!.info.imageLinks['thumbnail']
                              .toString()
                              .replaceAll('http://', 'https://'))
                          : Container(
                              height: double.infinity,
                              width: double.infinity,
                              padding: Styling.smallPadding,
                              decoration:
                                  const BoxDecoration(color: Apptheme.prime100),
                              child: const Center(
                                  child: Text('No book cover available')))),
                  Styling.contentMediumSpacing,
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data!.info.title,
                            style: Apptheme.labelLarge,
                          ),
                          HoverEffect(
                            onTap: () {
                              navigateToBookExchange(context);
                            },
                            backGroundColor: Apptheme.prime100,
                            child: const Text(
                                "Curious about other books I am reading? Let's exchange books!"),
                          ),
                        ],
                      )),
                ],
              ),
            );
          } else {
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text('Loading Book ID: $id'),
                  Styling.contentSmallSpacing,
                  Styling.centerCircularProgressIndicator,
                ],
              ),
            );
          }
        });
  }
}

Widget bookPlaceHolder() => deviceIsDesktop
    ? Row(
        children: [
          Container(
              height: 220,
              width: 140,
              padding: Styling.smallPadding,
              decoration: const BoxDecoration(color: Apptheme.prime100)),
          Styling.contentMediumSpacing,
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    decoration: const BoxDecoration(color: Apptheme.prime100),
                  ),
                  Styling.contentSmallSpacing,
                  Container(
                    height: 120,
                    decoration: const BoxDecoration(color: Apptheme.prime100),
                  ),
                ],
              ))
        ],
      )
    : Column(
        children: [
          Container(
            height: 40,
            decoration: const BoxDecoration(color: Apptheme.prime100),
          ),
          Styling.contentSmallSpacing,
          Container(
              height: 220,
              width: 140,
              padding: Styling.smallPadding,
              decoration: const BoxDecoration(color: Apptheme.prime100)),
          Styling.contentSmallSpacing,
          Container(
            height: 120,
            decoration: const BoxDecoration(color: Apptheme.prime100),
          ),
        ],
      );

class FetchBook extends StatelessWidget {
  const FetchBook({
    super.key,
    required this.id,
    required this.verticalPadding,
    required this.hasSecondaryAction,
  });

  final String id;
  final bool verticalPadding;
  final bool hasSecondaryAction;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSpecificBook(id),
        builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
          if (snapshot.hasData) {
            return DisplayBook(
              bookClass: snapshot.data!,
              verticalPadding: verticalPadding,
              hasSecondaryAction: hasSecondaryAction,
            );
          } else {
            return bookPlaceHolder();
          }
        });
  }
}

class DisplayBook extends StatelessWidget {
  const DisplayBook(
      {super.key,
      required this.bookClass,
      this.hasSecondaryAction = false,
      this.verticalPadding = false,
      this.secondayAction = emptyAction});

  final bool hasSecondaryAction;
  final bool verticalPadding;
  final Book bookClass;
  final VoidCallback secondayAction;

  Widget _titleColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bookClass.info.title, maxLines: 1, style: Apptheme.titleSmall),
          Styling.contentSmallSpacing,
          bookClass.info.authors.isNotEmpty
              ? Text(bookClass.info.authors.first, style: Apptheme.labelMedium)
              : const Text("Author name unavailable",
                  style: Apptheme.bodyMedium),
        ],
      );

  Widget _secondaryAction(BuildContext context) => hasSecondaryAction
      ? Align(
          alignment: Alignment.centerRight,
          child: HoverEffect(
              backGroundColor: Theme.of(universalContext).hoverColor,
              onTap: () {
                secondayAction();
              },
              child: const Text('Recommend the book ',
                  style: Apptheme.labelMedium)))
      : Align(
          alignment: Alignment.centerRight,
          child: InkWell(
              onTap: () {
                launchUrlFuture("${bookClass.info.previewLink}");
              },
              child: const Text('View in Google Books>>',
                  style: Apptheme.bodyMedium)),
        );

  Widget _image() => bookClass.info.imageLinks['thumbnail'] != null
      ? Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Apptheme.prime100,
              spreadRadius: 6,
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ]),
          child:
              Image.network(bookClass.info.imageLinks['thumbnail'].toString()))
      : Container(
          height: 160,
          width: 120,
          padding: Styling.smallPadding,
          decoration: const BoxDecoration(color: Apptheme.prime100),
          child: const Center(child: Text('No book cover available')));

  Widget _description(BuildContext context) => RichText(
      overflow: TextOverflow.ellipsis,
      text: SplitCSSParagraphs(bookClass.info.description),
      maxLines: 5);

  Widget _desktop(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ? 12 : 0),
        child: Row(
          children: [
            _image(),
            Styling.contentLargeSpacing,
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titleColumn(),
                  Styling.contentSmallSpacing,
                  _description(context),
                  Styling.contentSmallSpacing,
                  _secondaryAction(context),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _mobile(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ? 12 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleColumn(),
            Styling.contentSmallSpacing,
            SizedBox(
              width: double.infinity,
              height: 240,
              child: _image(),
            ),
            Styling.contentSmallSpacing,
            _description(context),
            Styling.contentSmallSpacing,
            _secondaryAction(context),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return deviceIsDesktop ? _desktop(context) : _mobile(context);
  }
}
