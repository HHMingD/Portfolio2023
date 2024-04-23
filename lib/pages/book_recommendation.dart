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
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: "Why not connect over books? ",
                style: Apptheme.headlineLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor)),
            TextSpan(
                text: "Share a book with me and I will share you mine!",
                style: Apptheme.headlineLarge
                    .copyWith(color: Theme.of(context).primaryColorLight)),
          ])),
          Styling.contentLargeSpacing,
          const BookCollectionTabs(),
          Styling.contentLargeSpacing,
          Styling.defaultPaper(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Recommend me some book? ',
                  style: Apptheme.titleMedium),
              Styling.contentSmallSpacing,
              const RecommendBook(),
            ],
          )),
        ],
      ),
    );
  }
}

class BookCollectionTabs extends StatefulWidget {
  const BookCollectionTabs({super.key});

  @override
  State<BookCollectionTabs> createState() => _BookCollectionTabsState();
}

class _BookCollectionTabsState extends State<BookCollectionTabs> {
  late int selectionIndex;
  late CollectionReference bookCollections;

  @override
  void initState() {
    selectionIndex = 0;
    bookCollections = booksIRead;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Styling.defaultPaper(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    children: [
                      ToggleButton(
                          buttonTitle: "Read",
                          buttonDescription: "Books I finished",
                          isActive: true,
                          isSelected: selectionIndex == 0,
                          onToggle: () {
                            setState(() {
                              selectionIndex = 0;
                              bookCollections = booksIRead;
                            });
                          }),
                    ],
                  ),
                  Styling.contentLargeSpacing,
                  Column(
                    children: [
                      ToggleButton(
                          buttonTitle: "Reading",
                          buttonDescription: "Books I am reading",
                          isActive: true,
                          isSelected: selectionIndex == 1,
                          onToggle: () {
                            setState(() {
                              selectionIndex = 1;
                              bookCollections = booksInProgress;
                            });
                          }),
                    ],
                  ),
                  Styling.contentLargeSpacing,
                  Column(
                    children: [
                      ToggleButton(
                          buttonTitle: "Recommmended",
                          buttonDescription: "Books Recommended to Me",
                          isActive: true,
                          isSelected: selectionIndex == 2,
                          onToggle: () {
                            setState(() {
                              selectionIndex = 2;
                              bookCollections = booksRecommended;
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
            FetchBookCollection(
                key: GlobalKey(), bookCollections: bookCollections),
          ],
        ));
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

  List<Widget> books = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCollection(widget.bookCollections),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.size != 0) {
              books = [];
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
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
            );
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
      bookSearchWidgets = [];
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
            ? Text(
                searchTerms,
                style: Apptheme.labelMedium,
              )
            : const SizedBox(),
        Styling.contentSmallSpacing,
        bookSearched
            ? Column(
                children: bookSearchWidgets,
              )
            : SizedBox(
                height: 400,
                child: Center(
                    child: Text(
                        style: Apptheme.labelSmall
                            .copyWith(color: Apptheme.prime200),
                        'Start the search above')),
              ),
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
  late FocusNode focusToCandidate;

  @override
  void initState() {
    focusToCandidate = FocusNode();
    focusToCandidate.addListener(() {
      if (focusToCandidate.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Scrollable.ensureVisible(
            focusToCandidate.context!,
            duration: const Duration(milliseconds: 250),
            alignment:
                0.5, // Adjust alignment for better control of the item's final position
          );
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    focusToCandidate.dispose();
    reasonController.dispose();
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

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
              print(widget.bookClass.id);
              setState(() {
                bookSelected = true;
              });
              focusToCandidate.requestFocus();
            },
          ),
          Styling.contentSmallSpacing,
          Focus(
            focusNode: focusToCandidate,
            child: bookSelected
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Name (Optional)',
                        style: Apptheme.labelMedium,
                      ),
                      Styling.contentSmallSpacing,
                      TextField(
                        controller: nameController,
                        decoration: Styling.defaultInputDecoration(
                            'Enter Name', 'Error!', false),
                      ),
                      Styling.contentMediumSpacing,
                      const Text(
                        'Email address for future contact? (optional) (Private)',
                        style: Apptheme.labelMedium,
                      ),
                      const Text(
                        '(So that I can contact you! The information will not be made   public.)',
                        style: Apptheme.bodyMedium,
                      ),
                      Styling.contentSmallSpacing,
                      TextField(
                        controller: addressController,
                        decoration: Styling.defaultInputDecoration(
                            'Enter Email Address', 'Error!', false),
                      ),
                      Styling.contentMediumSpacing,
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
                          const Expanded(
                            child: Text(
                                'Want to keep the name and the message a secret?'),
                          )
                        ],
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
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      ),
      secondChild: SizedBox(
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
  final int pageNumbers;

  Widget _Pagination(BuildContext context, int totalCount) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RowBuilder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: HoverEffect(
                    highContrast: index + 1 == pageNumbers,
                    onTap: () {
                      navigateToBookList(
                          context, referenceCollection, index + 1);
                    },
                    child: Text("${index + 1}",
                        style: index + 1 == pageNumbers
                            ? Apptheme.labelSmall
                                .copyWith(color: Apptheme.white)
                            : Apptheme.labelSmall)),
              );
            },
            itemCount: (totalCount / 10).ceil()),
        Visibility(
          visible: totalCount > pageNumbers * 10,
          child: HoverEffect(
              onTap: () {
                navigateToBookList(
                    context, referenceCollection, pageNumbers + 1);
              },
              child: const Text("Next Page", style: Apptheme.labelSmall)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Styling.pageFrame(
        child: Column(
      children: [
        Styling.contentLargeSpacing,
        Styling.defaultPaper(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection(referenceCollection)
                  .orderBy('addedBy', descending: true)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        referenceCollection.replaceAll(RegExp('_'), ' '),
                        style: Apptheme.headlineSmall,
                      ),
                      Styling.contentMediumSpacing,
                      ColumnBuilder(
                        itemBuilder: (BuildContext context, int index) {
                          return bookandComment(snapshot
                              .data!.docs[index + 10 * (pageNumbers - 1)]);
                        },
                        itemCount: snapshot.data!.docs.length < pageNumbers
                            ? snapshot.data!.docs.length
                            : snapshot.data!.docs.length -
                                ((pageNumbers - 1) * 10),
                      ),
                      Styling.contentMediumSpacing,
                      _Pagination(context, snapshot.data!.docs.length),
                    ],
                  );
                } else {
                  return const Column(
                    children: [Text('name')],
                  );
                }
              }),
        ),
      ],
    ));
  }
}

Widget bookandComment(dynamic data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Styling.contentSmallSpacing,
      FetchBook(
          id: data['bookID'],
          verticalPadding: false,
          hasSecondaryAction: false),
      data['isRecommended']
          ? Column(
              children: [
                Styling.contentMediumSpacing,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Apptheme.prime100,
                      borderRadius: BorderRadius.circular(10)),
                  padding: Styling.smallPadding,
                  child: data['reasonIsASecret'] || data['recommendedBy'] == ""
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
