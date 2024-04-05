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
                  Expanded(
                      flex: 1,
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
                  Styling.contentSmallSpacing,
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Currently Reading:',
                                style: Apptheme.bodyLarge,
                              ),
                              Text(
                                snapshot.data!.info.title,
                                style: Apptheme.labelLarge,
                              ),
                            ],
                          ),
                          HoverEffect(
                            onTap: () {
                              navigateToBookExchange(context);
                            },
                            backGroundColor: Apptheme.prime100,
                            child: const Text('Go to Book exchange'),
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

class FetchBook extends StatelessWidget {
  const FetchBook({
    super.key,
    required this.id,
    required this.verticalPadding,
  });

  final String id;
  final bool verticalPadding;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSpecificBook(id),
        builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
          if (snapshot.hasData) {
            return DisplayBook(
              bookClass: snapshot.data!,
              verticalPadding: verticalPadding,
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

class DisplayBook extends StatelessWidget {
  const DisplayBook({
    super.key,
    required this.bookClass,
    this.hasSecondaryAction = false,
    this.verticalPadding = false,
    this.secondayAction = emptyAction,
  });

  final bool hasSecondaryAction;
  final bool verticalPadding;
  final Book bookClass;
  final VoidCallback secondayAction;

  Widget _titleRow() => Text(bookClass.info.title,maxLines: 1, style: Apptheme.titleSmall);

  Widget _secondaryAction() => hasSecondaryAction
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
              child: const Text('See more >>', style: Apptheme.labelMedium)),
        );

  Widget _image() => bookClass.info.imageLinks['thumbnail'] != null
      ? Image.network(bookClass.info.imageLinks['thumbnail'].toString())
      : Container(
          height: double.infinity,
          width: double.infinity,
          padding: Styling.smallPadding,
          decoration: const BoxDecoration(color: Apptheme.prime100),
          child: const Center(child: Text('No book cover available')));

  Widget _authorDescription() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bookClass.info.authors.isNotEmpty
              ? Text(bookClass.info.authors.first, style: Apptheme.bodyMedium)
              : const Text("Author name unavailable",
                  style: Apptheme.bodyMedium),
          Text(
            bookClass.info.description,
            style: Apptheme.bodyMedium,
            maxLines: 5,
          )
        ],
      );

  Widget _desktop() => Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ? 12 : 0),
        height: 240,
        child: Row(
          children: [
            Expanded(flex: 1, child: _image()),
            Styling.contentMediumSpacing,
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titleRow(),
                  _authorDescription(),
                  _secondaryAction(),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _mobile() => Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ? 12 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleRow(),
            Styling.contentSmallSpacing,
            SizedBox(
              width: double.infinity,
              height: 240,
              child: _image(),
            ),
            Styling.contentSmallSpacing,
            _authorDescription(),
            _secondaryAction(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (deviceIsDesktop) {
      return _desktop();
    } else {
      return _mobile();
    }
  }
}
