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

  @override
  void initState() {
    super.initState();

    starting();
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

    setState(() => this.books = books);
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
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              bottom: MediaQuery.of(context).size.height * .09 + 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 15),

            SearchWidget(
                text: query,
                hintText: 'Here enter your Book Name',
                onChanged: searchBook),

            //    ),
            SizedBox(height: 35),

            // SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Hero(
                              tag: '$index',
                              child: Container(
                                height: 400,
                                child: Image.network(
                                  books[index].image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                          PositionedDirectional(
                              top: 20,
                              end: 20,
                              child: Container(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 10, end: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                      size: 15,
                                    ),
                                    SizedBox(width: 5),
                                    Text('4.8')
                                  ],
                                ),
                              )),
                          PositionedDirectional(
                            bottom: -10,
                            end: 50,
                            start: 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          ' ${books[index].price}',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        //Navigator.push(context)DetailPage('sss'));

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      bookSelected:
                                                          books[index])),
                                        );
                                      },
                                      child: Text(
                                        'Detail',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
          ]),
        ),
      ),
    );
  }
}
