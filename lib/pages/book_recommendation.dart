import 'package:books_finder/books_finder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import '../style/app_theme.dart';
import '../widgets/book_utilities.dart';
import '../widgets/navigation.dart';
import '../widgets/utility_widgets.dart';

class BookExchangePageFrame extends StatelessWidget {
  const BookExchangePageFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Styling.pageFrame(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Column(
          children: [
            Styling.contentLargeSpacing,
            HoverEffect(
              onTap: () {
                navigateToLockedHome(context);
              },
              transparentBackground: true,
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
            Styling.contentSmallSpacing,
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "I wish to read the best book there ever is.\n",
                  style: Apptheme.headlineLarge
                      .copyWith(color: Theme.of(context).primaryColorLight)),
              TextSpan(
                  text: "So why not connect over books? ",
                  style: Apptheme.headlineLarge.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor)),
              TextSpan(
                  text: "Share a book with me and I will share you mine!",
                  style: Apptheme.headlineLarge
                      .copyWith(color: Theme.of(context).primaryColorLight)),
            ])),
            Styling.contentLargeSpacing,
            Styling.defaultPaper(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Book exchange programme',
                    style: Apptheme.headlineSmall),
                Styling.contentSmallSpacing,
                const Text(
                    'Here, You can find the books I am currently reading, the books I have finished with my thoughts on them, and the books that has been recommended to me.',
                    style: Apptheme.bodyLarge),
                Styling.dividerLargeSpacing,
                const Text('Books Currently Reading:',
                    style: Apptheme.titleMedium),
                Styling.contentSmallSpacing,
                FetchBookCollection(
                    key: GlobalKey(), bookCollections: booksInProgress),
                Styling.contentMediumSpacing,
                const Text('Books Recently Finished',
                    style: Apptheme.titleMedium),
                Styling.contentSmallSpacing,
                FetchBookCollection(
                    key: GlobalKey(), bookCollections: booksIRead),
                Styling.contentMediumSpacing,
                const Text('Books Recommended to me ',
                    style: Apptheme.titleMedium),
                Styling.contentSmallSpacing,
                FetchBookCollection(
                    key: GlobalKey(), bookCollections: booksRecommended),
                Styling.contentMediumSpacing,
                const Text('Recommend me some book? ',
                    style: Apptheme.titleMedium),
                Styling.contentSmallSpacing,
                const RecommendBook(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class BookExchangeIntroduction extends StatelessWidget {
  const BookExchangeIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Book Exchange:',
          style: Apptheme.titleMedium,
        ),
        Styling.contentSmallSpacing,
        const Text(
            'Interested in Sharing some book recommendations? Head to the Book exchange page for more',
            style: Apptheme.bodyLarge),
        Styling.contentSmallSpacing,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future:
                    booksInProgress.orderBy('addedBy', descending: true).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data?.docs != []) {
                    return QuickBookPreview(
                        id: snapshot.data!.docs[0]['bookID']);
                  } else {
                    return const Text(
                        'Out of book to read! Recommended me some nice ones?',
                        style: Apptheme.labelMedium);
                  }
                })
          ],
        ),
      ],
    );
  }
}

class FetchBookCollection extends StatefulWidget {
  const FetchBookCollection({super.key, required this.bookCollections});

  final CollectionReference bookCollections;

  @override
  State<StatefulWidget> createState() => _FetchBookCollectionState();
}

class _FetchBookCollectionState extends State<FetchBookCollection> {
  Future<QuerySnapshot> getCollection(CollectionReference reference) async {
    return reference.orderBy('addedBy', descending: true).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCollection(widget.bookCollections),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.size != 0) {
              List<Widget> books = [];
              for (int i = 0; i < snapshot.data!.docs.length && i < 3; i++) {
                books.add(bookandComment(snapshot.data!.docs[i]));
              }
              if (snapshot.data!.size > 3) {
                books.add(HoverEffect(
                    highContrast: true,
                    onTap: () {
                      navigateToBookList(context, widget.bookCollections.id, 1);
                    },
                    child: Text('See the whole list',
                        style: Apptheme.labelMedium
                            .copyWith(color: Theme.of(context).hoverColor))));
              }
              return Column(
                children: books,
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'No books here yet',
                    style:
                        Apptheme.labelSmall.copyWith(color: Apptheme.prime200),
                  ),
                ),
              );
            }
          } else {
            return Container();
          }
        });
  }
}

class RecommendBook extends StatefulWidget {
  const RecommendBook({super.key});

  @override
  State<StatefulWidget> createState() => _RecommendBookState();
}

class _RecommendBookState extends State<RecommendBook> {
  late String bookTitleToSearch;
  bool validate = false;
  bool bookSearched = false;
  bool bookAdded = false;

  List<Book> bookSearchResults = [];
  List<BookCandidates> bookSearchWidgets = [];
  final myController = TextEditingController();
  late String searchTerms;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void searchBookRoutine(String text) {
    searchBooks(text).then((value) {
      setState(() {
        if (value.isNotEmpty) {
          searchTerms = "Search result for: ${myController.text}";
        } else {
          searchTerms = 'No books found, try something different?';
        }
      });
      bookSearchWidgets  = [];
      for (int i = 0; i < value.length; i++) {
        bookSearchWidgets.add(BookCandidates(
          key: GlobalKey(),
          bookClass: value[i],
        ));
      }
      bookSearched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                style: Apptheme.bodyLarge
                    .copyWith(color: Theme.of(universalContext).primaryColor),
                onSubmitted: (value) {
                  if (myController.text != '') {
                    bookSearchWidgets = [];
                    searchBookRoutine(myController.text);
                  } else {
                    setState(() {
                      validate = true;
                    });
                  }
                },
                controller: myController,
                textInputAction: TextInputAction.go,
                decoration: Styling.defaultInputDecoration(
                        'Enter Book Title', 'Field is empty', validate)
                    .copyWith(
                        labelText: 'Search the book through Google Books:'),
              ),
            ),
            Styling.contentSmallSpacing,
            HoverEffect(
                highContrast: true,
                onTap: () {
                  searchBookRoutine(myController.text);
                },
                child: Text("Search",
                    style: Apptheme.labelMedium
                        .copyWith(color: Theme.of(context).hoverColor))),
          ],
        ),
        Styling.contentSmallSpacing,
        bookSearched
            ? Column(
                children: [
                  Styling.contentSmallSpacing,
                  Text(
                    searchTerms,
                    style: Apptheme.labelMedium,
                  ),
                  Styling.contentSmallSpacing,
                ],
              )
            : const SizedBox(),
        bookSearched
            ? Column(
                children: bookSearchWidgets,
              )
            : const SizedBox(),
      ],
    );
  }
}

class BookCandidates extends StatefulWidget {
  const BookCandidates({super.key, required this.bookClass});

  final Book bookClass;

  @override
  State<StatefulWidget> createState() => _BookCandidatesState();
}

class _BookCandidatesState extends State<BookCandidates> {
  final reasonController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  bool bookSelected = false;
  bool bookAdded = false;
  bool messageIsPrivate = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 250),
      firstChild: Column(
        children: [
          DisplayBook(
            key: GlobalKey(),
            bookClass: widget.bookClass,
            verticalPadding: true,
            hasSecondaryAction: true,
            secondayAction: () {
              setState(() {
                bookSelected = true;
              });
            },
          ),
          Styling.contentSmallSpacing,
          bookSelected
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Styling.dividerSmallSpacing,
                    messageIsPrivate
                        ? const Text(
                            'Why do you think this book is worth reading? (Optional) (Private)',
                            style: Apptheme.labelMedium,
                          )
                        : const Text(
                            'Why do you think this book is worth reading? (Optional)',
                            style: Apptheme.labelMedium,
                          ),
                    Styling.contentSmallSpacing,
                    TextField(
                      controller: reasonController,
                      decoration: Styling.defaultInputDecoration(
                          'Share your thoughts...', 'Error!', false),
                    ),
                    Styling.contentSmallSpacing,
                    messageIsPrivate
                        ? const Text(
                            'Your Name (Optional) (Private)',
                            style: Apptheme.labelMedium,
                          )
                        : const Text(
                            'Your Name (Optional)',
                            style: Apptheme.labelMedium,
                          ),
                    Styling.contentSmallSpacing,
                    TextField(
                      controller: nameController,
                      decoration: Styling.defaultInputDecoration(
                          'Enter Name', 'Error!', false),
                    ),
                    Styling.contentSmallSpacing,
                    Row(
                      children: [
                        Checkbox(
                            value: messageIsPrivate,
                            onChanged: (private) {
                              setState(() {
                                messageIsPrivate = private!;
                              });
                            }),
                        Styling.contentSmallSpacing,
                        const Text(
                            'Want to keep the name and the message a secret?')
                      ],
                    ),
                    Styling.contentSmallSpacing,
                    const Text(
                      'Email address for future contact? (optional) (Private)',
                      style: Apptheme.labelMedium,
                    ),
                    const Text(
                      '(Contact details will be not be shared publicly and will be removed after an year.)',
                      style: Apptheme.bodyMedium,
                    ),
                    Styling.contentSmallSpacing,
                    TextField(
                      controller: addressController,
                      decoration: Styling.defaultInputDecoration(
                          'Enter Email Address', 'Error!', false),
                    ),
                    Styling.contentMediumSpacing,
                    HoverEffect(
                        highContrast: true,
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('Books_Recommended')
                              .doc(widget.bookClass.info.title)
                              .set({
                            "bookName": widget.bookClass.info.title,
                            "bookID": widget.bookClass.id,
                            "reason": reasonController.text,
                            "reasonIsASecret": messageIsPrivate,
                            "isRecommended": true,
                            "recommendedBy": nameController.text,
                            "contact": addressController.text,
                            "addedBy":
                                "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().second}${DateTime.now().minute}",
                          });
                          setState(() {
                            bookAdded = true;
                            bookSelected = false;
                          });
                        },
                        child: Text(
                          'Add the book to the recommendation List',
                          style: Apptheme.labelMedium
                              .copyWith(color: Theme.of(context).hoverColor),
                        )),
                    Styling.contentMediumSpacing,
                  ],
                )
              : const SizedBox(),
        ],
      ),
      secondChild: Container(
        height: deviceIsDesktop ? 400 : 300,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.check,
              color: Colors.lightGreen,
            ),
            Styling.contentSmallSpacing,
            const Text('Thank you for recommending a book to me!'),
            Styling.contentSmallSpacing,
            HoverEffect(
                backGroundColor: Apptheme.prime100,
                onTap: () {
                  navigateToAboutMe(context);
                },
                child: const Text('Back to About Me'))
          ],
        ),
      ),
      crossFadeState:
          bookAdded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}

class ShowAllBooks extends StatelessWidget {
  const ShowAllBooks({
    super.key,
    required this.referenceCollection,
    required this.pageNumbers,
  });

  final String referenceCollection;
  final String pageNumbers;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Styling.horizontalPadding,
              Expanded(
                  child: Column(
                children: [
                  Styling.contentLargeSpacing,
                  Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Styling.defaultPaper(
                      child: FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection(referenceCollection)
                              .orderBy('addedBy', descending: true)
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  HoverEffect(
                                    onTap: () {
                                      navigateToBookExchange(context);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.arrow_back),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Back to Book exchange",
                                          style: Apptheme.titleSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Styling.contentMediumSpacing,
                                  Text(
                                    referenceCollection.replaceAll(
                                        RegExp('_'), ' '),
                                    style: Apptheme.headlineSmall,
                                  ),
                                  Styling.contentMediumSpacing,
                                  ColumnBuilder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return bookandComment(snapshot.data!.docs[
                                          index +
                                              10 *
                                                  (int.parse(pageNumbers) -
                                                      1)]);
                                    },
                                    itemCount: snapshot.data!.docs.length < 10
                                        ? snapshot.data!.docs.length
                                        : 10,
                                  ),
                                ],
                              );
                            } else {
                              return const Column(
                                children: [Text('name')],
                              );
                            }
                          }),
                    ),
                  )
                ],
              )),
              Styling.horizontalPadding,
            ],
          ),
          Styling.contentLargeSpacing,
          const Footer(),
        ],
      ),
    );
  }
}

Widget bookandComment(dynamic data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Styling.contentSmallSpacing,
      FetchBook(id: data['bookID'], verticalPadding: false),
      data['isRecommended']
          ? Column(
              children: [
                Styling.contentMediumSpacing,
                data['reasonIsASecret']
                    ? const SizedBox()
                    : const Text(
                        'Recommended by',
                        style: Apptheme.labelSmall,
                      ),
                Styling.contentSmallSpacing,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Apptheme.prime100,
                      borderRadius: BorderRadius.circular(10)),
                  padding: Styling.smallPadding,
                  child: data['reasonIsASecret']
                      ? const Text(
                          'This person decided to keep the message secret',
                          style: Apptheme.labelMedium,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['recommendedBy'] != ""
                                  ? "${data['recommendedBy']} :"
                                  : "Anonymous :",
                              style: Apptheme.labelMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              data['reason'],
                              style: Apptheme.bodyLarge,
                            )
                          ],
                        ),
                ),
              ],
            )
          : const SizedBox(),
      Styling.contentSmallSpacing,
    ],
  );
}
