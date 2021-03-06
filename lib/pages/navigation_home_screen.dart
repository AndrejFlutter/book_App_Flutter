import 'dart:async';

import 'package:flutter/material.dart';

import 'package:kniha_test_app/models/book_model.dart';
import 'package:kniha_test_app/pages/detail_screen.dart';

import 'package:kniha_test_app/services/remote_service.dart';
import 'package:kniha_test_app/widget/search_widget.dart';

class NavigationHomeScreen extends StatefulWidget {
  late TabController? tabController;
  late PageController? pageController;

  NavigationHomeScreen({
    Key? key,
    this.tabController,
    this.pageController,
  }) : super(key: key);

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  var currentSelectedIndex = 0;

  List<BookElement> books = [];
  String query = '';
  Timer? debouncer;
  TextEditingController _mySearchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    starting();
    super.initState();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future starting() async {
    _mySearchController.text = 'mongodb';
    final books = await RemoteService.fetchBooks(_mySearchController.text);

    setState(() {
      this.books = books;
      isLoading = false;
    });
  }

  void onChipTap(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  void onTap() {
    setState(() {});
    widget.tabController!.animateTo(1);
    widget.pageController!.jumpToPage(1);
  }

  Future searchBook(String query) async {
    if (query != '') {
      debounce(
        () async {
          final books = await RemoteService.fetchBooks(query);

          if (!mounted) return;
          setState(
            () {
              this.query = query;
              this.books = books;
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              bottom: MediaQuery.of(context).size.height * .09 + 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 15),
            SearchWidget(
                text: query,
                hintText: 'Here enter your Book Name',
                onChanged: searchBook),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Filtered Books:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade300),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  if (isLoading == true) {
                    return const Center(
                        child: const CircularProgressIndicator());
                  }
                  {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Hero(
                                tag: '${books[index].title}',
                                child: Container(
                                  width: 350,
                                  height: 650,
                                  color: Colors.white54,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(books[index].image),
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                                top: 10,
                                end: 10,
                                child: Container(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 10, end: 10, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '4.8',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.yellow),
                                      )
                                    ],
                                  ),
                                )),
                            PositionedDirectional(
                              bottom: 25,
                              end: 30,
                              start: 20,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 75,
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 5, top: 5, bottom: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.purple,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            ' ${books[index].price}',
                                            softWrap: true,
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.yellow,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          width: 70,
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 10, top: 5, bottom: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.purple,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailScreen(
                                                              bookSelected:
                                                                  books[index]),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Detail',
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.yellow),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Text(
              'New Books:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade300),
            ),
          ]),
        ),
      ),
    );
  }
}
